import Foundation

// Position structure
struct Position {
    var horizontal = 0;
    var depth = 0;
    var aim = 0;
}

public class Day2 {
    var directions: [Substring]
    
    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "Day2", withExtension: "txt")!
        self.directions = try! String(contentsOf: url).split(separator: "\n")
    }
    
    // Main logic
    func navigate(part: Int) -> Int {
        var position = Position()
        
        // Loop through directions
        for direction in directions {
            switch direction {
            case _ where direction.contains("forward"):
                let separated = direction.split(separator: " ")
                position.horizontal += Int(separated[1])!
                
                if part == 2 {
                    position.depth += position.aim * Int(separated[1])!
                }
            case _ where direction.contains("up"):
                let separated = direction.split(separator: " ")
                
                if part == 1 {
                    position.depth -= Int(separated[1])!
                } else if part == 2 {
                    position.aim -= Int(separated[1])!
                }
            case _ where direction.contains("down"):
                let separated = direction.split(separator: " ")
                
                if part == 1 {
                    position.depth += Int(separated[1])!
                } else if part == 2 {
                    position.aim += Int(separated[1])!
                }
            default:
                ()
            }
        }
        
        return position.horizontal * position.depth
    }
    
    // Part 1
    public func part1() {
        print("Part 1: ", navigate(part: 1))
    }
    
    // Part 2
    public func part2() {
        print("Part 2: ", navigate(part: 2))
    }
}
