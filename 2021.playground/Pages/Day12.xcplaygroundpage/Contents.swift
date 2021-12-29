import Foundation

// Allow indexing of strings
extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

// Import data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let roughMap = try String(contentsOf: url).split(separator: "\n")

// Split data into two arrays
var U = [String]()
var V = [String]()

for entry in roughMap {
    let temp = entry.split(separator: "-")
    U.append(String(temp[0]))
    V.append(String(temp[1]))
}

// Create mapping from string to a number and save small caves
let nodeSet = Set(U+V)
var mapping: [String: Int] = [:]
var smallCaves = [Int]()

for (idx, node) in nodeSet.enumerated() {
    mapping[node] = idx
}

for node in nodeSet {
    if node[0].isLowercase {
        smallCaves.append(mapping[node]!)
    }
}

// Global variables
var nodeDictionary: [Int: [Int]] = [:]
var masterPathArray = [[Int]]()

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
    // Initialize variables
    var visited = Array(repeating: false, count: numNodes)
    var path = [Int]()
    
    // Start the path builder
    pathBuilder(u: start, d: end, visited: &visited, path: &path)
}

// Add the data
for (u, v) in zip(U, V) {
    addNode(u: mapping[u]!, v: mapping[v]!)
    addNode(u: mapping[v]!, v: mapping[u]!)
}

// Run the path builder and print results
generateAllPaths(start: mapping["start"]!, end: mapping["end"]!, numNodes: mapping.count)
print("Part 1: ", masterPathArray.count)
