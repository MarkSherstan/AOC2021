import Foundation

// Reverse dictionary lookup extension
extension Dictionary where Value: Equatable {
    func key(from value: Value) -> Key? {
        return self.first(where: { $0.value == value })?.key
    }
}

// Import data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let roughMap = try String(contentsOf: url).split(separator: "\n")

// Split data into two arrays and create mapping from string to a number
var U = [String]()
var V = [String]()

for entry in roughMap {
    let temp = entry.split(separator: "-")
    U.append(String(temp[0]))
    V.append(String(temp[1]))
}

let nodeSet = Set(U+V)
var mapping: [String: Int] = [:]

for (idx, node) in nodeSet.enumerated() {
    mapping[node] = idx
}

// Global variables
var nodeDictionary: [Int: [Int]] = [:]

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
    // Mark current node as visisted
    visited[u] = true
    path.append(u)
    
    // Try and reach the destination
    if u == d {
        for p in path {
            print(mapping.key(from: p)!, terminator: " ")
        }
        print("\n")
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

// Run the calc
generateAllPaths(start: mapping["start"]!, end: mapping["end"]!, numNodes: mapping.count)
