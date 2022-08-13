import Foundation

public class Day8 {
    var pattern: [String]
    var output: [String]
    
    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "Day8", withExtension: "txt")!
        let data = try! String(contentsOf: url).split(separator: "\n")
        
        self.pattern = [String]()
        self.output = [String]()
        
        for dat in data {
            let temp = dat.split(separator: "|")
            self.pattern.append(String(temp[0]))
            self.output.append(String(temp[1]))
        }
    }
    
    // Part 1
    public func part1() -> String {
        var total = 0

        for out in output {
            let temp = out.split(separator: " ")
            
            for digit in temp {
                if (digit.count == 2) || (digit.count == 3) || (digit.count == 4) || (digit.count == 7) {
                    total += 1
                }
            }
        }

        return String(total)
    }
    
    // Part 2
    public func part2() -> String {
        var values = [Int]()

        for (pat, out) in zip(pattern, output) {
            // Split the pattern data and initialize the mapping
            var temp = pat.split(separator: " ")
            var mapping: [Int: Substring] = [:]
            
            // Get the easy values
            for digit in temp {
                switch digit.count {
                case 2:
                    mapping[1] = digit
                case 3:
                    mapping[7] = digit
                case 4:
                    mapping[4] = digit
                case 7:
                    mapping[8] = digit
                default:
                    ()
                }
            }
            
            // Do the more difficult values
            for digit in temp {
                if digit.count == 5 {
                    var eight = Set(mapping[8]!)
                    let four = Array(mapping[4]!)
                    eight.subtract(four)
                    let eightMinusFour = String(Array(eight))
         
                    if mapping[1]!.allSatisfy(Array(digit).contains) {
                        mapping[3] = digit
                    } else if eightMinusFour.allSatisfy(Array(digit).contains) {
                        mapping[2] = digit
                    } else {
                        mapping[5] = digit
                    }
                } else if digit.count == 6 {
                    if !mapping[1]!.allSatisfy(Array(digit).contains) {
                        mapping[6] = digit
                    } else if mapping[4]!.allSatisfy(Array(digit).contains) {
                        mapping[9] = digit
                    } else {
                        mapping[0] = digit
                    }
                }
            }
            
            // Split the output data and initialize a few more variables
            var numBuilder = [String]()
            temp = out.split(separator: " ")
            
            // Loop and store the decoded values
            for digit in temp {
                for i in 0...9 {
                    if Array(mapping[i]!).sorted() == Array(digit).sorted() {
                        numBuilder.append(String(i))
                    }
                }
            }
            
            // Save the string to actual int
            values.append(Int(numBuilder.joined(separator: ""))!)
        }

        // Results
        return String(values.reduce(0, +))
    }
}
