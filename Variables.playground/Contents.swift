import Foundation

// let cannot be re-assigned
// var can be assigned again

let myName = "SangUk"
let yourName = "Foo"

var names = [
    myName,
    yourName
]

names.append("Bar")
names.append("Vars")

// arrays are structures by default

let foo = "Foo"
// Swift string is a type of structure
// and structures are value types classes are referenec types
var foo2 = foo
// this means copying the value of foo to foo2

foo2 = "Foo 2"

let moreNames = [
    "Foo",
    "Bar"
]
var copy = moreNames
copy.append("Baz")
moreNames
copy

let oldArray = NSMutableArray(
    array: [
        "Foo",
        "Bar"
    ]
)
// oldArray here is 'class instances' not a structure
// NSMutableArray means 'mutable'
oldArray.add("Baz")

var newArray = oldArray
newArray.add("Qux")
oldArray
newArray

let someNames = NSMutableArray(
    array: [
        "Foo",
        "Bar"
    ]
)

func changeTheArray(_ array: NSArray) {
    let copy = array as! NSMutableArray
    // setting datatype to NSMutableArray, actually this is a really bad code
    copy.add("Baz")
}

changeTheArray(someNames)
someNames
