import Foundation

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
            
    // Test all the different combos
    func test(coords2check: Set<[Int]>) -> Transform {
        let masterA = scannerArray[0].A
        let masterB = scannerArray[0].B
        let masterC = scannerArray[0].C
        let master = createCoordSet(A: masterA, B: masterB, C: masterC)
        
        let comboA = [1, 1, 1, 1, -1, -1, -1, -1]
        let comboB = [1, 1, -1, -1, 1, 1, -1, -1]
        let comboC = [1, -1, 1, -1, 1, -1, 1, -1]
        
        var maxCount = -1
        var maxArray = [0, 0, 0]
        
        for i in 0..<comboA.count {
            print(i)
//            let tempA = A.map{comboA[i] * $0 + transformA.translation}
//            let tempB = B.map{comboB[i] * $0 + transformB.translation}
//            let tempC = C.map{comboC[i] * $0 + transformC.translation}
//
//            let temp = createCoordSet(A: tempA, B: tempB, C: tempC)
//            let counter = master.filter(temp.contains).count
//
//            if counter > maxCount {
//                maxCount = counter
//                maxArray = [comboA[i], comboB[i], comboC[i]]
//            }
        }
        
        return Transform(translation:[1,2,3], transformedCoords: Set([[1]]), flag: true)
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
            
            // Check
            let tempCoords = createCoordSet(A: A, B: B, C: C)
            let transform = test(coords2check: tempCoords)
            
            // Append
            if transform.flag {
                scannerArray[0].coords.formUnion(transform.transformedCoords)
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
        
        print("Part 1:", scannerArray[0].coords.count)
    }
    
    // Part 2
    public func part2() {
        print("Part 2: ", 000)
    }
}
