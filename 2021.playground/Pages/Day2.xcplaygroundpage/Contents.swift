import Foundation

// Import directions
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let directions = try String(contentsOf: url).split(separator: "\n")

// Initialize counter
struct Position {
    var horizontal = 0;
    var depth = 0;
    var aim = 0;
}

var position = Position()

// Loop through directions
for direction in directions {
    switch direction {
        case _ where direction.contains("forward"):
            let separated = direction.split(separator: " ")
            position.horizontal += Int(separated[1])!
        
            // Part 2
            position.depth += position.aim * Int(separated[1])!
        case _ where direction.contains("up"):
            let separated = direction.split(separator: " ")
//            Part 1
//            position.depth -= Int(separated[1])!
        
            // Part 2
            position.aim -= Int(separated[1])!
        case _ where direction.contains("down"):
            let separated = direction.split(separator: " ")
//            Part 1
//            position.depth += Int(separated[1])!
        
            // Part 2
            position.aim += Int(separated[1])!
        default:
            print("Error")
        }
}

// Print result
print("Part 1 and 2: ", position.horizontal * position.depth)
