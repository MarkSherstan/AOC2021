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
    func pathBuilder(u: Int, d: Int, visited: inout [Bool], path: inout [Int]) {
        // Mark visited if a small cave
        if smallCaves.contains(u) {
            visited[u] = true
        }
        path.append(u)
        
        // Try and reach the destination
        if u == d {
            masterPathArray.append(path)
        } else {
            for v in nodeDictionary[u]! {
                if visited[v] == false {
                    pathBuilder(u: v, d: d, visited: &visited, path: &path)
                }
            }
        }
        
        // Remove current node and label as unvisited to force a new solution
        path.removeLast()
        visited[u] = false
    }

    // Main logic
    func generateAllPaths(start: Int, end: Int, numNodes: Int) {
        // Add the data
        for (u, v) in zip(U, V) {
            addNode(u: mapping[u]!, v: mapping[v]!)
            addNode(u: mapping[v]!, v: mapping[u]!)
        }
        
        // Initialize variables
        var visited = Array(repeating: false, count: numNodes)
        var path = [Int]()
        
        // Start the path builder
        pathBuilder(u: start, d: end, visited: &visited, path: &path)
    }

    // Part 1
    public func part1() {        
        // Run the path builder and print results
        generateAllPaths(start: mapping["start"]!, end: mapping["end"]!, numNodes: mapping.count)
        print("Part 1: ", masterPathArray.count)
    }

    // Part 2
    public func part2() {
        print("Part 2: ", 000)
    }
}
