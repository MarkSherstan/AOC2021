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
    func mode(numbers: [Int]) -> [Int] {
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
        if let maxCount = occurrences.values.max() {
            if maxCount >= 12 {
                return [occurrences.key(forValue: maxCount)!, maxCount]
            } else {
                return [0, 0]
            }
        } else {
            return [0, 0]
        }
    }
    
    // Function for checking directions
    func directionMachine(littleScanner: [Int], masterScanner: [Int]) -> Transform {
        // Variable declaration
        var tempArrayPlus = [Int]()
        var tempArrayMinus = [Int]()
        
        // Check positive case
        for little in littleScanner {
            tempArrayPlus.append(contentsOf: masterScanner.map{$0 + little})
        }
        let offsetPlus = mode(numbers: tempArrayPlus)
        
        // Check negative case
        for little in littleScanner {
            tempArrayMinus.append(contentsOf: masterScanner.map{$0 - little})
        }
        let offsetMinus = mode(numbers: tempArrayMinus)
        
        // Comparison
        if (offsetPlus[1] == 0) && (offsetMinus[1] == 0) {
            return Transform(direction: 0, translation: 0, flag: false)
        } else {
            if offsetPlus[1] > offsetMinus[1] {
                //                print("-", offsetPlus, offsetMinus)
                return Transform(direction: 1, translation: offsetPlus[0], flag: true)
            } else {
                //                print("+", offsetPlus, offsetMinus)
                return Transform(direction: 1, translation: offsetMinus[0], flag: true)
            }
        }
    }
    
    //
    func createCoords(A: [Int], B: [Int], C: [Int]) -> [[Int]] {
        var result = [[Int]]()
        
        for i in 0..<A.count {
            result.append([A[i], B[i], C[i]])
        }
        
        return Array(Set(result))
    }
    
    //
    func test(scannerArray: [Scanner], transformA: Transform, transformB: Transform, transformC: Transform, A: [Int], B: [Int], C: [Int]) -> [Int]{
        let masterA = scannerArray[0].A
        let masterB = scannerArray[0].B
        let masterC = scannerArray[0].C
        let master = createCoords(A: masterA, B: masterB, C: masterC)
        
        let comboA = [1, 1, 1, 1, -1, -1, -1, -1]
        let comboB = [1, 1, -1, -1, 1, 1, -1, -1]
        let comboC = [1, -1, 1, -1, 1, -1, 1, -1]
        
        var maxCount = -1
        var maxArray = [0, 0, 0]
        
        for i in 0..<comboA.count {
            let tempA = A.map{comboA[i] * $0 + transformA.translation}
            let tempB = B.map{comboB[i] * $0 + transformB.translation}
            let tempC = C.map{comboC[i] * $0 + transformC.translation}
            
            let temp = createCoords(A: tempA, B: tempB, C: tempC)
            let counter = master.filter(temp.contains).count
            
            if counter > maxCount {
                maxCount = counter
                maxArray = [comboA[i], comboB[i], comboC[i]]
            }
        }
        
        return maxArray
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
            case 1:
                // ABC:ACB
                A = tempA
                B = tempC
                C = tempB
            case 2:
                // ABC:BAC
                A = tempB
                B = tempA
                C = tempC
            case 3:
                // ABC:BCA
                A = tempB
                B = tempC
                C = tempA
            case 4:
                // ABC:CAB
                A = tempC
                B = tempA
                C = tempB
            case 5:
                // ABC:CBA
                A = tempC
                B = tempB
                C = tempA
            default:
                return false
            }
            
            let transformA = directionMachine(littleScanner: A, masterScanner: scannerArray[0].A)
            let transformB = directionMachine(littleScanner: B, masterScanner: scannerArray[0].B)
            let transformC = directionMachine(littleScanner: C, masterScanner: scannerArray[0].C)
            
            if (transformA.flag && transformB.flag && transformC.flag) {
                let dir = test(scannerArray: scannerArray, transformA: transformA, transformB: transformB, transformC: transformC, A: A, B: B, C: C)
                
                scannerArray[0].A.append(contentsOf: A.map{dir[0] * $0 + transformA.translation})
                scannerArray[0].B.append(contentsOf: B.map{dir[1] * $0 + transformB.translation})
                scannerArray[0].C.append(contentsOf: C.map{dir[2] * $0 + transformC.translation})
                print(idx, combo, transformA.translation, transformB.translation, transformC.translation, dir)
                
                return true
            } else {
                combo += 1
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
            result.append([scannerArray[0].A[i], scannerArray[0].B[i], scannerArray[0].C[i]])
        }
        
        //        let A = Set(result)
        //        for a in A {
        //            print(a[0], ",", a[1], ",", a[2])
        //        }
        
        print("Part 1:", Set(result).count, Set(scannerArray[0].A).count, Set(scannerArray[0].B).count, Set(scannerArray[0].C).count)
    }
    
    // Part 2
    public func part2() {
        print("Part 2: ", 000)
    }
}
