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
func add(A: [Int], B: [Int]) -> [Int] {
    var result = B
    result.insert(str2num["["]!, at: result.startIndex)
    result.insert(str2num["]"]!, at: result.endIndex)
    
    var newElement = A
    newElement.append(str2num[","]!)
    
    let idx = result.index(result.startIndex, offsetBy: 1)
    result.insert(contentsOf: newElement, at: idx)
    
    return result
}

// Split a snail fish number
func split(numArray: inout [Int]) {
    if let idx = numArray.firstIndex(where: { $0 >= 10 }) {
        let left = Int(floor(Double(numArray[idx]) / 2.0))
        let right = Int(ceil(Double(numArray[idx]) / 2.0))
        let insert = [-1, left, -3, right, -2]
            
        for x in insert.reversed() {
            numArray.insert(x, at: idx)
        }
        
        numArray.remove(at: idx + 5)
    }
}

// Explode a snail fish number
func explode(numArray: inout [Int]) -> Bool {
    let numIdxs = numArray.indices.filter {numArray[$0] >= 0}
    var count = 0
    
    for idx in 0..<numArray.count - 3 {
        // Count brackets
        if numArray[idx] == str2num["["]! {
            count += 1
        } else if numArray[idx] == str2num["]"]! {
            count -= 1
        }
        
        // Explode
        if count > 4 {
            // Not a bracket or comma
            if (numArray[idx] >= 0) && (numArray[idx + 1] == str2num[","]!) && (numArray[idx + 2] >= 0) && (numArray[idx + 3] == str2num["]"]!) {
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
                
                // Exit
                return false
            }
        }
    }
    
    // All explodes satisfied
    return true
}

// Snail fish reduction
func reduce(input: [Int]) -> [Int] {
    var current = input
    var previous = [Int]()
    
    // Run until we cant reduce anymore
    while true {
        // Keep exploding until we cant explode anymore
        while true {
            if explode(numArray: &current) {break}
        }

        // Split
        split(numArray: &current)
        
        // Exit condition
        if current == previous {
            return current
        }
        previous = current
    }
}

// Magnitude
func magnitude(snailFishNum: inout [Int]) -> Int {
    while true {
        // Magnitude entry
        for idx in 0..<snailFishNum.count - 4 {
            if (snailFishNum[idx] == str2num["["]!) && (snailFishNum[idx + 1] >= 0) && (snailFishNum[idx + 2] == str2num[","]!) && (snailFishNum[idx + 3] >= 0) && (snailFishNum[idx + 4] == str2num["]"]!) {
                // Calculate mag
                let mag = (3 * snailFishNum[idx + 1]) + (2 * snailFishNum[idx + 3])
                
                // Remove and replace old elements
                for _ in 0..<4 {
                    snailFishNum.remove(at: idx)
                }
                snailFishNum[idx] = mag
                
                // Exit out of for loop
                break
            }
        }
        
        // Exit condition
        if snailFishNum.count == 1 {
            return snailFishNum[0]
        }
    }
}

// Main loop
var masterArray = stringToNumArray(numString: String(snailNums[0]))

for i in 1..<snailNums.count {
    masterArray = add(A: masterArray, B: stringToNumArray(numString: String(snailNums[i])))
    masterArray = reduce(input: masterArray)
}

print("[[[[6,6],[7,6]],[[7,7],[7,0]]],[[[7,7],[7,7]],[[7,8],[9,9]]]]")
print(numArrayToString(numArray: masterArray))
print("Part 1: ", magnitude(snailFishNum: &masterArray))
