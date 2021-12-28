import Foundation

// Find middle element in array
extension Array {
    var middle: Element? {
        guard count != 0 else { return nil }
        let middleIndex = (count > 1 ? count - 1 : count) / 2
        return self[middleIndex]
    }
}

public class Day10 {
    var input: [Substring]
    
    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
        self.input = try! String(contentsOf: url).split(separator: "\n")
    }
    
    // Main logic
    func run(isPart2: Bool) -> [Int] {
        // Initialize
        var movingBuffer = [Character]()
        var wrongArray = [Character]()
        var expected = [Character]()
        var closingScore = [Int]()
        
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
            } // line loop
            
            // Find the autocomplete score
            if !expected.isEmpty {
                expected.reverse()
                closingScore.append(calcClosingScore(completionArray: expected))
            }
        }
        
        if isPart2 {
            closingScore.sort()
            return closingScore
        } else {
            return calcWrongScore(wrongArray: wrongArray)
        }
    }
    
    // Score for wrong brackets
    func calcWrongScore(wrongArray: [Character]) -> [Int] {
        var score = 0
        var mapping: [Character: Int] = [:]
        mapping[")"] = 3
        mapping["]"] = 57
        mapping["}"] = 1197
        mapping[">"] = 25137

        for wrong in wrongArray {
            score += mapping[wrong]!
        }
        
        return [score]
    }
    
    // Score calculation for closing brackets
    func calcClosingScore(completionArray: [Character]) -> Int {
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
    
    // Part 1
    public func part1() {
        let wrongScore = run(isPart2: false)
        print("Part 1: ", wrongScore[0])
    }
    
    // Part 2
    public func part2() {
        let closingScore = run(isPart2: true)
        print("Part 2: ", closingScore.middle!)
    }
}
