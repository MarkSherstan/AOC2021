import Foundation

// Reverse dictionary lookup
extension Dictionary where Value: Equatable {
    func key(forValue value: Value) -> Key? {
        return first { $0.1 == value }?.0
    }
}

// Structs
struct Scanner {
    let ID: Int
    var A: [Int]
    var B: [Int]
    var C: [Int]
}

struct Transform {
    let direction: Int
    let translation: Int
    let flag: Bool
}

// Class
public class Day19 {
    var scannerArray = [Scanner]()

    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
        let raw = try! String(contentsOf: url).split(separator: "\n", omittingEmptySubsequences: false).split(separator: "")

        // Save data to array of structs
        for Entry in raw {
            var ID = -1
            var A = [Int]()
            var B = [Int]()
            var C = [Int]()
            
            for entry in Entry {
                if entry.contains("---") {
                    ID = Int(entry.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "---", with: "").replacingOccurrences(of: "scanner", with: ""))!
                } else {
                    let temp = entry.split(separator: ",")
                    A.append(Int(temp[0])!)
                    B.append(Int(temp[1])!)
                    C.append(Int(temp[2])!)
                }
            }
            
            self.scannerArray.append(Scanner(ID: ID, A: A, B: B, C: C))
        }
    }

    // Find mode of array
    func mode(numbers: [Int]) -> Int {
        // Create dictionary of the count of each number
        var occurrences: [Int: Int] = [:]
        for number in numbers {
            if occurrences[number] == nil {
                occurrences[number] = 1
            } else {
                occurrences[number]! += 1
            }
        }

        // Return offset
        if let maxVal = occurrences.values.max() {
            if maxVal >= 12 {
                return occurrences.key(forValue: maxVal)!
            } else {
                return Int.min
            }
        } else {
            return Int.min
        }
    }
    
    // Function for checking directions
    func directionMachine(littleScanner: [Int], masterScanner: [Int]) -> Transform {
        // Variable declaration
        var tempArray = [Int]()
        var offset = Int.min
        
        // Check positive case
        for little in littleScanner {
            tempArray.append(contentsOf: masterScanner.map{$0 + little})
        }
        
        // Results and prep for next loop
        offset = mode(numbers: tempArray)
        if offset != Int.min {
            return Transform(direction: -1, translation: offset, flag: true)
        } else {
            tempArray.removeAll()
        }
        
        // Check negative case
        for little in littleScanner {
            tempArray.append(contentsOf: masterScanner.map{$0 - little})
        }
        
        // Results
        offset = mode(numbers: tempArray)
        if offset != Int.min {
            return Transform(direction: 1, translation: offset, flag: true)
        } else {
            return Transform(direction: 0, translation: 0, flag: false)
        }
    }

    // Ordering function
    func run(scannerArray: inout [Scanner], idx: Int) -> Bool {
        // Initial conditions
        var combo = 0
        let tempA = scannerArray[idx].A
        let tempB = scannerArray[idx].B
        let tempC = scannerArray[idx].C

        while true {
            // Set up variables
            var A = [Int]()
            var B = [Int]()
            var C = [Int]()
            
            // Trial all the different combinations
            switch combo {
            case 0:
                // ABC:ABC
                A = tempA
                B = tempB
                C = tempC
                combo += 1
            case 1:
                // ABC:ACB
                A = tempA
                B = tempC.map{-1*$0}
                C = tempB.map{-1*$0}
                combo += 1
            case 2:
                // ABC:BAC
                A = tempB.map{-1*$0}
                B = tempA.map{-1*$0}
                C = tempC
                combo += 1
            case 3:
                // ABC:BCA
                A = tempB.map{-1*$0}
                B = tempC.map{-1*$0}
                C = tempA.map{-1*$0}
                combo += 1
            case 4:
                // ABC:CAB
                A = tempC.map{-1*$0}
                B = tempA.map{-1*$0}
                C = tempB.map{-1*$0}
                combo += 1
            case 5:
                // ABC:CBA
                A = tempC.map{-1*$0}
                B = tempB
                C = tempA.map{-1*$0}
                combo += 1
            default:
                return false
            }

            let transformA = directionMachine(littleScanner: A, masterScanner: scannerArray[0].A)
            let transformB = directionMachine(littleScanner: B, masterScanner: scannerArray[0].B)
            let transformC = directionMachine(littleScanner: C, masterScanner: scannerArray[0].C)
            
            if (transformA.flag && transformB.flag && transformC.flag) {
                // Add scanner # to master with matching coordinate system
                scannerArray[0].A.append(contentsOf: A.map{transformA.direction * $0 + transformA.translation})
                scannerArray[0].B.append(contentsOf: B.map{transformB.direction * $0 + transformB.translation})
                scannerArray[0].C.append(contentsOf: C.map{transformC.direction * $0 + transformC.translation})
                print(idx, combo-1, transformA.translation, transformB.translation, transformC.translation)
                return true
            }
        }
    }
    
    // Part 1
    public func part1() {
        var idxArray = Array(1..<scannerArray.count)

        while !idxArray.isEmpty {
            for idx in idxArray {
                if run(scannerArray: &scannerArray, idx: idx) {
                    idxArray.removeAll(where: { $0 == idx })
                }
            }
        }

        var result = [[Int]]()
        for i in 0..<scannerArray[0].A.count {
//            print(scannerArray[0].A[i], ",", scannerArray[0].B[i], ",", scannerArray[0].C[i])
            result.append([scannerArray[0].A[i], scannerArray[0].B[i], scannerArray[0].C[i]])
        }

//        let A = Set(result)
//        for a in A {
//            print(a[0], ",", a[1], ",", a[2])
//        }
//        print("Part 1:", Set(result))

        print("Part 1:", Set(result).count, Set(scannerArray[0].A).count, Set(scannerArray[0].B).count, Set(scannerArray[0].C).count)
    }

    // Part 2
    public func part2() {
        print("Part 2: ", 000)
    }
}
