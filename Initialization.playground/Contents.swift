//: lazy initialization of property
class Foo {
    lazy var iamLazy: Bool = {
       true
    }()
}

let f = Foo()
// initialized when accessed first time
f.iamLazy

//: _invariant_ (aka value object)
class Money {
    let amount: Double
    init(value: Double) {
        amount = value
    }
}

let money = Money(value: 100.0)
// money.amount = 5 -> ERROR

//: Designated and Convenience init

class Vehicle {
    var numberOfVheels: Int
    // designated init
    init(vheels: Int) {
        numberOfVheels = vheels
    }
    // another designated init
    init() {
        numberOfVheels = 0
    }
    // instead of init() you can have convenience init, but convenience cannot be override in subclass!
//    convenience init() {
//        self.init(vheels: 0)
//    }
}

let v = Vehicle()
v.numberOfVheels

//: Inheritance

class Bicycle: Vehicle {
    enum Kind {case CityBike, MoutainBike, TrackBike}
    var kind: Kind
    // Bicycle inherits initializers from Vehicle if you dont define any designated init here!!!
    
    // new designated init
    init(kind: Kind) {
        // 1. init all properties from subclass
        self.kind = kind
        // 2. call one of designated initializers from superclass
        super.init(vheels: 2)
    }
    // override superclass initializers
    override init() {
        // 1. init all properties from subclass
        kind = .CityBike
        // 2. call one of designated initializers from superclass
        super.init(vheels: 2)
    }
}

let cityBike = Bicycle()
cityBike.kind
cityBike.numberOfVheels
let trackBike = Bicycle(kind: .TrackBike)
trackBike.kind
trackBike.numberOfVheels

//: Bidirectional Association

class A {
    let a: Int
    unowned let refB: B
    init(b: B) {
        a = 0
        refB = b
    }
}

// objekt B vytvorí objekt A vo svojom init a chce A odovzdať referenciu na self
// kód nižšie skončí s chybou 'self' used before all stored properties initialized!!!
//class B {
//    let refA: A
//    init() {
//        refA = A(b: self)
//    }
//}

// rescue je použitie implicitly unwrapped optional
class B {
    var refA: A! // nesmie byť let!!!
    init() {
        refA = A(b: self)
    }
}

































