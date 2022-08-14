import Foundation

// Split up array into chunks
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

public class Day16 {
    // Variables and hex mapping
    var msgBin = [String]()
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
    
    // Results
    var p1Ans: Int?
    var p2Ans: Int?
    
    // Read in data
    public init() {
        // Import data
        let url = Bundle.main.url(forResource: "Day16", withExtension: "txt")!
        let msgHex = try! String(contentsOf: url).split(separator: "\n")

        for hex in msgHex[0] {
            self.msgBin.append(contentsOf: hex2bin[String(hex)]!)
        }
        
        // Solve the problem
        run()
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
        
        // Zero garbage collection
        if !msg.contains("1") {
            msg.removeAll()
        }
        
        // Answer
        return Int(bits.joined(), radix: 2)!
    }

    func evaluateExpression(packetType: Int, results: [Int]) -> Int {
        switch packetType {
        case 0: // Sum
            return results.reduce(0, +)
        case 1: // Product
            return results.reduce(1, *)
        case 2: // Min
            return results.min()!
        case 3: // Max
            return results.max()!
        case 5: // Greater than
            if results[0] > results[1] {
                return 1
            } else {
                return 0
            }
        case 6: // Less than
            if results[0] < results[1] {
                return 1
            } else {
                return 0
            }
        case 7: // Equal
            if results[0] == results[1] {
                return 1
            } else {
                return 0
            }
        default:
            print("Error")
            return -1
        }
    }
    
    func run() {
        // Total version sum
        var packetVerionSum = 0

        // Recursive function for dealing with layered messages
        func run() -> Int {
            // Header Data
            packetVerionSum += getVersionNumber(msg: &msgBin)
            let packetType = getPacketNumber(msg: &msgBin)
            
            // Sort out packets
            if packetType == 4 {
                return literal(msg: &msgBin)
            } else {
                if msgBin.removeFirst() == "0" {
                    let bitLengthParse = Int(msgBin[0..<15].joined(), radix: 2)!
                    msgBin.removeSubrange(0..<15)
                    let count = msgBin.count - bitLengthParse
                    var results = [Int]()
                    
                    while msgBin.count > count {
                        results.append(run())
                    }
                    
                    return evaluateExpression(packetType: packetType, results: results)
                } else {
                    let subPacketCount = Int(msgBin[0..<11].joined(), radix: 2)!
                    msgBin.removeSubrange(0..<11)
                    var results = [Int]()
                    
                    for _ in 0..<subPacketCount {
                        results.append(run())
                    }
                    
                    return evaluateExpression(packetType: packetType, results: results)
                }
            }
        }

        // Run until we have parsed everything
        var evaluate = 0
        while !msgBin.isEmpty {
            evaluate = run()
        }

        // Results
        p1Ans = packetVerionSum
        p2Ans = evaluate
    }
    
    // Part 1
    public func part1() -> String {
        return String(p1Ans!)
    }
    
    // Part 2
    public func part2() -> String {
        return String(p2Ans!)
    }
}
