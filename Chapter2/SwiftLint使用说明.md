# 第二节：SwiftLint使用说明

##### 1、swiftlint介绍 

SwiftLint 是一个用于强制检查 Swift 代码风格和规定的一个工具，基本上以 [Ray Wenderlich's Swift 代码风格指南](https://github.com/raywenderlich/swift-style-guide)为基础。

SwiftLint Hook 了 [Clang](http://clang.llvm.org/) 和 [SourceKit](http://www.jpsim.com/uncovering-sourcekit) 从而能够使用 [AST](http://clang.llvm.org/docs/IntroductionToTheClangAST.html) 来表示源代码文件的更多精确结果。

说明：由于一些规则无用或者时规则冲突，且有的规则设计到代码逻辑的改动，因此只选用了和风格相关联的36条规则，便于大家代码风格的统一。

##### 2、swiftlint 配置 

 使用pods安装：

```ruby
pod 'SwiftLint'
```

在Build Phases中添加如下脚本：

```shell
"${PODS_ROOT}/SwiftLint/swiftlint"
```

在工程更目录下添加.swiftlint.yml文件，可以通过command+shift+.查看隐藏文件。

SwiftLint配置规则：

* disabled_rules: 关闭某些默认开启的规则。

* opt_in_rules: 一些规则是可选的。

* only_rules: 不可以和 disabled_rules 或者 opt_in_rules 并列。类似一个白名单，只有在这个列表中的规则才是开启的。

代码中忽略某个规则：

```shell
// swiftlint:disable operator_usage_whitespace
```

##### 3、引入的规范 

###### 3.1、括号中间如果有大括号，括号和大括号间不应该有空格 

swiftlint标识符：closure_brace

代码示例：

```swift
[].map({ })
[].map(
  { }
)
```

不要写成下面形式：

```swift
[].map( { })
[].map({ }   )
```

###### 3.2、闭包参数应该和闭包开始大括号在同一行 

 swiftlint标识符：closure_parameter_position

代码示例：

```swift
[1, 2].map { $0 + 1 }
[1, 2].map { [weak self] number in
 number + 1 
}
```

###### 3.3、闭包表达式和大括号间应该有一个空格 

swiftlint 标识符：closure_spacing

代码示例：

```swift
[].map ({ $0.description })
```

不要写成下面这种形式：

```swift
[].filter({$0.contains(location)})
```

###### 3.4、指定类型时，冒号应该在标识符旁边，并且在字典文字中的键旁边，冒号后要有一个空格 

swiftlint标识符：colon

参考示例链接：https://realm.github.io/SwiftLint/colon.html

示例代码：

```swift
func foo(bar: [String: Int]) {}
```

###### 3.5、任何逗号前不能有空格 

swiftlint标识符：comma

示例代码：

```swift
func abc(a: String, b: String) { }
```

###### 3.6、建议在注释斜杠后至少留一个空格以进行评论 

swiftlint标识符：comment_spacing

示例代码：

```swift
// This is a comment
/// Triple slash comment
```

###### 3.7、控制语句条件不应将条件表达式放到括号中 

if、for、guard、switch、while、catch 语句的条件表达式不应该放到括号中

swiftlint标识符：control_statement

示例代码：

```swift
if (a || b) && (c || d) {
```

不要写成下面的风格：

```swift
if ((a || b) && (c || d)) {
```

###### 3.8、枚举参数不使用时，在枚举与关联值匹配时忽略参数 

swiftlint标识符：empty_enum_arguments

示例代码：

```swift
switch foo {
case .bar(let x): break
}
// 或
switch foo {
case .bar: break
}
```

注意不要写成下述风格：

```swift
switch foo {
case .bar(_): break
}
// 或
switch foo {
case .bar(): break
}
```

###### 3.9、使用尾随闭包时，要避免在方法调用后使用空括号 

swiftlint标识符：empty_parentheses_with_trailing_closure

示例代码：

```swift
[1, 2].map { $0 + 1 }
// 或
[1, 2].map({ $0 + 1 })
// 或
[1, 2].map { number in
	number + 1 
}
```

避免使用下述风格代码：

```swift
[1, 2].map() { $0 + 1 }
// 或
[1, 2].map() { number in
 	number + 1 
}
```

###### 3.10、枚举存在类型时，需要明确给枚举分配值 

swiftlint标识符：explicit_enum_raw_value

示例代码：

```swift
enum Numbers: Int {
  case one = 1
  case two = 2
}
```

注意不要书写下述风格代码：

```swift
enum Numbers: Int {
  case one = 10, two, three = 30
}
```

###### 3.11、初始化时避免使用.init 

swiftlint标识符：explicit_init

示例代码：

```swift
[1].flatMap(String.init)
```

避免使用下述风格代码：

```swift
[1].flatMap{ String.init($0) }
```

###### 3.12、避免隐式解包声明 

swiftlint标识符：implicitly_unwrapped_optional

代码示例：

```swift
let int: Int? = 42
```

避免下述代码：

```swift
let int: Int! = 42
```

###### 3.13、不要在方法名和括号中间添加空格 

swiftlint标识符：no_space_in_method_call

代码示例：

```swift
foo()
```

错误示例：

```
foo ()
```

###### 3.14、大括号前应该有一个空格，并且和大括号在同一行 

swiftlint标识符：opening_brace

示例代码：

```swift
guard let a = b else { }
```

错误示例：

```swift
guard let a = b else{ }
```

###### 3.15、使用运算符时，运算符应该被一个空格包围 

swiftlint标识符：operator_usage_whitespace

示例代码：

```swift
let foo = 1 + 2
```

错误示例：

```swift
let foo = 1+2
```

###### 3.16、重载或定义运算符时，运算符应该被一个空格包围 

swiftlint标识符：operator_whitespace

示例代码：

```swift
func <| (lhs: Int, rhs: Int) -> Int {}
```

错误示例：

```swift
func <|(lhs: Int, rhs: Int) -> Int {}
```

###### 3.17、返回值箭头和返回值类型之间要有一个空格隔开或者单独一行隔开 

swiftlint标识符：return_arrow_whitespace

示例代码：

```swift
func abc() -> Int {}
```

错误示例：

```swift
func abc()->Int {}
```

###### 3.18、else或catch 应该和大括号在同一行，并且前后有一个空格 

swiftlint标识符：statement_position

示例代码：

```swift
} else if {
```

错误示例：

```swift
}else if {
```

###### 3.19、使用简单的语法糖声明类型 

swiftlint标识符：syntactic_sugar

示例代码：

```swift
let x: [Int]
let x: [Int: String]
let x: Int?
```

错误示例：

```swift
let x: Array<String>
let x: Dictionary<Int, String>
let x: Optional<Int>
```

###### 3.20、避免在数组或者字典元素末尾使用逗号 

swiftlint标识符：trailing_comma

示例代码：

```swift
let foo = [1, 2, 3]
```

错误示例：

```swift
let foo = [1, 2, 3,]
```

###### 3.21、文件末尾有且仅有一个空行 

swiftlint标识符：trailing_newline

示例代码：

```
let a = 0
```

错误示例：

```
let a = 0
```

###### 3.22、语句结束末尾不要有分号 

swiftlint标识符：trailing_semicolon

示例代码：

```swift
let a = 0; let b = 0
```

错误示例：

```swift
let a = 0;
```

###### 3.23、类型名称应该只包含字母、数字，以大写字母开头，长度在3到40个字符之间 

swiftlint标识符：type_name

示例代码：

```swift
class MyType {}
```

错误示例：

```swift
class myType {}
```

###### 3.24、避免使用不必要的break语句 

swiftlint标识符：unneeded_break_in_switch

示例代码：

```swift
switch foo {
case .bar:
    break
}
```

错误示例：

```swift
switch foo {
case .bar:
    // something()
    break
}
```

###### 3.25、捕获列表中未使用的引用需要删除掉 

swiftlint标识符：unused_capture_list

示例代码：

```swift
[1, 2].map { [weak self] num in
    self?.handle(num)
}
```

错误示例：

```swift
[1, 2].map { [self] num in
    handle(num)
}
```

###### 3.26、不使用的闭包参数请求用_进行代替 

swintlint标识符：unused_closure_parameter

示例代码：

```swift
[1, 2].map { _ in
 3 
}
```

错误示例：

```swift
[1, 2].map { number in
 return 3 // number
}
```

###### 3.27、声明的函数或变量至少应该被引用一次 

swiftlint标识符：unused_declaration

示例代码：

```swift
let kConstant = 0
_ = kConstant
```

###### 3.28、不使用可选绑定时，请使用!= nil替代let _ = 

swiftlint标识符：unused_optional_binding

示例代码：

```swift
if let bar = Foo.optionalValue {
}
```

错误示例：

```swift
if let _ = Foo.optionalValue {
}
```

###### 3.29、不要使用属性值给setter方法赋值 

swiftlint标识符：unused_setter_value

示例代码：

```swift
var aValue: String {
    get {
        return Persister.shared.aValue
    }
    set {
        Persister.shared.aValue = newValue
    }
}
```

错误示例：

```swift
var aValue: String {
    get {
        return Persister.shared.aValue
    }
    set {
        Persister.shared.aValue = aValue
    }
}
```

###### 3.30、声明函数时如果参数在多行，参数需要垂直对齐 

swiftlint标识符：vertical_parameter_alignment

示例代码：

```swift
func foo(a: Void,
         b: [String: String] =
         [:]) {
}
```

错误示例：

```swift
func foo(a: Void,
    b: [String: String] =
         [:]) {
}
```

###### 3.31、调用函数时，参数在多行，参数需要垂直对齐 

swiftlint标识符：vertical_parameter_alignment_on_call

示例代码：

```swift
foo(param1: 1, 
    param2: bar
    param3: false,
    param4: true)
```

错误示例：

```swift
foo(param1: 1, 
    		param2: bar
    param3: false,
 param4: true)
```

###### 3.32、垂直空白符应限制在一个空行 

swiftlint标识符：vertical_whitespace

示例代码：

```swift
let a = 0

let b = 0
```

错误示例：

```swift
let a = 0


let b = 0
```

###### 3.33、关闭括号之前不要有空行 

swiftlint标识符：vertical_whitespace_closing_braces

示例代码：

```swift
[
	1,
	2,
	3
]
// 或
do {
  print("x is 5")
}
```

错误示例：

```swift
[
	1,
	2,
	3
    
]
// 或
do {
  print("x is 5")
    
}
```

###### 3.34、开始括号之后不要有空行 

swiftlint标识符：vertical_whitespace_opening_braces

示例代码：

```swift
[
	1,
	2,
	3
]
// 或
do {
  print("x is 5")
}
```

错误示例：

```swift
[
    
	1,
	2,
	3
]
// 或
do {
    
  print("x is 5")
}
```

###### 3.35、代理使用weak修饰 

swiftlint标识符：weak_delegate

示例代码：

```swift
class Foo {
  weak var delegate: SomeProtocol?
}
```

错误示例：

```swift
class Foo {
 	var delegate: SomeProtocol?
}
```

###### 3.36、尤达条件规则 

变量应该放在比较运算符的左边，常量放在比较运算符的右边。

swiftlint标识符：yoda_condition

示例代码：

```swift
if foo == 42 {}
```

错误示例：

```swift
if 42 == foo {}
```

##### 4、参考 

* [SwiftLint中文说明](https://github.com/realm/SwiftLint/blob/master/README_CN.md)

* [SwiftLint Rule Directory](https://realm.github.io/SwiftLint/rule-directory.html)

* [Swift Style Guide](https://github.com/raywenderlich/swift-style-guide#naming)
