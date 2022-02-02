import Foundation

// Scanner struct
struct Scanner {
    let ID: Int
    var A: [Int]
    var B: [Int]
    var C: [Int]
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
    var occurrences: [Int: Int] = [:]
    for number in numbers {
        if occurrences[number] == nil {
            occurrences[number] = 1
        } else {
            occurrences[number]! += 1
        }
    }

    return occurrences.values.max()!
}

// Function for checking directions
func directionMachine(littleScanner: [Int], masterScanner: [Int]) -> Int {
    // Variable declaration
    var tempArray = [Int]()
    
    // Check positive case
    for little in littleScanner {
        tempArray.append(contentsOf: masterScanner.map{$0 + little})
    }
    
    // Results and prep for next loop
    if mode(numbers: tempArray) >= 12 {
        return 1
    } else {
        tempArray.removeAll()
    }
    
    // Check negative case
    for little in littleScanner {
        tempArray.append(contentsOf: masterScanner.map{$0 - little})
    }
    
    // Results
    if mode(numbers: tempArray) >= 12 {
        return -1
    } else {
        return 0
    }
}

let masterA = scannerArray[0].A
let masterB = scannerArray[0].B
let masterC = scannerArray[0].C

let A = scannerArray[1].A
let B = scannerArray[1].B
let C = scannerArray[1].C

var arrayA = [Int]()
var arrayB = [Int]()
var arrayC = [Int]()

// Still need to switch columns
for a in A {
    arrayA.append(contentsOf: masterA.map{$0 + a})
}

for b in B {
    arrayB.append(contentsOf: masterB.map{$0 - b})
}

for c in C {
    arrayC.append(contentsOf: masterC.map{$0 + c})
}

print(mode(numbers: arrayA), mode(numbers: arrayB), mode(numbers: arrayC))
print(directionMachine(littleScanner: A, masterScanner: masterA))
print(directionMachine(littleScanner: B, masterScanner: masterB))
print(directionMachine(littleScanner: C, masterScanner: masterC))

// Once we find a match... Need to make a master array for comparison with everything orientated properly
// First grouping is just +/-
// Still need to account for swapping
// Make a function....

//print(scannerArray.count, scannerArray[0].ID, scannerArray[0].A)
