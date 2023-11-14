import Foundation

//struct Animal{
//    let type: String
//    init(type: String) {
//        if type == "Rabbit" || type == "Dog" || type == "Cat"{
//            self.type = type
//        } else {
//            preconditionFailure()
//        }
//    }
//}
//
//Animal(type: "Bike")


enum Animals {
//    below code has same meaning
//    case cat
//    case dog
//    case rabbit
    case cat, dog, rabbit, hedgehog
}

// create instances

let cat = Animals.cat
cat

if cat == Animals.cat {
    "this is a cat"
} else if cat == Animals.dog {
    "This is a dog"
} else {
    "This is something else"
}

switch cat {
// we have to cover all the cases or we have to use `default`
case .cat:
    "this is a cat"
    break
case .dog:
    "this is a dog"
    break
    
default:
    // this is usually not a good idea
    // switch statement is exhaustive statement so we have to cover all the cases
    // so that it is recommended not to use default
    // and cover all the cases
    "This is something else"
}

func describeAnimal(_ animal: Animals) {
    switch animal {
    case .cat:
        "This is a cat"
        break
    case .dog:
        "This is a dog"
        break
    case .rabbit:
        "This is a rabbit"
        break
    case .hedgehog:
        "this is a hedgehog"
    }
}
describeAnimal(Animals.cat)

enum Shortcut {
    case fileOrFolder(path: URL, name: String)
    case wwwUrl(path: URL)
    case song(artist: String, songName: String)
}

let wwwApple = Shortcut.wwwUrl(
    path: URL(string: "https://apple.com")!
)

/// If we want to compare or use `==` operation with enum instances associated with certain values,
/// we should define its own `==` operation,
/// but if we don't have the associated values with enum, we can use `==` operation

switch wwwApple {
    
case .fileOrFolder(
    path: let path,
    name: let name
):
    path
    name
    break
case .wwwUrl(
    path: let p
):
    p
    break
case .song(
    artist: let artist,
    songName: let songName
):
    artist
    songName
    break
}

/// a more clean way to use enum cases with associate values
switch wwwApple {
case .fileOrFolder(
    let path,
    let name
):
    path
    name
    break
case .wwwUrl(
    let p
):
    p
    break
case .song(
    let artist,
    let songName
):
    artist
    songName
    break
}

/// even better way to use enum cases with associate values
switch wwwApple {
case let .fileOrFolder(
    path,
    name
):
    path
    name
    break
case let .wwwUrl(
    path
):
    path
    break
case let .song(
    artist,
    songName
):
    artist
    songName
    break
}

if case let .wwwUrl(path) = wwwApple {
    path
}

// below code will occur error
//if case let wwwApple = .wwwUrl(path) {
//    path
//}

let withoutYou = Shortcut.song(
    artist: "Sympnhony X",
    songName: "Without You"
)

// ignore one of the proptery by using the `_` keyword
if case let .song(_, songName) = withoutYou {
    songName
    
}

enum Vehicle {
    case car(manufacturer: String, model: String)
    case bike(manufacturer: String, yearMade: Int)
    // we can use the function or computable property
    func getManufacturer() -> String {
        switch self {
        case let .car(manufacturer, _):
            return manufacturer
        case let .bike(manufacturer, _):
            return manufacturer
        }
    }
    // this is a way of using computable property
    var manufacturer: String{
        switch self {
        case let .car(manufacturer, _):
            return manufacturer
        case let .bike(manufacturer, _):
            return manufacturer
        }
    }
    // even better way
    var manufacturer2: String{
        switch self {
        case let .car(manufacturer, _), 
            let .bike(manufacturer, _):
            return manufacturer
        }
    }
    
    // if the type is same, you can call it
    // below code works
    var callSomething: String{
        switch self {
        case let .car(_, foo),
            let .bike(foo, _):
            return foo
        }
    }
}

let car = Vehicle.car(manufacturer: "Tesla", model: "X")
let bike = Vehicle.bike(manufacturer: "HD", yearMade: 1987)

// how to grap the manufacturer value from both `car` and `bike`
// because those are different enum cases


func getManufacturer(from vehicle: Vehicle) -> String {
    switch vehicle {
    case let .car(manufacturer, _):
        return manufacturer
    case let .bike(manufacturer, _):
        return manufacturer
    }
}

getManufacturer(from: car)
getManufacturer(from: bike)
car.getManufacturer()
car.manufacturer
bike.getManufacturer()
bike.manufacturer

car.callSomething

// predefine Enumerations

enum FamilyMember: String {
    case father = "Dad"
    case mother = "Mom"
    case brother = "Bro"
    case sister = "Sis"
}

FamilyMember.father.rawValue // "Dad"
FamilyMember.father          // ".father"

// when you want to call all the cases
enum FavoriteEmoji: String, CaseIterable {
    case blush = "☺️"
    case rocket = "🚀"
    case fire = "🔥"
}

FavoriteEmoji.allCases
FavoriteEmoji.allCases.map(\.rawValue)

// grap enum via rawValues
if let blush = FavoriteEmoji(rawValue: "☺️") {
    "Found the blush emoji"
    blush
} else {
    "This emoji doesn't exist"
}


if let snow = FavoriteEmoji(rawValue: "❄️") {
    "Snow exists?! Really?"
    snow
} else {
    "As expected, snow dosen't exist in our enum"
}

enum Height {
    case short, medium, long
    mutating func makeLong() {
        self = Height.long
    }
}
// 2:54:27
// we cannot use `let myHeight` here, cuz inside of the enum,
// there's `mutating` function
var myHeight = Height.medium
myHeight.makeLong()
myHeight

// recursive enumerations or indirect enumerations
// Rarely used

indirect enum IntOperation {
    case add(Int, Int)
    case subtract(Int, Int)
    case freehand(IntOperation)
    
    func calculateResult(
        of operation: IntOperation? = nil
    ) -> Int {
        switch operation ?? self {
        case let .add(lhs, rhs):
            return lhs + rhs
        case let .subtract(lhs, rhs):
            return lhs - rhs
        case let .freehand(operation):
            return calculateResult(of: operation)
        }
    }
}

let freeHand = IntOperation.freehand(.add(2,4))
freeHand.calculateResult()
