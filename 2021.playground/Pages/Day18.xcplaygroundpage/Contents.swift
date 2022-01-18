import Foundation

// Mappings for creating strings or arrays
let str2num = ["[": -1,
               "]": -2,
               ",": -3,
               "0": 0,
               "1": 1,
               "2": 2,
               "3": 3,
               "4": 4,
               "5": 5,
               "6": 6,
               "7": 7,
               "8": 8,
               "9": 9]
var num2str = [Int: String]()
for pair in str2num { num2str[pair.value] = pair.key }

// Import data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let nums = try String(contentsOf: url).split(separator: "\n")

// Convert string to numeric array
func stringToNumArray(numString: String) -> [Int] {
    var numArray = [Int]()
    for num in numString {
        numArray.append(str2num[String(num)]!)
    }
    
    return numArray
}

// Convert numeric array to string
func numArrayToString(numArray: [Int]) -> String {
    var strArray = [String]()
    for num in numArray {
        strArray.append(num2str[num]!)
    }

    return strArray.joined()
}

// Add two snail fish numbers together
func add(A: String, B: String) -> String {
    var result = "[" + B + "]"
    let idx = result.index(result.startIndex, offsetBy: 1)

    result.insert(contentsOf: A + ",", at: idx)
    
    return result
}

// Split a snail fish number
func split(snailFishNum: String) -> String {
    var numArray = stringToNumArray(numString: snailFishNum)
    
    if let idx = numArray.firstIndex(where: { $0 >= 9 }) {          // Only for debugging... Change to 10
        let left = Int(floor(Double(numArray[idx] / 2)))
        let right = Int(ceil(Double(numArray[idx] / 2)))
        let insert = [-1, left, -3, right, -2]
            
        for x in insert.reversed() {
            numArray.insert(x, at: idx)
        }
        
        numArray.remove(at: idx + 5)
    }
    
    return numArrayToString(numArray: numArray)
}

//func reduce(input: String) -> String {
//    <#function body#>
//}

//func explode(<#parameters#>) {
////    To explode a pair, the pair's left value is added to the first regular number to the left of the exploding pair (if any), and the pair's right value is added to the first regular number to the right of the exploding pair (if any). Exploding pairs will always consist of two regular numbers. Then, the entire exploding pair is replaced with the regular number 0.
//}

// Main loop
let A = String(nums[0])
let B = String(nums[1])
let C = add(A: A, B: B)
let D = split(snailFishNum: C)

print(A)
print(B)
print(C)
print(D)
