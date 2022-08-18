import Foundation

// Allow indexing of strings
extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

public class Day12 {
    // Global variables
    var U = [String]()
    var V = [String]()
    var nodeDictionary: [Int: [Int]] = [:]
    var mapping: [String: Int] = [:]
    var masterPathArray = [[Int]]()
    var smallCaves = [Int]()
    
    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "Day12", withExtension: "txt")!
        let roughMap = try! String(contentsOf: url).split(separator: "\n")
        
        // Split data into two arrays
        for entry in roughMap {
            let temp = entry.split(separator: "-")
            self.U.append(String(temp[0]))
            self.V.append(String(temp[1]))
        }

        // Create mapping from string to a number
        let nodeSet = Set(self.U+self.V)
        for (idx, node) in nodeSet.enumerated() {
            self.mapping[node] = idx
        }

        // Save array of small caves
        for node in nodeSet {
            if node[0].isLowercase {
                self.smallCaves.append(mapping[node]!)
            }
        }
    }

    // Add a node (from u to v)
    func addNode(u: Int, v: Int) {
        if nodeDictionary[u] == nil {
            nodeDictionary[u] = [v]
        } else {
            nodeDictionary[u]?.append(v)
        }
    }

    // Recursive path builder
    func pathBuilder(u: Int, visited: inout Set<Int>, twice: Int) -> Int {
        // End condition
        if u == mapping["end"] {
            return 1
        }
        
        // Mark a small cave
        if smallCaves.contains(u) {
            visited.insert(u)
        }
        
        // Total
        var total = 0
        
        // Run through connected nodes
        for v in nodeDictionary[u]! {
            if (!visited.contains(v)) {
                total += pathBuilder(u: v, visited: &visited, twice: twice)
            }
        }
        
        // If we can visit a cave twice (fire once to start the sequence)
        if twice == -2 {
            for v in nodeDictionary[u]! {
                if visited.contains(v) && v != mapping["start"] {
                    total += pathBuilder(u: v, visited: &visited, twice: v)
                }
            }
        }

        // Can we remove to allow for future solutions
        if u != twice {
            visited.remove(u)
        }
        
        return total
    }

    // Main logic
    func generateAllPaths(part: Int) -> Int {
        // Add the data
        if nodeDictionary.isEmpty {
            for (u, v) in zip(U, V) {
                addNode(u: mapping[u]!, v: mapping[v]!)
                addNode(u: mapping[v]!, v: mapping[u]!)
            }
        }

        // Initialize variables
        var visited = Set<Int>()
        
        // Return total paths from path builder
        return pathBuilder(u: mapping["start"]!, visited: &visited, twice: part)
    }

    // Part 1
    public func part1() -> String {
        return String(generateAllPaths(part: -1))
    }

    // Part 2
    public func part2() -> String {
        return String(generateAllPaths(part: -2))
    }
}
