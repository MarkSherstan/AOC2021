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

// Import raw data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let raw = try String(contentsOf: url).split(separator: "\n", omittingEmptySubsequences: false).split(separator: "")

// Save data to array of structs
var scannerArray = [Scanner]()

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
    
    scannerArray.append(Scanner(ID: ID, A: A, B: B, C: C))
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

    // Find the max number of occurances
    let maxVal = occurrences.values.max()!
    
    // Return offset
    if maxVal >= 12 {
        return occurrences.key(forValue: maxVal)!
    } else {
        return 0
    }
}

// Function for checking directions
func directionMachine(littleScanner: [Int], masterScanner: [Int]) -> Transform {
    // Variable declaration
    var tempArray = [Int]()
    var offset = 0
    
    // Check positive case
    for little in littleScanner {
        tempArray.append(contentsOf: masterScanner.map{$0 + little})
    }
    
    // Results and prep for next loop
    offset = mode(numbers: tempArray)
    if offset != 0 {
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
    if offset != 0 {
        return Transform(direction: 1, translation: offset, flag: true)
    } else {
        return Transform(direction: 0, translation: 0, flag: false)
    }
}

let masterA = scannerArray[0].A
let masterB = scannerArray[0].B
let masterC = scannerArray[0].C

let A = scannerArray[1].A
let B = scannerArray[1].B
let C = scannerArray[1].C

let transformA = directionMachine(littleScanner: A, masterScanner: masterA)
let transformB = directionMachine(littleScanner: B, masterScanner: masterB)
let transformC = directionMachine(littleScanner: C, masterScanner: masterC)


if (transformA.flag && transformB.flag && transformC.flag) {
    // Add scanner # to master with matching coordinate system
    scannerArray[0].A.append(contentsOf: A.map{transformA.direction * $0 + transformA.translation})
    scannerArray[0].B.append(contentsOf: B.map{transformB.direction * $0 + transformB.translation})
    scannerArray[0].C.append(contentsOf: C.map{transformC.direction * $0 + transformC.translation})
} else {
    print("Nope")
    // Swap around A B C here -> Switch case of all combos? Just have a state. Put all of this in a while loop (and a for loop for the array)
}



// Once we find a match... Need to make a master array for comparison with everything orientated properly
// First grouping is just +/-
// Still need to account for swapping
// Make a function....
