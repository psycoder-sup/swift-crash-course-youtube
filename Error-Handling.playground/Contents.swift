import Foundation

struct Person {
    let firstName: String?
    let lastName: String?
    
    enum Errors: Error {
        case firstNameIsNil
        case lastNameIsNil
        case bothNamesAreNil
    }
    
    func getFullName() throws -> String {
        switch (firstName, lastName) {
        case (.none, .none):
            throw Errors.bothNamesAreNil
        case (.none, .some):
            throw Errors.firstNameIsNil
        case (.some, .none):
            throw Errors.lastNameIsNil
        case let (.some(firstName), .some(lastName)):
            return "\(firstName), \(lastName)"
        
        }
    }
}


let foo = Person(
    firstName: "Foo",
    lastName: nil
)

/// catch all the errors
do {
    let fullName = try foo.getFullName()
} catch {
    "Got an error = \(error)"
}

/// catch specific error with types
do {
    let fullName = try foo.getFullName()
    fullName
} catch is Person.Errors{
    "Got an error"
}

/// catch specific errors 2

let bar = Person(firstName: nil, lastName: nil)

do {
    let fullName = try bar.getFullName()
    fullName
} catch Person.Errors.firstNameIsNil{
    "First name is nil"
} catch Person.Errors.lastNameIsNil{
    "Last name is nil"
} catch Person.Errors.bothNamesAreNil{
    "Both name is nil"
} catch {
    "Some other error was thrown"
}



struct Car {
    let manufacturer: String
    
    enum Errors: Error {
        case invalidManufacturer
    }
    
    init(
        manufacturer: String
    ) throws {
        if manufacturer.isEmpty {
            throw Errors.invalidManufacturer
        }
        self.manufacturer = manufacturer
    }
}

/// Below code will occur an error
//let myCar = Car(manufacturer: "")

do {
    let myCar = try Car(manufacturer: "")
} catch Car.Errors.invalidManufacturer {
    "Invalid manufacturer."
} catch {
    "Some other error."
}

/// Another way of catching errors
if let yourCar = try? Car(manufacturer: "") {
    "Success, your car = \(yourCar)"
} else {
    "Failed"
}

/// don;t use `try!` expression
let theirCar = try? Car(manufacturer: "")
theirCar

/// when the manufacturer is "", the program will crash
let theirCar2 = try! Car(manufacturer: "Ford")
theirCar2.manufacturer



/// ?Wrapping errors?

struct Dog {
    let isInjured: Bool
    let isSleeping: Bool
    
    enum BarkingErrors: Error {
        case cannotBarkIsSleeping
    }
    
    enum RunningErrors: Error {
        case cannotRunIsInjured
    }
    
    func bark() throws {
        if isSleeping {
            throw BarkingErrors.cannotBarkIsSleeping
        }
        "Bark..."
    }
    func run() throws {
        if isInjured {
            throw RunningErrors.cannotRunIsInjured
        }
        "Run..."
    }
    
    func barkAndRun() throws {
        try bark()
        try run()
    }
}

let dog = Dog(isInjured: true, isSleeping: true)

do {
    try dog.barkAndRun()
} catch Dog.BarkingErrors.cannotBarkIsSleeping,
        Dog.RunningErrors.cannotRunIsInjured {
    "Cannot-bark-is-sleeping OR cannot-run-is-injured"
    
} catch {
    "Some other error."
}

/// In multiple error catching in the same line, only the first error will be caught

/// RETHROWS
/// the funciton itself doesn't throw anything, but it will throw other's errors
/// This is `rethrows` when we use this keyword,
/// The function should have one or more arguments that throws errors
/// In below code, its
/// ```
/// calculator: (String?, String?) throws -> String?
/// ```

func fullName(
    firstName: String?,
    lastName: String?,
    calculator: (String?, String?) throws -> String?
    /// This is an argument that throws an error,
    /// In this case we need to use `rethrows`
) rethrows -> String? {
    try calculator(
        firstName,
        lastName
    )
}

enum NameErrors: Error {
    case firstNameIsInvalid
    case lastNameIsInvalid
}

func + (
    firstName: String?,
    lastName: String?
) throws -> String {
    guard let firstName, !firstName.isEmpty else {
        throw NameErrors.firstNameIsInvalid
    }
    guard let lastName,
          !lastName.isEmpty else {
        throw NameErrors.lastNameIsInvalid
    }
    return "\(firstName) \(lastName)"
}


do {
    let foobar = try fullName(firstName: "Foo", lastName: nil, calculator: +)
} catch NameErrors.firstNameIsInvalid {
    "First name is invalid"
} catch NameErrors.lastNameIsInvalid {
    "Last name is invalid"
} catch let err {
    "\(err)"
}


/// RESULTS

enum IntegerErrors: Error {
    case noPositiveIntegerBefore(thisValue: Int)
}

/// We can use the `Result` to throw functions
func getPreviousPositiveInteger(
    from int: Int
) -> Result<Int, IntegerErrors> {
    guard int > 0 else {
        return Result.failure(
            IntegerErrors.noPositiveIntegerBefore(thisValue: int)
        )
    }
    return Result.success(int - 1)
}


/// `Return` expressions can be used with `switch` expression.
/// Also `enum`
func performGet(
    forValue value: Int
) {
    switch getPreviousPositiveInteger(from: value) {
    case let .success(previousValue):
        "Previous value is \(previousValue)"
    case let .failure(error):
        switch error {
        case let .noPositiveIntegerBefore(thisValue):
            "No positive integer before \(thisValue)"
        }
        
    }
}

performGet(forValue: 0)
performGet(forValue: 2)
