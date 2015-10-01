//: Swift Basics

//: var, let
// notice - no types, no semicolons!!!!!!!!
let greeting = "Hello, playground"
let courseName = "Swift"
// declaring a type
let platform: String
platform = "iOS"
// let is constant, cannot change
//platform = "OSX" ERROR
var firstName = "Lubos"
// var can change as much time as you like
firstName = "Michal" // OK

var text: String // I can declare on one line
text = "Swift is great!" // and initiaize on other line (the same is true for let)

var number = 5

//let mixingApplesAndOranges = number + text ->> causes ERROR of course

// accessing non-initialized var causes error!
var nonInitialized: Int
//nonInitialized++ ERROR
//: primitive types
// integers
var count: Int
//count++ ERROR
count = 0
count++
let inferredIntValue = 12
let intValue: Int = 0
var b = intValue + 1
b++
b

// decimals
let decimal = 12.12
let floatValue: Float = 5.9
var doubleValue: Double
//doubleValue = 2*floatValue ERROR
doubleValue = 2*Double(floatValue)

// booleans
let isOnSale = false
var isCheap: Bool

//: array, dictionary
var days = ["Mo", "Tue", "Wed"]
days[0]
var years: Array<Int>
var cities: [String]
years = []
cities = [String]()
days += ["Th"]
days.append("Sa")

var responseCodes: [Int : String] = [200 : "OK", 400 : "Not Found"]
var districts: Dictionary<String, String> = ["SE" : "Senica", "TT" : "Trnava"]
districts["MT"] = "Martin"
districts.updateValue("Senec", forKey: "SC")
districts["SC"]


//: func
print("ahoj")
print("ahoj" + " " + courseName) // concatenation
print("ahoj \(courseName)") // interpolation
print("\(doubleValue)")
print("ahoj", courseName, separator: " ", terminator: "\n")

// custom func
// no params, no ret value
func sayHello() {
    print("Hello!")
}
sayHello()

// returning String
func makeGreeting() -> String {
    return "Hello!"
}

// one param
func greet(text: String) {
    print(text)
}
greet(makeGreeting())

func concatenate(text1: String, withText: String) -> String {
    return text1 + withText
}
// named params
let result = concatenate("Anonym", withText: "ous")

//: struct
struct Point {
    var x: Float
    var y: Float
}
let centerOfUniverse = Point(x: 0, y: 0) // default initializer generated automatically
centerOfUniverse.x
centerOfUniverse.y

struct Size {
    var width: Float = 0.0
    var height: Float = 0.0
}
let grainOfSandSize = Size()
let rockSize = Size(width: 1000, height: 10000)

struct Rectangle {
    // stored properties
    let origin: Point
    let size: Size
    
    // computed properties
    var area: Float {
        return size.height * size.width
    }
    var isVisible: Bool {
        get {
            return area > 0
        }
        set {
            isVisible = newValue ? area > 0 : newValue
        }
    }
}
let rectangle = Rectangle(origin: Point(x: 0, y: 0), size: Size())
rectangle.area
rectangle.isVisible

struct Vehicle {
    var coordinate: Point
    var speed: Float
    // stored properties are inmutable by default!!!
    /* be aware of 'mutating' word! */mutating func move(destination: Point) {
        coordinate.x += destination.x * speed
        coordinate.y += destination.x * speed
    }
}
var myCar = Vehicle(coordinate: centerOfUniverse, speed: 5)
myCar.move(Point(x: 5, y: 5))
myCar.coordinate.x
myCar.coordinate.y

// struct is 'value type' and inmutable if constant (let)
let newCar = Vehicle(coordinate: centerOfUniverse, speed: 100)
//newCar.move(Point(x: 10, y: 20)) ERROR
// must be var if I want to change its state
var changeableCar = Vehicle(coordinate: centerOfUniverse, speed: 100)
changeableCar.move(Point(x: 10, y: 20)) // OK!!!!!

//: class
class Car {
    var coordinate: Point = Point(x: 0, y: 0)
    var speed: Float = 0.0
    
    // designated initializer
    init(coordinate: Point, speed: Float) {
        self.coordinate = coordinate
        self.speed = speed
    }
    
    func move(direction: Point) {
        coordinate.x += direction.x * speed
        coordinate.y += direction.y * speed
    }
}
// class is reference type!
let car = Car(coordinate: centerOfUniverse, speed: 100)
// I can change the Car state even when constant!!!!
car.move(Point(x: 50, y: 0))
car.coordinate.x
car.coordinate.y
// but I can't change reference because the reference is constant!!!!
//car = Car(coordinate: Point(x: 10, y: 10), speed: 100) ERROR

