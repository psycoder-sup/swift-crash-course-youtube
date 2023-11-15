import Foundation

/// PROTOCOLS
/// Kind of like interfaces from JAVA
/// We can create a set of rules or interfaces, and it is not a class

protocol CanBreathe {
    /// Protocols can have a function which don't have any body.
    func breathe()
}

/// Normally structure don't allow the inheritance between structures,
/// but it accepts `protocols`
struct Animal: CanBreathe {
    func breathe() {
        print("Animal breathing...")
    }
}

struct Person: CanBreathe {
    func breathe() {
        print("Person breathing...")
    }
}

let dog = Animal()
dog.breathe()

let foo = Person()
foo.breathe()


protocol CanJump {
    ///```
    ///func jump() {
    /// "Jumping..."
    ///}
    ///```
    /// wee cannot define functions code inside of protocol
    /// To define it, we need to use `extension`
    func jump()
}

/// We can use default delcaration
extension CanJump {
    func jump() {
        print("Jumping...")
    }
}

struct Cat: CanJump {
    
}

let whiskers = Cat()
whiskers.jump()

/// Protocols can also define variables
protocol HasName {
    /// This protocol has a variable named `name` and it has a **getter** and **setter**.
    var name: String { get }
    var age: Int { get set }
}

struct Dog: HasName{
    /// As `name` has getter which means that it can only be readable from outside
    /// We'd better to use it as `let`
//    var name: String
    let name: String
    var age: Int
}


var woof = Dog(
    name: "Woof",
    age: 10
)

woof.name
woof.age
//woof.age += 1
woof.age

extension HasName{
    func describeMe() -> String {
        "Your name is \(name) and you are \(age) years old"
    }
    mutating func increaseAge() {
        self.age += 1
    }
}

woof.describeMe()
woof.increaseAge()
woof.age


protocol Vehicle {
    var speed: Int { get set }
    mutating func increaseSpeed(by value: Int)
}

extension Vehicle{
    mutating func increaseSpeed(
        by value: Int
    ) {
        self.speed += value
    }
}

struct Bike: Vehicle {
    var speed: Int
    init() {
        self.speed = 0
    }
}

var bike = Bike()
bike.speed
bike.increaseSpeed(by: 10)
bike.speed

struct Worm {
    
}


func describe(obj: Any) {
    /// use `is` to compare the definition and its instances.
    if obj is Vehicle {
        "obj conforms to the Vehicle protocol"
    } else {
        "obj does NOT conform to the Vehicle protocol"
    }
}
describe(obj: bike)
let worm = Worm()
describe(obj: worm)

/// `as`
/// We can conditionally promote an object to specific type
///

func increaseSpeedIfVehicle (
    obj: Any
) {
    /// In here the `vehicle` variable does not look up the original obj, instead it has a copy of the value
    if var vehicle = obj as? Vehicle {
        vehicle.speed
        vehicle.increaseSpeed(by: 10)
        vehicle.speed
    } else {
        "This was not a Vehicle"
    }
}

increaseSpeedIfVehicle(obj: bike)
bike.speed  // 10

/// Structure is a value type. So whenever you pass it to the function, it will copy its value,
/// If the bike is class then the result will be 20
