import Foundation

// Mappings for creating strings or arrays
let str2num = ["[": -1,
               "]": -2,
               ",": -3]
var num2str = [Int: String]()
for pair in str2num { num2str[pair.value] = pair.key }

// Import data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let snailNums = try String(contentsOf: url).split(separator: "\n")

// Convert string to numeric array
func stringToNumArray(numString: String) -> [Int] {
    var numArray = [Int]()
    for num in numString {
        numArray.append(str2num[String(num)] ?? Int(String(num))!)
    }
    
    return numArray
}

// Convert numeric array to string
func numArrayToString(numArray: [Int]) -> String {
    var strArray = [String]()
    for num in numArray {
        strArray.append(num2str[num] ?? String(num))
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
    
    if let idx = numArray.firstIndex(where: { $0 >= 10 }) {
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

// Explode a snail fish number
func explode(snailFishNum: String) -> String {
    var numArray = stringToNumArray(numString: snailFishNum)
    let numIdxs = numArray.indices.filter {numArray[$0] >= 0}
    var count = 0
    
    for (idx, x) in numArray.enumerated() {
        // Count brackets
        if x == str2num["["]! {
            count += 1
        } else if x == str2num["]"]! {
            count -= 1
        }
        
        // Explode
        if count < 0 {
            count = 0
        } else if count > 4 {
            // Not a bracket or comma
            if x >= 0 {
                // Explode left
                if numIdxs.contains(where: { $0 < idx }) {
                    let leftIndex = numIdxs.last(where: { $0 < idx })!
                    numArray[leftIndex] += numArray[idx]
                }
                
                // Explode right
                if numIdxs.contains(where: { $0 > idx + 2 }) {
                    let rightIndex = numIdxs.first(where: { $0 > idx + 2 })!
                    numArray[rightIndex] += numArray[idx + 2]
                }
                
                // Remove previous grouping and replace with zero
                for _ in 0..<4 {
                    numArray.remove(at: idx - 1)
                }
                numArray[idx - 1] = 0
                
                // Return
                return numArrayToString(numArray: numArray)
            }
        }
    }
    
    return numArrayToString(numArray: numArray)
}

// Snail fish reduction
func reduce(input: String) -> String {
    var currentString = input
    var previousString = ""
    
    print("Start String: \t", currentString)
    var ii = 0
    
    while true {
        currentString = explode(snailFishNum: currentString)
        print("Explode \(ii): \t\t", currentString)
        
        currentString = split(snailFishNum: currentString)
        print("Split \(ii): \t\t", currentString)
        
        if currentString == previousString {
            return currentString
        }
        
        previousString = currentString
        ii += 1
    }
}


// Main loop
var masterNum = String(snailNums[0])
for i in 1..<snailNums.count {
    masterNum = add(A: masterNum, B: String(snailNums[i]))
    masterNum = reduce(input: masterNum)
}

print("Result:\t\t\t", masterNum)


//after addition: [[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]

//after explode:  [[[[0,7],4],[7,[[8,4],9]]],[1,1]]
//after explode:  [[[[0,7],4],[15,[0,13]]],[1,1]]

//after split:    [[[[0,7],4],[[7,8],[0,13]]],[1,1]]
//after split:    [[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]

//after explode:  [[[[0,7],4],[[7,8],[6,0]]],[8,1]]
