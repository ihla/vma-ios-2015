let tupleA = (3, 4)
print(tupleA.0) // using index
print(tupleA.1)
let tupleB = ("year", 2015)

let status = (200, "OK")
let statusNamed: (code: Int, string: String) = status
statusNamed.code // using name
let (statusCode, statusMessage) = status
statusCode

// s typom
var tupleDef:(first:Int, second:String) = (1, "")

// func s návratovou hodnotou tupple
func sendRequest(/* some data to send */) -> (returnCode: Int, returnStatus: String) {
    // ...
    return (404, "File Not Found")
}

func processRequest() {
    let (resultCode, message) = sendRequest()
    guard resultCode != 200 else {
        // escape if ok
        return
    }
    // process error nmessage here...
    print(message)
}
processRequest()