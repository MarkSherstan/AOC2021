import Foundation

public class Day14 {
    var polymer: [Character]
    var insertRules: [String: Character] = [:]

    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "Day14", withExtension: "txt")!
        let input = try! String(contentsOf: url).split(separator: "\n")

        self.polymer = Array(input[0])
        let template = input[1..<input.endIndex]

        for entry in template {
            let split = entry.components(separatedBy: " -> ")
            let pointer = Character(split[1])
            let elements = split[0]

            self.insertRules[elements] = pointer
        }
    }
    
    // Quick function for adding a polymer to the dict
    func addPolymer(polymerDict: inout [String: Int], key: String, count: Int) {
        if polymerDict[key] == nil {
            polymerDict[key] = count
        } else {
            polymerDict[key]! += count
        }
    }
    
    // Quick function for adding an element to the dict
    func addElement(elementDict: inout [Character: Int], key: Character, count: Int) {
        if elementDict[key] == nil {
            elementDict[key] = count
        } else {
            elementDict[key]! += count
        }
    }

    // Simulate steps
    func simulate(polymer: [Character], numSteps: Int) -> Int {
        // Dictionaries
        var polymerDict: [String: Int] = [:]
        var polymerDict2: [String: Int] = [:]

        // Initial polymer dict
        for i in 0..<polymer.count-1 {
            let key = String(polymer[i]) + String(polymer[i+1])
            
            addPolymer(polymerDict: &polymerDict, key: key, count: 1)
        }
        
        // The polymer
        for _ in 1...numSteps {
            for (key, value) in polymerDict {
                let firstPair = String(key[key.startIndex]) + String(insertRules[key]!)
                let secondPair = String(insertRules[key]!) + String(key[key.index(before: key.endIndex)])
                
                addPolymer(polymerDict: &polymerDict2, key: firstPair, count: value)
                addPolymer(polymerDict: &polymerDict2, key: secondPair, count: value)
            }
            
            polymerDict = polymerDict2
            polymerDict2 = [:]
        }
        
        // Get elements
        var elementDict: [Character: Int] = [polymer[polymer.count-1]: 1]
        for (key, value) in polymerDict {
            let elem = key[key.startIndex]
            addElement(elementDict: &elementDict, key: elem, count: value)
        }
        
        // Solution
        return elementDict.values.max()! - elementDict.values.min()!
    }

    // Part 1
    public func part1() -> String {
        return String(simulate(polymer: polymer, numSteps: 10))
    }

    // Part 2
    public func part2() -> String {
        return String(simulate(polymer: polymer, numSteps: 40))
    }
}
