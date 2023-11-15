import Foundation


extension Int {
    func plusTwo() -> Int {
        self + 2
    }
}

let two = 2
two.plusTwo()


struct Person {
    let firstName: String
    let lastName: String
//    init(firstName: String, lastName: String){
//        self.firstName = firstName
//        self.lastName = lastName
//    }
}

extension Person {
    /// We don't need to use the `convinence init` becuase
    /// There is no desginated initializer
    init(fullName: String){
        let components = fullName.components(separatedBy: " ")
        self.init(
            firstName: components.first ?? fullName,
            lastName: components.last ?? fullName
        )
    }
}

let person = Person(fullName: "Foo Bar")
person.firstName
person.lastName

protocol GoesVroom {
    var vroomValue: String { get }
    func goVroom() -> String
}

extension GoesVroom{
    func goVroom() -> String {
        "\(vroomValue) goes vroom!"
    }
}

struct Car {
    let manufacturer: String
    let model: String
}

let modelX = Car(
    manufacturer: "Tesla",
    model: "X"
)

extension Car: GoesVroom{
    var vroomValue: String {
        /// both code works
        /// `"\(self.manufacturer) model \(self.model)"`
        "\(manufacturer) model \(model)"
    }
}

modelX.goVroom()

class MyDouble {
    let value: Double
    init(value: Double) {
        self.value = value
    }
}

extension MyDouble {
    /// Only class can have two initializer types
    /// > "Swift defines two kinds of initializers for *class* types to help ensure
    /// > all stored properties receive an initial value. These are known as
    /// > designated initializers and convenience initializers."
    convenience init() {
        self.init(value:0)
    }
}

let myDouble = MyDouble()
myDouble.value

extension GoesVroom {
    func goVroomVroomEvenMore() -> String {
        "\(self.vroomValue) is vrooming even more"
    }
}

modelX.goVroomVroomEvenMore()
