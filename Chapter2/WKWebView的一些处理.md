# 第一节：WKWebView的一些处理

##### 1、Cookie设置

###### 1.1、在请求实例中设置cookie

```swift
extension URLRequest {
    mutating func setCookies(_ cookies: [String: Any]) {
        let cookieString = cookies.map { "\($0.key)=\($0.value)" }.joined(separator: ";")
        setValue(cookieString, forHTTPHeaderField: "Cookie")
    }
}
```

###### 1.2、通过脚本设置cookie

```swift
extension WKUserScript {
    convenience init(cookie key: String, value: Any) {
        let domin: String = ".***" // ***为域名通用部分        
        let userScript = "document.cookie = '\(key)=\(value);path=/;domain=\(domin);expiresDate=\(Date(timeIntervalSinceNow: 2629743))'"
        self.init(source: userScript, injectionTime: .atDocumentStart, forMainFrameOnly: false)
    }
}

// 或
// 这种设置方式适合与webview已经加载完成，但是需要更新cookie的情况
func evaluateCookieJavaScript() {
    if let sid = NetworkingManager.manager.sid {
        let cookieString = "document.cookie = 'sid=\(sid);path=/;domain=.****;expiresDate=\(Date(timeIntervalSinceNow: 2629743))'"
        self.evaluateJavaScript(cookieString, completionHandler: nil)
    }
}
```

###### 1.3、通过WKWebsiteDataStore设置cookie

```swift
extension HTTPCookie {
    convenience init?(name: String, value: String) {
        let domin: String = ".***"        
        let properties: [HTTPCookiePropertyKey : Any] = [HTTPCookiePropertyKey.domain: domin,
                                                         HTTPCookiePropertyKey.path: "/",
                                                         HTTPCookiePropertyKey.name: name,
                                                         HTTPCookiePropertyKey.value: value,
                                                         HTTPCookiePropertyKey.expires: Date(timeIntervalSinceNow: 2629743),
                                                         HTTPCookiePropertyKey.version: 0,
                                                         HTTPCookiePropertyKey("HttpOnly"): false]
        self.init(properties: properties)
    }
}

let configuration = WKWebViewConfiguration()
for element in cookies {
    if let cookie = HTTPCookie(name: element.key, value: element.value) {
        configuration.websiteDataStore.httpCookieStore.setCookie(cookie, completionHandler: nil)
    }
}
```

##### 2、WKWebView内自动播放音视频

```swift
let configuration = WKWebViewConfiguration()
configuration.mediaTypesRequiringUserActionForPlayback = []
```

##### 3、webview 白屏解决

###### 3.1、WKCompositingView 被收回导致白屏解决方案

```swift
// 这种情况一般出现在通过evaluateJavaScript调用前端方法刷新页面数据时
// 可在evaluateJavaScript方法调用后调用下面两种方案中的一种解决
// 调用webview的私有方法
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic push
if ([self respondsToSelector:@selector(_updateVisibleContentRects)]) {
    [self performSelector:@selector(_updateVisibleContentRects)];
}
#pragma clang diagnostic pop

// 或
webView.setNeedsLayout()
```

##### 4、WKWebView设置自定义字体

一般加载本地HTML时，可以通过更改路径的方式设置自定义字体。

下述方案是将字体准换为base64字符串，通过脚本注入的方式，设置自定义字体。这种方式适合非本地网页。

```swift
extension WKUserScript {
  	// fontPath：本地字体包路径
  	// fontName：字体名，非字体包名
    convenience init?(fontPath: URL, fontName: String) {
        do {
            let data = try Data(contentsOf: fontPath)
            let base64 = data.base64EncodedString(options: [])
            let javascript = String(format: "var boldcss = '@font-face { font-family: \"%@\"; font-display: block; src: url(data:font/ttf;base64,%@) format(\"truetype\"); }'; var body = document.getElementsByTagName('body')[0], style = document.createElement('style'); style.type = 'text/css'; style.innerHTML = boldcss; body.appendChild(style);", fontName, base64, fontName)
            self.init(source: javascript, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        } catch {
            return nil
        }
    }
}
```

