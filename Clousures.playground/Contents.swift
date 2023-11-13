import Foundation

//func add(_ lhs: Int, _ rhs: Int) -> Int {
//    lhs + rhs
//}


// this is closure
let add: (Int, Int) -> Int = {
    (lhs: Int, rhs: Int) -> Int in
    lhs + rhs
}

add(1, 2)

func customAdd(
    _ lhs: Int,
    _ rhs: Int,
    using function: (Int, Int) -> Int
) {
    function(lhs, rhs)
}


customAdd(
    20, 
    30,
    using: {(lhs: Int, rhs: Int) -> Int in
            lhs + rhs
    }
)

customAdd(20, 30, using: add)

/// this is a recommended version of using closure
customAdd(
    20,
    30
) { (lhs: Int, rhs: Int) -> Int in
        return lhs + rhs
}

// we can remove the predefined datatypes of closure
customAdd(
    20,
    30
) { (lhs, rhs) in
    lhs + rhs
}


// wecan delete the information without specifying variable names
customAdd(
    20,
    30
) {
    $0 + $1
}

customAdd(20, 30) { $0 + $1 }


let ages = [30, 20, 19, 40]
ages.sorted(by: {(lhs: Int, rhs: Int) -> Bool in
        lhs < rhs
})

let a2 = ages.sorted(by: {$0 > $1})
a2

ages.sorted(by: >)
ages.sorted(by: <)


func customAdd2(
    using function: (Int, Int) -> Int,
    _ lhs: Int,
    _ rhs: Int
) -> Int {
    function(lhs, rhs)
}

// do not recommend
// it is recommended to use closure argument at the end of the argument.
customAdd2(
    using: { (lhs, rhs) in
    lhs + rhs
}, 20, 30)

customAdd2(
    using: {$0 + $1 + 10}, 20, 30)


func add10To(_ value: Int) -> Int {
    value + 10
}

func add20To(_ value: Int) -> Int {
    value + 20
}

func doAddition(
    on value: Int,
    using function: (Int) -> Int
) {
    function(value)
}

doAddition(
    on: 20) { (value) in value + 30}

doAddition(
    on: 20, using: add10To(_:)
)


doAddition(on: 20, using: add20To(_:))
