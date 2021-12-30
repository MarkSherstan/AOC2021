import Foundation

public class Day14 {
    var polymer: [Character]
    var mapping: [String: Character] = [:]

    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
        let input = try! String(contentsOf: url).split(separator: "\n")

        self.polymer = Array(input[0])
        let template = input[1..<input.endIndex]

        for entry in template {
            let split = entry.components(separatedBy: " -> ")
            let key = Character(split[1])
            let elements = split[0]

            self.mapping[elements] = key
        }

    }
    
    func simulate(numDays: Int) {
        // Grow the polymer
        for day in 1...numDays {
            var low = 0
            var high = 1
            
            for _ in 0..<polymer.count-1 {
                let elements = String(polymer[low]) + String(polymer[high])
                polymer.insert(mapping[elements]!, at: high)
                
                // Index
                low += 2
                high += 2
            }
            
            print(day, polymer.count)
        }
    }

    // Part 1
    public func part1() {
        simulate(numDays: 10)
        let mappedItems = polymer.map { ($0, 1) }
        let counts = Dictionary(mappedItems, uniquingKeysWith: +)
        print("Part 1: ", counts.values.max()! - counts.values.min()!)
    }

    // Part 2
    public func part2() {
        print("Part 2: ", 000)
    }
}
