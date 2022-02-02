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

// Print
print(scannerArray.count, scannerArray[0].ID, scannerArray[0].A)
