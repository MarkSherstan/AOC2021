import Foundation

// Reverse dictionary lookup
extension Dictionary where Value: Equatable {
    func key(forValue value: Value) -> Key? {
        return first { $0.1 == value }?.0
    }
}

// Scanner struct
struct Scanner {
    let ID: Int
    var A: [Int]
    var B: [Int]
    var C: [Int]
    var coords: Set<[Int]>
}

struct Transform {
    var translation: [Int]
    var transformedCoords: Set<[Int]>
    var flag: Bool
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
            
            let coords = createCoordSet(A: A, B: B, C: C)
            self.scannerArray.append(Scanner(ID: ID, A: A, B: B, C: C, coords: coords))
        }
    }
    
    // Create a coordinate set of [a, b, c]
    func createCoordSet(A: [Int], B: [Int], C: [Int]) -> Set<[Int]> {
        var result = [[Int]]()
        
        for i in 0..<A.count {
            result.append([A[i], B[i], C[i]])
        }
        
        return Set(result)
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
        if let maxCount = occurrences.values.max() {                            // What if there is more than 1?
            if maxCount >= 12 {
                return [occurrences.key(forValue: maxCount)!, maxCount]
            } else {
                return [Int.min, Int.min]
            }
        } else {
            return [Int.min, Int.min]
        }
    }
    
    // Function for checking directions (alpha relative to beta - beta "master")
    func translationMachine(scannerAlpha: [Int], scannerBeta: [Int]) -> Int {
        // Variable declaration
        var tempArray = [Int]()
        
        // Check negative case
        for alpha in scannerAlpha {
            tempArray.append(contentsOf: scannerBeta.map{$0 - alpha})
        }
        let offset = mode(numbers: tempArray)
        
        if offset[1] > Int.min {
            return offset[0]
        } else {
            return Int.min
        }
    }
    
    // Test all the different combos
    func test(A: [Int], B: [Int], C: [Int], newIdx: Int) -> Bool {
        // Find the translation
        let translationA = translationMachine(scannerAlpha: A, scannerBeta: scannerArray[newIdx].A)
        let translationB = translationMachine(scannerAlpha: B, scannerBeta: scannerArray[newIdx].B)
        let translationC = translationMachine(scannerAlpha: C, scannerBeta: scannerArray[newIdx].C)
        
        // Translation check all pass
        if (translationA > Int.min) && (translationB > Int.min) && (translationC > Int.min) {
            // Combinations
            let comboA = [1, 1, 1, 1, -1, -1, -1, -1]
            let comboB = [1, 1, -1, -1, 1, 1, -1, -1]
            let comboC = [1, -1, 1, -1, 1, -1, 1, -1]
            
            for i in 0..<comboA.count {
                let tempA = A.map{comboA[i] * $0 + translationA}
                let tempB = B.map{comboB[i] * $0 + translationB}
                let tempC = C.map{comboC[i] * $0 + translationC}
                let tempCoords = createCoordSet(A: tempA, B: tempB, C: tempC)
                let count = scannerArray[newIdx].coords.filter(tempCoords.contains).count
                
                if count >= 12 {
                    scannerArray[newIdx].A.append(contentsOf: tempA)
                    scannerArray[newIdx].B.append(contentsOf: tempB)
                    scannerArray[newIdx].C.append(contentsOf: tempC)
                    scannerArray[newIdx].coords.formUnion(tempCoords)
//                    print(translationA, translationB, translationC)
                    return true
                }
            }
        }
        return false
    }
    
    // Ordering function
    func run(idx: Int, idxBase: Int) -> Bool {
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
            
            // Test combinations to find the transformation
            if test(A: A, B: B, C: C, newIdx: idxBase) {
                
                return true
            } else {
                combo += 1
            }
        }
    }
    
    // Part 1
    public func part1() {
        var idxArray = Array(0..<scannerArray.count)
        
        while idxArray.count != 1 {
            print("count:", idxArray.count)
            
    topLoop: for idx0 in idxArray {
                for idx1 in idxArray {
                    if idx0 != idx1 {
                        print(idx0, idx1)
                        if run(idx: idx1, idxBase: idx0) {
                            idxArray.removeAll(where: { $0 == idx1 })
                            break topLoop
                        }
                    }
                }
            }
        }
        
        let idx = idxArray[0]
        print("Part 1:", idxArray, scannerArray[idx].coords.count)// scannerArray[0].coords.count)
    }
    
    // Part 2
    public func part2() {
        print("Part 2: ", 000)
    }
}
