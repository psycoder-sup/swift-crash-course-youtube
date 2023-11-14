import Foundation


/// Constructors of structure is automatically built by compiler
struct Person {
    let name: String
    let age: Int
}

let foo = Person(
    name: "Foo",
    age: 20
)

foo.name
foo.age

struct CommodoreComputer{
    let name: String
    let manufacturer: String
/// if we don't use the custom initalizer, we can define default value as below
//    let manufacturer: String = "Commodore
    init(name: String){
        self.name = name
        self.manufacturer = "Commodore"
    }
}

let c64 = CommodoreComputer(
    name: "C64"
)

c64.name
c64.manufacturer


//struct Person2 {
//    let firstName: String
//    let lastName: String
//    let fullName: String
//    init(
//        firstName: String,
//        lastName: String
//    ){
//        self.firstName = firstName
//        self.lastName = lastName
//        self.fullName = "\(firstName) \(lastName)"
//    }
//}


struct Person2{
    let firstName: String
    let lastName: String
    
    // make it function
    // this is computable property
    var fullName: String{
        "\(firstName) \(lastName)"
    }
}

let fooBar = Person2(
    firstName: "Foo", lastName: "Bar"
)

fooBar.firstName
fooBar.lastName
fooBar.fullName

/// Mutable structure element

struct Car {
    var currentSpeed: Int
    
    /// mutating means we can edit structure's
    /// It is not the common way of doing it
    /// Normally when we use structures it is expected not to use mutation
    mutating func drive(speed: Int) {
        "Driving ..."
        currentSpeed = speed
    }
    
}

/// if you initiate the mutable structure with immutable definition, such as let
/// the error occurs. This is because we defined 'mutating' to the functino drive.

/// let immutableCar = Car(currentSpeed: 10)
/// immutableCar.drive(speed: 20)
/// immutableCar = Car(current Speed: 10) // this also occur error

var mutableCar = Car(currentSpeed: 10)
mutableCar.drive(speed: 30)
mutableCar.currentSpeed
// copy mutableCar into immutable variable
// if you assign structure into variable, the internal value of original data is copied to target variable
// this is duplicate, whether it `var` or `let`.
let copy = mutableCar
mutableCar.drive(speed: 50)
mutableCar.currentSpeed // 50
copy.currentSpeed       // 30

// swift structure don't have subclasses

struct LivingThing {
    init(){
        "I'm a living thing"
    }
}

// Below code is not valid, structure cannot be inherited
//struct Animal: LivingThing{
//    
//}

struct Bike {
    let manufacturer: String
    let currentSpeed: Int
    func copy(currentSpeed: Int) -> Bike {
        Bike(
            manufacturer: self.manufacturer,
            currentSpeed: currentSpeed
        )
    }
}

let bike1 = Bike(
    manufacturer: "HD",
    currentSpeed: 20
)

//let bike2 = bike1
//bike2.currentSpeed = 30 // its not working

let bike2 = bike1.copy(currentSpeed: 30)
bike1.currentSpeed
bike2.currentSpeed
