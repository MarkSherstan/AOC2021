import Foundation

// Import data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let input = try String(contentsOf: url).split(separator: "\n")

//
var movingBuffer = [Character]()
var wrongArray = [Character]()
var expected = [Character]()

//            {([(<{}[<>[]}>{[]{[(<()>      Expected ], but found } instead.
//                        ^

for line in input {
    movingBuffer = [Character]() //.removeAll()
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
                    break lineLoop
                }
            default:
                ()
            }
        }
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

// Results
print("Part 1: ", score)
