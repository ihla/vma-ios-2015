// enum Colors je nový typ podobne ako class Colors
enum Colors {
    case Red, Green, Blue }
// resp.
enum Number {
    case Large
    case Small
    case Medium
}
// prístup k enum hodnotám
var nn = Number.Large
var jj:Number = .Medium

// enum values
// keď chceme priradiť hodnoty, musíme tiež definovať typ
// keďže inicializujeme Poor s hodnotou 1, musíme udať typ "enum Rating: Int"
// ostatné hodnoty sú priradené automaticky 2,3,...
enum Rating: Int {
    case Poor = 1
    case Excellent
    case Majestic
}
let rate:Rating = .Excellent
// teraz má rate dve hodnoty
// - "symbolickú" (member value) = .Excellent
if rate == Rating.Excellent {
    print("rate je .Excellent")
}
// - raw value
rate.rawValue
Rating.Majestic.rawValue

// enum podobne ako class môže mať init metódu
enum Animals: String {
    case Lion = "lion", Tiger = "tiger", Elephant = "elephant"
    init() {
        self = .Elephant
    }
}
// inštanciovanie enum objektu na default value
let anim = Animals()
anim.rawValue
// inštanciovanie enum objektu s raw value
// pozor však, teraz init vráti optional!
let tiger = Animals(rawValue: "tiger")
tiger?.rawValue

// enum môže obsahovať aj iné metódy
enum HttpResponseCode: Int {
    case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
    
    func simpleDescription() -> String {
        switch self {
        case .Unauthorized:
            return "Unauthorized"
        case .Forbidden:
            return "Forbidden"
        case .NotFound:
            return "Not Found"
        }
    }
}
// všimni si implicitly unwrapped optional
var error: HttpResponseCode! = HttpResponseCode(rawValue: 401)
error.simpleDescription()


//associated values
// k symbolickej hodnote (member value) enum možno v runtime priradiť tzv. associated value
enum Contact {
    case NoContact
    case Email(String) //associated val. = email address
    case Phone(Int) // assocoated val. = phone num
}
// inicializovanie s associated value
let emailContact: Contact = .Email("lubos.ilcik@gmail.com")
let phoneContact: Contact = .Phone(004216233445)

// prístup k associated value je trochu "tricky"
var contact = emailContact
switch contact {
case .Email(let addr):
    print(addr)
case .Phone(let num):
    print("\(num)")
default:
    print("unknown")
}
// alternatívne (funguje aj s var)
switch contact {
case let .Email(addr):
    print(addr)
case let .Phone(num):
    print("\(num)")
default:
    print("unknown")
}
