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
        let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
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
    func pathBuilder(u: Int, visited: inout [Bool], twice: Bool) -> Int {
        // End condition
        if u == mapping["end"] {
            return 1
        }
        
        // Mark a small cave
        if smallCaves.contains(u) {
            visited[u] = true
        }
        
        // Total
        var total = 0
        
        // Run through connected nodes
        for v in nodeDictionary[u]! {
            if (visited[v] == false) {
                total += pathBuilder(u: v, visited: &visited, twice: twice)
            }
        }
        
        // If we can visit a cave twice
        if twice {
            for v in nodeDictionary[u]! {
                if visited[v] == true && v != mapping["start"] {
                    total += pathBuilder(u: v, visited: &visited, twice: false)
                }
            }
        }

        // Mark as false for future solutions
        if !twice {
            visited[u] = false
        }
        
        return total
    }

    // Main logic
    func generateAllPaths(isPart2: Bool) -> Int {
        // Add the data
        for (u, v) in zip(U, V) {
            addNode(u: mapping[u]!, v: mapping[v]!)
            addNode(u: mapping[v]!, v: mapping[u]!)
        }
        
        // Initialize variables
        var visited = Array(repeating: false, count: mapping.count)
        
        // Return total paths from path builder
        return pathBuilder(u: mapping["start"]!, visited: &visited, twice: isPart2)
    }

    // Part 1
    public func part1() {
        print("Part 1: ", generateAllPaths(isPart2: false))
    }

    // Part 2
    public func part2() {
        print("Part 2: ", 000)
    }
}
