import Foundation

// Split up array into chunks
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

// Hex mapping
let hex2bin = ["0": ["0", "0", "0", "0"],
               "1": ["0", "0", "0", "1"],
               "2": ["0", "0", "1", "0"],
               "3": ["0", "0", "1", "1"],
               "4": ["0", "1", "0", "0"],
               "5": ["0", "1", "0", "1"],
               "6": ["0", "1", "1", "0"],
               "7": ["0", "1", "1", "1"],
               "8": ["1", "0", "0", "0"],
               "9": ["1", "0", "0", "1"],
               "A": ["1", "0", "1", "0"],
               "B": ["1", "0", "1", "1"],
               "C": ["1", "1", "0", "0"],
               "D": ["1", "1", "0", "1"],
               "E": ["1", "1", "1", "0"],
               "F": ["1", "1", "1", "1"]]

// Import data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let msgHex = try String(contentsOf: url).split(separator: "\n")

var msgBin = [String]()
for hex in msgHex[0] {
    msgBin.append(contentsOf: hex2bin[String(hex)]!)
}

// Get version number
func getVersionNumber(msg: inout [String]) -> Int {
    let V = Int(msg[0..<3].joined(), radix: 2)!
    msg.removeSubrange(0..<3)
    
    return V
}

// Get packet number
func getPacketNumber(msg: inout [String]) -> Int {
    let P = Int(msg[0..<3].joined(), radix: 2)!
    msg.removeSubrange(0..<3)
    
    return P
}

// Get literal value
func literal(msg: inout [String]) -> Int {
    // Split message and init bits
    let msgChunk = msg.chunked(into: 5)
    var bits = [String]()
    
    // Loop through the chunks
    for chunk in msgChunk {
        if chunk[0] == "1" {
            bits.append(contentsOf: chunk[1..<5])
            msg.removeSubrange(0..<5)
        } else {
            bits.append(contentsOf: chunk[1..<5])
            msg.removeSubrange(0..<5)
            break
        }
    }
        
    // Zero garbadge collection
    while true {
        if msg.isEmpty {
            break
        } else if msg[0] == "0" {
            msg.removeFirst()
        } else {
            break
        }
    }
    
    // Answer
    return Int(bits.joined(), radix: 2)!
}

// Main logic
var packetVerionSum = 0

while !msgBin.isEmpty {
    // Header Data
    packetVerionSum += getVersionNumber(msg: &msgBin)
    let packetType = getPacketNumber(msg: &msgBin)
    
    // Sort out packets
    if packetType == 4 {
        print(literal(msg: &msgBin))
    } else {
        if msgBin[6] == "0" {
            let lengthTypeId = Int(msgBin[7...21].joined(), radix: 2)!
            print(msgBin[7...21], msgBin[7...21].count, lengthTypeId)
        } else {
            let lengthTypeId = Int(msgBin[7...17].joined(), radix: 2)!
            print(msgBin[7...21], msgBin[7...17].count, lengthTypeId)
        }
    }

}

print("Part 1: ", packetVerionSum)
