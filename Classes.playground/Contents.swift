import Foundation


/// classes are like structures but structures are value type and classes are reference type
/// Therefore it is mutable.


struct sPerson {
    var name: String
    var age: Int
}

// classes are required constructors
class Person{
    
    /// The property here can be changed externally and internally
    var name: String
    var age: Int
    
    init(
        name: String,
        age: Int
    ) {
        self.name = name
        self.age = age
    }
    // class methods don't need muatating keyword
    // if you use the keyword, it will occur syntax error
    func increaseAge(){
        self.age += 1
    }
}

/// the variable `foo` is actually `let` which menas it is immutable
/// But editing the property works! becuase its a reference type
/// The restriction is that you cannot assign another value or reference
/// to the `foo`
/// ex) `foo = 123` // this doesn't work
let foo = Person(
    name: "Foo", age: 20
)

foo.age
foo.increaseAge()
foo.age

/// if you assign class into another varialbe it just copy the reference
/// It point same memory address
foo.age
let bar = foo
bar.increaseAge()
foo.age

/// Compare class instances
/// Compare memory address `===`

if foo === bar {
    "Foo and Bar point to the same memory"
} else {
    "They don't point to the same memory"
}

/// Binary operator '==' cannot be applied to two 'Person' operands
//if foo == bar{
//    "ha"
//} else {
//    "la"
//}

/// INHERITANCE

class Vehicle {
    func goVroom() {
        "Vroom vroom"
    }
}

class Car: Vehicle {
    
}

let car = Car()
car.goVroom()

/// PRIVATE SETTERS

class Person2 {
    /// Q?: what is set specifically mean
    private(set) var age: Int
    init(age: Int) {
        self.age = age
    }
    
    func increaseAge(){
        self.age += 1
    }
}

let baz = Person2(age: 20)
baz.age
/// Below code will occur error
/// Becuase `age` is private property which cannot be modified from outside of the class
//baz.age += 1
baz.increaseAge()
baz.age

/// DESIGNATED INITIALIZERS

class Tesla {
    let manufacturer = "Tesla"
    let model: String
    let year: Int
    
    
    /// Designated initializer should not rely on another designated initializer
    /// ```
    /// init(...){
    ///     init(...)
    /// }
    /// ```
    /// This code will occur error
    init(){
        self.model = "X"
        self.year = 2023
    }
    
    init(
        model: String,
        year: Int
    ){
        self.model = model
        self.year = year
    }
    
    convenience init(
        model: String
    ) {
        self.init(model: model, year: 2023)
    }
    
    /// Diferences between `convenience init` and `init`.
    /// https://stackoverflow.com/questions/40093484/what-is-the-difference-between-convenience-init-vs-init-in-swift-explicit-examp
    ///
}

class TeslaModelY: Tesla {
    override init() {
        super.init(model: "Y", year: 2023)
        
        /// Inside of designated initializer, you cannot call convinience initializer
        /// But vise versa works
        /// `super.init(model: "Y")` will occur syntax error
    }
}

let modelY = TeslaModelY()
modelY.model
modelY.year
modelY.manufacturer


let fooBar = Person2(age: 20)
fooBar.age
func doSomething(with person: Person2) {
    person.increaseAge()
}
doSomething(with: fooBar)
fooBar.age

/// Structures are more safe

/// DEINITIALIZERS
/// It is invoked from memory automatically

class MyClass {
    init() {
        print("initailized")
    }
    
    func doSomething() {
        // empty
    }
    deinit {
        print("Deinitialized")
    }
}

let myClosure = {
    let myClass = MyClass()
    myClass.doSomething()
}

myClosure()

