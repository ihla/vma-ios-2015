//:# Automatic Reference Counting (ARC)

/*: 
Inštancie tried a closures (objekty) sú vytvorené v heap pamäti.
Swift používa memory management založený na ARC (triedy aj closures sú '_reference types_').
ARC automaticky uvoľní pamäť alokovanú pre objekt ak objekt už nie je používaný (reference counting).
*/

//: Príklad nižžšie demonštruje ako ARC funguje
class ARCDemo {
    static var count = 0
    var instanceNumber = 0
    let a: Int
    let b: Int
    init() {
        ARCDemo.count++
        instanceNumber = ARCDemo.count
        print("ARCDemo(\(instanceNumber)) init") // výpis na konzolu, keď init sa zavolá
        a = 0
        b = 0
    }
    deinit {
        print("ARCDemo(\(instanceNumber)) deinit") // výpis na konzolu keď deinit sa zavolá
    }
}

// do { } definuje scope pre 'strongReference'
// var alebo let, do ktorej odložíme referenciu na vytvorený objekt sa v ARC, automaticky stáva tzv. 'strong reference' pre daný objekt
// keď program vystúpi so scope, v ktorom je strongReference definovaná, strongReference zanikne
// a tým pádom sa stratí aj strong reference na ARCDemo objekt
// a ARC automatický uvoľní pamäť keď už neexistuje žiadna iná strong reference
// zapnite konzolu a skontrolujte výpisy
do {
    let strongReference = ARCDemo()
}

// dôkaz, že strong reference funguje je na riadkoch nižšie
//let strongReference1 = ARCDemo()
//do {
//    let strongReference2 = strongReference1
//}

//:## Strong Reference Cycles

//:### Bidirectional Association
// príklad nižšie demonštruje chybu, ktorá vedie k 'memory leak'
class A {
    var refB: B?
    init() {
        print("A init")
    }
    deinit {
        print("A deinit")
    }
}
class B {
    var refA: A?
    init() {
        print("B init")
    }
    deinit {
        print("B deinit")
    }
}

// test
//var a: A? = A()
//var b: B? = B()
//a!.refB = b
//b!.refA = a
//a = nil
//b = nil
// tu by sme očakávali uvoľnenie pamäte alokovanej pre A a B...
// no pamäť sa uvoľní až keď pridáme riadky nižšie pred nilovanie 'a' a 'b':
// a!.refB = nil
// b!.refA = nil

//: ### Weak References

class Book {
    var author: Author // book w/o author cannot exist by design
    
    init(author: Author) {
        print("Book init")
        self.author = author
    }
    deinit {
        print("Book deinit")
    }
}
class Author {
    // weak reference musí byť vždy optional!
    // lebo weak reference môže byť nil!
    weak var book: Book? // author w/o book can exist by design

    init() {
        print("Author init")
    }
    deinit {
        print("Author deinit")
    }
}

// test
//var author: Author? = Author()
//var book: Book? = Book(author: author!)
//author!.book = book
//book = nil
//author!.book // pozor: book referencia je nil!!!!!!!!!
//author = nil
// teraz sú oba objekty dealokované

//: ### Unowned References

class Part { // Part cannot live w/o Whole
    unowned let whole: Whole // unowned ref môže byť aj let a nesmie byť optional
    init(whole: Whole) {
        self.whole = whole
        print("Part init")
    }
    deinit {
        print("Part deinit")
    }
}
class Whole { // Whole is owning Part
    lazy var part: Part = {
       Part(whole: self)
    }()
    init() {
        print("Whole init")
    }
    deinit {
        print("Whole deinit")
    }
}

// test
//do {
//    let w = Whole()
//    w.part // Part is created here because of its laziness
//}
// oba objekty Whole aj Part sú bezpečne dealokované

//: príklad s implicitly unwrapped optional
class Country {
    var city: City!
    init() {
        city = City(country: self)
        print("Country init")
    }
    deinit {
        print("Country deinit")
    }
}
class City {
    unowned let country: Country
    init(country: Country) {
        self.country = country
        print("City init")
    }
    deinit {
        print("City deinit")
    }
}

// test
//do {
//    let country = Country()
//}

//: ### Closures
// closure je objekt a tiež definuje scope pre premenné - premenné v tele closure 'žijú' spolu s closure
// preto tiež pozor na strong reference cycle

class ServerSyncOperation {
    var operation: ()->() = {}
    func storeData(data: Any) { print("\(data)") }
    func syncAllData() {
        // funkcia len nastaví operation, ktorá sa má vykonať v run()
        operation = {
            // POZOR: zaviedol som referenciu na self v tele closure!!!!
            // ServerSyncOperation drží referenciu na closure
            // a closure drží referenciu na ServerSyncOperation
            self.storeData(5)
        }
    }
    func run() {
        operation()
    }
    deinit {
        print("ServerSyncOperation deinit")
    }
}

// test
//do {
//    let op = ServerSyncOperation()
//    op.syncAllData()
//    op.run()
//}
// ServerSyncOperation deinit sa nikdy nezavolá!!!!!

//: fix pre closure referujúcu _self_
class ServerSyncOperation2 {
    var operation: ()->() = {}
    func storeData(data: Any) { print("\(data)") }
    func syncAllData() {
        // funkcia len nastaví operation, ktorá sa má vykonať v run()
        operation = { [unowned self] in // toto je to 'kúzlo' čo odstráni reference cycle
            self.storeData(5)
        }
    }
    func run() {
        operation()
    }
    deinit {
        print("ServerSyncOperation2 deinit")
    }
}

// test
//do {
//    let op = ServerSyncOperation2()
//    op.syncAllData()
//    op.run()
//}
// ServerSyncOperation2 deinit sa zavolá!!!!!































