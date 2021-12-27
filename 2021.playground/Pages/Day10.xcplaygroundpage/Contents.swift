import Foundation

// Import data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let input = try String(contentsOf: url).split(separator: "\n")

// Initialize
var movingBuffer = [Character]()
var wrongArray = [Character]()
var expected = [Character]()
var closingScore = [Int]()

extension Array {
    var middle: Element? {
        guard count != 0 else { return nil }
        let middleIndex = (count > 1 ? count - 1 : count) / 2
        return self[middleIndex]
    }
}

func calcClosingScore(completionArray: [Character]) -> Int {
    // Initialize
    var score = 0
    var mapping: [Character: Int] = [:]
    mapping[")"] = 1
    mapping["]"] = 2
    mapping["}"] = 3
    mapping[">"] = 4
    
    for c in completionArray {
        score *= 5
        score += mapping[c]!
    }
    
    return score
}

for line in input {
    movingBuffer.removeAll()
    expected = [Character]()
lineLoop: for c in line {
        if (c == "(") || (c == "[") || (c == "{") || (c == "<") {
            movingBuffer.append(c)
            
            switch c {
            case "(":
                expected.append(")")
            case "[":
                expected.append("]")
            case "{":
                expected.append("}")
            case "<":
                expected.append(">")
            default:
                ()
            }
        } else if (c == ")") || (c == "]") || (c == "}") || (c == ">") {
            switch c {
            case ")":
                if expected.last == c {
                    if let idx = movingBuffer.lastIndex(of: "(") {
                        movingBuffer.remove(at: idx)
                    }
                    expected.removeLast()
                } else {
                    wrongArray.append(")")
                    expected.removeAll()
                    break lineLoop
                }
            case "]":
                if expected.last == c {
                    if let idx = movingBuffer.lastIndex(of: "[") {
                        movingBuffer.remove(at: idx)
                    }
                    expected.removeLast()
                } else {
                    wrongArray.append("]")
                    expected.removeAll()
                    break lineLoop
                }
            case "}":
                if expected.last == c {
                    if let idx = movingBuffer.lastIndex(of: "{") {
                        movingBuffer.remove(at: idx)
                    }
                    expected.removeLast()
                } else {
                    wrongArray.append("}")
                    expected.removeAll()
                    break lineLoop
                }
            case ">":
                if expected.last == c {
                    if let idx = movingBuffer.lastIndex(of: "<") {
                        movingBuffer.remove(at: idx)
                    }
                    expected.removeLast()
                } else {
                    wrongArray.append(">")
                    expected.removeAll()
                    break lineLoop
                }
            default:
                ()
            }
        }
    }
    
    // Find the autocomplete score
    if !expected.isEmpty {
        expected.reverse()
        closingScore.append(calcClosingScore(completionArray: expected))
    }

}

// Calculate the score
var score = 0
var mapping: [Character: Int] = [:]
mapping[")"] = 3
mapping["]"] = 57
mapping["}"] = 1197
mapping[">"] = 25137

for wrong in wrongArray {
    score += mapping[wrong]!
}

closingScore.sort()

// Results
print("Part 1: ", score)
print("Part 2: ", closingScore.middle!)
