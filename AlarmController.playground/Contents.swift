//: Playground - AlarmController implementation demonstrates some Swift features

//: this is how to create protocols and classes

// a protocol can contain functions and computed properties
// this protocol defines interface which each sensor must implement
protocol Sensor {
    // this is how to make computed read-only property
    var isActivated: Bool {
        get
    }
    var name: String {
        get
    }
    // this is void-func
    func react()
}

// func example
func funcName(arg1: Int, arg2: String) -> String {
    return "\(arg1) \(arg2)"
}

// this protocol defines interface to call when reacting to door sensor open state
protocol DoorSensorReactor {
    func actOnDoorOpen(sensor: Sensor!)
}

// optionals example
var nilVar: String? // string optional
if nilVar != nil {
    let txt = nilVar! + "is nil"
}

if let nilVar = nilVar {
    let txt = nilVar + "is nil"
} else {
    print("is nil")
}

// class holding door sensor state and implementing Sensor protocol
class DoorSensor: Sensor {
    // we have an enum representing 2 states
    enum State {
        case Open
        case Closed
    }

    // and state variable with initial value
    var state: State = .Closed
    
    // this is Sensor protocol implementation
    var isActivated: Bool {
        switch state {
            case .Open: return true
            case .Closed: return false
        }
    }
    
    var name: String {
        return "Door Sensor";
    }
    
    func react() {
        reactor.actOnDoorOpen(self)
    }
    
    // reference to reactor
    var reactor: DoorSensorReactor
    
    // initializer
    init(reactor: DoorSensorReactor) {
        self.reactor = reactor
    }
}

// and another kind  of sensor with its protocol and implementation class below
protocol WindowSensorReactor {
    func actOnWindowBroken(sensor: Sensor!)
}

class WindowSensor: Sensor {
    // class provides namespace for inner types, thus we can use the same names as before
    enum State {
        case Broken, Unbroken
    }
    var state: State = .Unbroken
    var isActivated: Bool {
        switch state {
            case .Broken: return true
            case .Unbroken: return false
        }
    }
    var name: String {
        return "Window Sensor";
    }
    var reactor: WindowSensorReactor
    init(reactor: WindowSensorReactor) {
        self.reactor = reactor
    }
    func react() {
        reactor.actOnWindowBroken(self)
    }
}

// we want our AlarmController to present itself with text when put in print()
// that's why it must implement the CustomStringConvertible protocol
// additionally our class conforms to both '*Reactor' protocols
class AlarmController: CustomStringConvertible, DoorSensorReactor, WindowSensorReactor {
    // array of sensors is optional
    // optional value can be nil!!!
    var sensors: [Sensor]? // is initialized to nil (if not optional, we must init in initializer)
    
    var name: String // will be init in initializer

    // this is implementation of CustomStringConvertible protocol
    var description: String {
        return "\(name) with \(sensors?.count) sensors."
    }
    
    // this is an example of initilaizer with one parameter
    init(name: String) {
        self.name = name
    }
    
    // this is how we implement the sensor reading by polling mechanism
    func evaluate() {
        // the lines below show how to use 'optional chaining' with sensors var
        // and example of 'closure' with forEach() function
        sensors?.forEach() { sensor in // 'sensor' here is the local var used within closure (alternatively we can use '$0')
            if sensor.isActivated {
                sensor.react()
            }
        }
    }
    
    // these are the actions on sensor active events
    func actOnDoorOpen(sensor: Sensor!) {
        testAction(sensor)
    }
    
    func actOnWindowBroken(sensor: Sensor!) {
        testAction(sensor)
    }
    
    private func testAction(sensor: Sensor) {
        print("\(sensor.name) triggered action")
    }
}

// closure example
func repeatFunc(var times: Int, closure: ()->()) {
    repeat {
        closure()
    } while(--times > 0)
}
repeatFunc(3, closure: { print("hi")})
repeatFunc(5) {
        print("ahoj")
}

//: Tests of AlarmController
//: 1. create instance
// class is reference type, we can have as many references as we like
// let-reference means we cannot change the value of reference but we can still change the properties of referred object
let alarmController = AlarmController(name: "MyAlarmController")
print("test evaluate() when no sensor attached")
print(alarmController)
alarmController.evaluate()
// nothing shoud happen because sensor list is empty, check console

//: 2. create and add some sensors
alarmController.sensors = [Sensor]()
alarmController.sensors!.append(DoorSensor(reactor: alarmController))
alarmController.sensors!.append(WindowSensor(reactor: alarmController))
alarmController.sensors!.append(WindowSensor(reactor: alarmController))
print("test 3 sensors attached")
print(alarmController)

//: 3. simulate some sensors activated state
// be carefull with typecasting!!!
let doorSensor = alarmController.sensors!.first as! DoorSensor
doorSensor.state = .Open
let windowSensor = alarmController.sensors!.last as! WindowSensor
windowSensor.state = .Broken
print("test door sensor and window sensor activated")
alarmController.evaluate()
// check out the console






