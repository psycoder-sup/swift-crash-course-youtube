import Foundation


func noArgumentsAndNoReturnValue(){
    "I don't know what I'm doing"
}

noArgumentsAndNoReturnValue()

func plusTwo(value: Int) {
    let newValue = value + 2
}

plusTwo(value: 32)

func newPlusTwo(value: Int) -> Int {
    return value + 2
}

newPlusTwo(value: 30)

func customAdd(
    value1: Int,
    value2: Int
) -> Int {
    value1 + value2
}

let customAdded = customAdd(value1: 10, value2: 20)

func customMinus(
    _ lhs: Int,
    _ rhs: Int
    /// _ value_name: type means you shouldn't express the parameter name when you call the function
) -> Int {
    lhs - rhs
}

let customSubtracted = customMinus(20, 10)


func customMinus2(
    left lhs: Int,
    _ rhs: Int
) -> Int {
    lhs - rhs
}

let customSubtracted2 = customMinus2(left: 10, 20)


func doSomethingComplicated(
    with value: Int
) -> Int {
    func mainLogic(value: Int) -> Int {
        value + 2
    }
    return mainLogic(value: value)
}

doSomethingComplicated(with: 32)

/// default values

func getFullName(firstName: String = "Foo", lastName: String = "Bar") -> String{
    "\(firstName) \(lastName)"
}

getFullName()
getFullName(firstName: "Bazz")
