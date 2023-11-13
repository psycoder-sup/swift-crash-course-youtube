import Foundation

let myAge = 22
let yourAge = 20

if myAge > yourAge {
    "I'm older than you"
} else if myAge < yourAge {
    "I'm younger than you"
} else {
    "Oh hey, we are the same age"
}

let myMotherAge = myAge + 30
let doubleMyAge = myAge * 2

/// 1. unary prefix
let foo = !true
/// 2. unary postfix
let name = Optional("Steve")
type(of:name)
let unaryPostfix = name!
type(of:unaryPostfix)
/// 3. binary infix
let result = 1 + 12
let names = "Foo" + " " + "Bar"

let age = 30
//let message: String

//if age >= 18 {
//    message = "You are an adult"
//} else {
//    message = "You are not an adult"
//}
//message

/// 4. trinary operator
let message = age >= 18
    ? "You are an adult"
    : "You are not an adult"
