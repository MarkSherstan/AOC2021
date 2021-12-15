import Foundation

// Import directions
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let directions = try String(contentsOf: url).split(separator: "\n")

// Initialize counter
struct Position {
    var forward = 0;
    var up = 0;
    var down = 0;
}

var position = Position()

// Loop through directions
for direction in directions {
    switch direction {
        case _ where direction.contains("forward"):
            let separated = direction.split(separator: " ")
            position.forward += Int(separated[1])!
        
        case _ where direction.contains("up"):
            let separated = direction.split(separator: " ")
            position.up += Int(separated[1])!
            
        case _ where direction.contains("down"):
            let separated = direction.split(separator: " ")
            position.down += Int(separated[1])!
        
        default:
            print("Error")
        }
}

// Print result
print("Part 1: ", position.forward * (position.down - position.up))
