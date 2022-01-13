import Foundation

// Split up array into chunks
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

// Import data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let msgHex = try String(contentsOf: url).split(separator: "\n")
var msgBin = Array(String(Int(msgHex[0], radix: 16)!, radix: 2)) // Make sure this doesent overflow later

// Header Data
let packetVerion = Int(String(msgBin[0..<3]), radix: 2)!
let packetType = Int(String(msgBin[3..<6]), radix: 2)!

// Get literal value
func literal(msg: [Character]) -> Int {
    let msgLocal = Array(msg.dropFirst(6))
    let msgChunk = msgLocal.chunked(into: 5)
    var bits = [Character]()
    
    for chunk in msgChunk {
        if chunk[0] == "1" {
            bits.append(contentsOf: chunk[1..<5])
        } else {
            bits.append(contentsOf: chunk[1..<5])
            break
        }
    }
    
    return Int(String(bits), radix: 2)!
}

// Literal function
if packetType == 4 {
    print(literal(msg: msgBin))
}
