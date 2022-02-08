import Foundation

// Scanner struct
struct Scanner {
    var A: [Int]
    var B: [Int]
    var C: [Int]
    var coords: Set<[Int]>
}

// Class
public class Day19 {
    var scannerDict: [Int: Scanner] = [:]
    var scannerCoords = [[0, 0, 0]]
    
    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
        let raw = try! String(contentsOf: url).split(separator: "\n", omittingEmptySubsequences: false).split(separator: "")
        
        // Save data to dictionary of structs
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
            self.scannerDict[ID] = Scanner(A: A, B: B, C: C, coords: coords)
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
    
    // Generate all offsets and filter them
    func generateOffsets(A: [Int], B: [Int], C: [Int]) -> [[Int]: [[Int]]] {
        // Inital variables
        var offSetDict: [[Int]: [[Int]]] = [:]
        let comboA = [1, 1, 1, 1, -1, -1, -1, -1]
        let comboB = [1, 1, -1, -1, 1, 1, -1, -1]
        let comboC = [1, -1, 1, -1, 1, -1, 1, -1]
        
        // Loop through all combinations
        for fixedCoord in scannerDict[0]!.coords {
            for floatingIdx in 0..<A.count {
                for comboIdx in 0..<comboA.count {
                    // Create offset
                    let offSetA = fixedCoord[0] - (comboA[comboIdx] * A[floatingIdx])
                    let offSetB = fixedCoord[1] - (comboB[comboIdx] * B[floatingIdx])
                    let offSetC = fixedCoord[2] - (comboC[comboIdx] * C[floatingIdx])
                    let offSet = [offSetA, offSetB, offSetC]
                    
                    // Save data
                    if offSetDict[offSet] == nil {
                        offSetDict[offSet] = [[comboA[comboIdx], comboB[comboIdx], comboC[comboIdx]]]
                    } else {
                        offSetDict[offSet]!.append([comboA[comboIdx], comboB[comboIdx], comboC[comboIdx]])
                    }
                }
            }
        }
        
        // We should see at least 12 points overlap but will need to confirm they are the correct ones later
        return offSetDict.filter { $1.count >= 12 }
    }
    
    // Test all the different +/- combos
    func test(A: [Int], B: [Int], C: [Int]) -> Bool {
        // Create all the combinations
        let offSetDict = generateOffsets(A: A, B: B, C: C)
        
        // Loop through all the filtered combinations
        for (offSet, signArray) in offSetDict {
            for sign in Set(signArray) {
                // Try an offset
                let tempA = A.map{offSet[0] + sign[0] * $0}
                let tempB = B.map{offSet[1] + sign[1] * $0}
                let tempC = C.map{offSet[2] + sign[2] * $0}
                
                // Compare new data set to see how much overlap there is
                let tempCoords = createCoordSet(A: tempA, B: tempB, C: tempC)
                let count = scannerDict[0]!.coords.filter(tempCoords.contains).count
                
                // If there is enough overlap save results
                if count >= 12 {
                    scannerDict[0]!.coords.formUnion(tempCoords)
                    scannerCoords.append([offSet[0], offSet[1], offSet[2]])
                    return true
                }
            }
        }
        return false
    }
    
    // Ordering function
    func run(idx: Int) -> Bool {
        // Initial conditions
        var combo = 0
        let tempA = scannerDict[idx]!.A
        let tempB = scannerDict[idx]!.B
        let tempC = scannerDict[idx]!.C
        
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
            if test(A: A, B: B, C: C) {
                return true
            } else {
                combo += 1
            }
        }
    }
    
    // Part 1
    public func part1() {
        // Run until everything is brought into 0 frame
        while scannerDict.count != 1 {
            print("Scanners remaining: ", scannerDict.count)
            for (idx, _) in scannerDict {
                if idx != 0 {
                    if run(idx: idx) {
                        scannerDict.removeValue(forKey: idx)
                        break
                    }
                }
            }
        }
        print("Part 1:", scannerDict[0]!.coords.count)
    }
        
    // Part 2
    public func part2() {
        var maxManhattan = [Int]()
        
        for alpha in scannerCoords {
            for beta in scannerCoords {
                maxManhattan.append(abs(alpha[0] - beta[0]) + abs(alpha[1] - beta[1]) + abs(alpha[2] - beta[2]))
                maxManhattan.append(abs(beta[0] - alpha[0]) + abs(beta[1] - alpha[1]) + abs(beta[2] - alpha[2]))
            }
        }
        print("Part 2: ", maxManhattan.max()!)
    }
}
