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
    
    // Create a set of all possible offsets between two data sets
    func createOffsetSet(A: [Int], B: [Int], C: [Int], newIdx: Int) -> Set<[Int]> {
        // Combinations
        let comboA = [1, 1, 1, 1, -1, -1, -1, -1]
        let comboB = [1, 1, -1, -1, 1, 1, -1, -1]
        let comboC = [1, -1, 1, -1, 1, -1, 1, -1]
        
        // Array of possible offsets
        var offsetSet = Set<[Int]>()
        
        // Loop through all combinations
        for fixedIdx in 0..<scannerDict[newIdx]!.A.count {
            for floatingIdx in 0..<A.count {
                for comboIdx in 0..<comboA.count {
                    // Combos
                    let offsetA = scannerDict[newIdx]!.A[fixedIdx] + comboA[comboIdx] * A[floatingIdx]
                    let offsetB = scannerDict[newIdx]!.B[fixedIdx] + comboB[comboIdx] * B[floatingIdx]
                    let offsetC = scannerDict[newIdx]!.C[fixedIdx] + comboC[comboIdx] * C[floatingIdx]
                    
                    // Set
                    offsetSet.insert([offsetA, offsetB, offsetC])
                }
            }
        }
        
        // Solution
        return offsetSet
    }
    
    // Test all the different +/- combos
    func test(A: [Int], B: [Int], C: [Int], newIdx: Int) -> Bool {
//        let offset = createOffsetSet(A: A, B: B, C: C, newIdx: newIdx)
        let offset = Set([[68, -1246, -43]])
        
        for off in offset {
            // Try an offset
            let tempA = A.map{$0 - off[0]}
            let tempB = B.map{$0 - off[1]}
            let tempC = C.map{$0 - off[2]}
            
            // Compare new data set to see how much overlap there is
            let tempCoords = createCoordSet(A: tempA, B: tempB, C: tempC)
            let count = scannerDict[newIdx]!.coords.filter(tempCoords.contains).count
            print(count)
            
            // If there is enough overlap save results
            if count >= 12 {
                scannerDict[newIdx]!.A.append(contentsOf: tempA)
                scannerDict[newIdx]!.B.append(contentsOf: tempB)
                scannerDict[newIdx]!.C.append(contentsOf: tempC)
                scannerDict[newIdx]!.coords.formUnion(tempCoords)
                print([off[0], off[1], off[2]])
                return true
            }
        }
        return false
    }
    
    // Ordering function
    func run(idx: Int, idxBase: Int) -> Bool {
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
            if test(A: A, B: B, C: C, newIdx: idxBase) {
                return true
            } else {
                combo += 1
            }
        }
    }
    
    // Part 1
    public func part1() {
        run(idx: 1, idxBase: 0)
        print("Done")
        
//        // Not sure if the zero case will work...
//        while scannerDict.count != 1 {
//            for (idx, _) in scannerDict {
//                if idx != 0 {
//                    print(idx)
//                    if run(idx: idx, idxBase: 0) {
//                        scannerDict.removeValue(forKey: idx)
//                        break
//                    }
//                }
//            }
//        }
//
//        print("Part 1:", scannerDict)
    }
        
    // Part 2
    public func part2() {
        print("Part 2: ", 000)
    }
}
