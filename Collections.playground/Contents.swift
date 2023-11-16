import Foundation

/// Array is also one of the collections

let numbers = [1, 2, 3, 4]
numbers.first
numbers.last
numbers.count
numbers.map(-)

var mutatingNumbers = [0, 1, 2]
mutatingNumbers.append(3)
mutatingNumbers.insert(-1, at: 0)
mutatingNumbers.insert(
    contentsOf: [1, 2], at: 0
)

for value in numbers {
    value
}

for value in numbers where value % 2 == 0 {
    value
}

numbers.map {
    (value: Int) -> Int in
    value * 2
}

// This also works
numbers.map { $0 * 2 }

numbers.filter {
    (value: Int) -> Bool in
    value >= 3
}

numbers.compactMap { (value: Int) -> String? in
    value % 2 == 0
        ? String(value)
        : nil
}

let numbers2: [Int?] = [1, 2, nil, 4, 5]
numbers2.count

/// the type of `notNils` here is `[Int?]` not `[Int]`
/// even though, we filtered out the `nil` value, the type keeps same
/// To resolve this we need to use compactMap
let notNils = numbers2.filter { (value: Int?) -> Bool in
        value != nil
}

/// Now it's `[Int]`
let notNils2 = numbers2.compactMap { (value: Int?) -> Int? in
        value
}


let numbers3 = [1, 2, 1, 2]
numbers3.count

/// 2 ways that can make heterogeneous typed collections
let stuff1 = [
    1,
    "Hello",
    2,
    "World"
] as [Any]

let sutff2: [Any] = [
    1,
    "Hello",
    2,
    "World"
]


let uniqueNumbers = Set([1, 2, 1, 2, 3])
uniqueNumbers.count
uniqueNumbers.map(-)

let myNumbers = Set([1, 2, 3, nil, 5])
let notNilNumbers = Set(
    myNumbers.compactMap {
        $0
    }
)
notNilNumbers


/// How to create heterogeneous `Set`

let stuff3: Set<AnyHashable> = [
    1, 2, 3, "Vandad"
]
stuff3.count

/// `as?` This expression tells you whether a variable is certain type or not.
/// If the variable is not that specific type, it will assign `nil` value
let intsInStuff1 = stuff1.compactMap{
    (value: Any) -> Int? in
    value as? Int
}

let stringInStuff1 = stuff1.compactMap {
    (value: Any) -> String? in
    value as? String
}

/// compact mapping always returns an Array
let intsInStuff3 = stuff3.compactMap {
    (value: AnyHashable) -> Int? in
    value as? Int
}
type(of: intsInStuff3)

/// How to calculate `unique` object.
/// Normally they use the protocol named `hashable`


struct Person {
    let id: UUID
    let name: String
    let age: Int
}

let fooId = UUID()
let foo = Person(
    id: fooId,
    name: "Foo",
    age: 20
)

let bar = Person(
    id: fooId,
    name: "Bar",
    age: 30
)

/// Below code will occur the error `Type 'Person' does not conform to protocol 'Hashable'`
/// ```
/// let people: Set<Person> = [foo, bar]
/// ```
/// To fix this issue the Prson object must use `Hashable` protocol

struct HPerson: Hashable {
    let id: UUID
    let name: String
    let aget: Int
}

let fooId2 = UUID()
let foo2 = HPerson(id: fooId2, name: "Foo", aget: 20)
let bar2 = HPerson(id: fooId2, name: "Bar", aget: 30)

/// if we make custom `hashable` struct, we need to define which values should be calculated as hashValue.


struct Person2: Hashable {
    let id: UUID
    let name: String
    let age: Int
    
    /// what is `inout`
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (
        lhs: Self,
        rhs: Self
    ) -> Bool {
        lhs.id == rhs.id
    }
}

let bazID = UUID()
let baz = Person2(id: bazID, name: "Baz", age: 20)
let qux = Person2(id: bazID, name: "Qux", age: 30)

if baz == qux {
    "They are equal"
}

let people2 = Set([baz, qux])
people2.count
people2.first!.name


/// Dictionary
///

let userInfo = [
    "name": "Foo",
    "age": 20,
    "address": [
        "line1": "Address line 1",
        "postCode": "12345"
    ]
] as [String: Any]


let userInfo2: [String:Any] = [
    "name": "Foo",
    "age": 20,
    "address": [
        "line1": "Address line 1",
        "postCode": "12345"
    ]
]

userInfo["name"]
userInfo["age"]
/// Below code will raise errors
/// `userInfo["address]["postCode"]`
/// Because, the type of `userInfo["address"]` is `Any` as we defined above.
/// To fix it, we can use `as!`. However it is not recommended in production level
/// Below code actually works
(userInfo["address"] as! [String: String])["postCode"]

userInfo.keys
userInfo.values

for (key, value) in userInfo {
    key
    print(value)
}

for (key, value) in userInfo where value is Int {
    key
    value
}

for (key, value) in userInfo where value is Int && key.count > 2 {
    key
    value
}

