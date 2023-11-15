import Foundation

let x = 10
let y = 20
let z = x + y

func performInt(
    _ op: (Int, Int) -> Int,
    on lhs: Int,
    and rhs: Int
) -> Int {
    op(lhs, rhs)
}

func performDouble(
    _ op: (Double, Double) -> Double,
    on lhs: Double,
    and rhs: Double
) -> Double {
    op(lhs, rhs)
}

func perform<N: Numeric> (
    _ op: (N, N) -> N,
    on lhs: N,
    and rhs: N
) -> N {
    op(lhs, rhs)
}

perform(+, on: 10, and: 20)
perform(-, on: 10, and: 20)
perform(*, on: 10, and: 20)
perform(/, on: 10, and: 20)


func perform2<N> (
    _ op: (N, N) -> N,
    on lhs: N,
    and rhs: N
) -> N where N: Numeric{
    op(lhs, rhs)
}

perform2(+, on: 10, and: 20)
perform2(-, on: 10, and: 20)
perform2(*, on: 10, and: 20)
perform2(/, on: 10, and: 20)


protocol CanJump {
    func jump()
}

protocol CanRun {
    func run()
}

struct Person: CanJump, CanRun {
    func jump() {
        "Jumping..."
    }
    func run() {
        "Running..."
    }
}

func JumpAndRun<T: CanJump & CanRun>(value: T) {
    value.jump()
    value.run()
}

let person = Person()
JumpAndRun(value: person)



/// Below code will occur error
/// ```
/// struct A {
///     func jump() {"Jumping..."}
///     func run() {"Running..."}
/// }
/// JumpAndRun(value: A)
/// ```

let names = ["Foo", "Bar"]
let names2: Array<String> = ["Foo", "Bar"]

/// Old version
//extension Array where Element == String {
//    
//}

/// New syntax
extension [String]{
    func longestString() -> String? {
        self.sorted{ (lhs: String, rhs: String) -> Bool in
            lhs.count > rhs.count
        }.first
    }
}

[
    "Foo",
    "Bar Baz",
    "Qux"
].longestString()

protocol View {
    func addSubView(_ view: View)
}

extension View {
    func addSubView(_ view: View) {
        // epmty
    }
}

struct Button: View {
    // empty
}

struct Table: View{
    // empty
}

protocol PresentableAsView {
    associatedtype ViewType: View
    func produceView() -> ViewType
    func configure(
        superView: View,
        thisView: ViewType
    )
    func present(
        view: ViewType,
        on superView: View
    )
}

extension PresentableAsView {
    func configure(
        superView: View,
        thisView: ViewType
    ) {
        // empty function
    }
    
    func present(
        view: ViewType,
        on superView: View
    ) {
        superView.addSubView(view)
    }
}

struct MyButton: PresentableAsView {
    func produceView() -> Button {
        Button()
    }
    func configure(superView: View, thisView: Button) {
        // empty
    }
}

extension PresentableAsView where ViewType == Button {
    func doSomethingWithButton() {
        "This is a button"
    }
}

let button = MyButton()
button.doSomethingWithButton()

struct MyTable: PresentableAsView {
    func produceView() -> Table {
        Table()
    }
}

let myTable = MyTable()
//myTable.doSomethingWithButton() <- it doesn't exist

extension [Int] {
    func average() -> Double {
        Double(self.reduce(0, +)) / Double(self.count)
    }
}

[1, 2, 3, 4].average()
