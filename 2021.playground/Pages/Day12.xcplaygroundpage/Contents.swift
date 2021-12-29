import Foundation

// Reverse dictionary lookup extension
extension Dictionary where Value: Equatable {
    func key(from value: Value) -> Key? {
        return self.first(where: { $0.value == value })?.key
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
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
    // Mark current node as visisted
    visited[u] = true
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

// Filter the start to node paths
func filterS2N(masterPathArray: [[Int]]) -> [[Int]] {
    // Variables
    var out = [[Int]]()
    
    // Remove duplicates and all instances of end
    let pathSetArray = Set(masterPathArray)
    
    for x in pathSetArray {
        if !x.contains(mapping["end"]!) {
            out.append(x)
        }
    }
    
    return out
}

// Create a dictionary holding the node to end paths
func createN2Edict(masterPathArray: [[Int]]) -> [Int: [[Int]]] {
    // Variables
    var dict: [Int: [[Int]]] = [:]
    
    // Remove duplicates and all instances of end
    let pathSetArray = Set(masterPathArray)
    
    for x in pathSetArray {
        if !x.contains(mapping["start"]!) {
            
            if dict[x.first!] == nil {
                dict[x.first!] = [x]
            } else {
                dict[x.first!]?.append(contentsOf: [x])
            }
        }
    }
    
    return dict
}

// Print results
func printer(someArray: [Int]) {
    for x in someArray {
        print(mapping.key(from: x)!, terminator: " ")
    }
    print()
}

// Run the calc from start to every node
for v in V {
    generateAllPaths(start: mapping["start"]!, end: mapping[v]!, numNodes: mapping.count)
}

var start2node = filterS2N(masterPathArray: masterPathArray)
masterPathArray.removeAll()

// Run the calc from every node to end
for s2n in start2node {
    generateAllPaths(start: s2n.last!, end: mapping["end"]!, numNodes: mapping.count)
}

// Match up paths - start to end
var node2end = createN2Edict(masterPathArray: masterPathArray)
var start2end = [[Int]]()

for s2n in start2node {
    var frontPath = s2n
    frontPath.removeLast()
    
    for pathRemaining in node2end[s2n.last!]! {
        // Remove last element and replace with path
        var completePath = frontPath
        
        for remaing in pathRemaining {
            completePath.append(remaing)
        }
                
        start2end.append(completePath)
    }
}

// Remove small caves being visited more than once
var solutions = [[Int]]()
var discards = [[Int]]()

func smallCaveCheck(somePath: [Int]) -> Bool {
    let frequencyMap = somePath.map { ($0, 1) }
    let frequencyDic = Dictionary(frequencyMap, uniquingKeysWith: +)
        
    for (key, value) in frequencyDic {
        if smallCaves.contains(key) {
            if value > 1 {
                return false
            }
        }
    }
    
    return true
}

for s2e in start2end {
    if smallCaveCheck(somePath: s2e) {
        solutions.append(s2e)
    } else {
        discards.append(s2e)
    }
}

var goodTacos = Set(solutions)
print("Solution: ", goodTacos.count)
for taco in goodTacos {
    printer(someArray: taco)
}

var badTacos = Set(discards)
print("Bad: ", badTacos.count)
for taco in badTacos {
    printer(someArray: taco)
}

//start,A,b,A,c,A,end
//start,A,b,A,end           5
//start,A,b,end             1
//start,A,c,A,b,A,end
//start,A,c,A,b,end         3
//start,A,c,A,end           8
//start,A,end               6
//start,b,A,c,A,end         2
//start,b,A,end             4
//start,b,end               7
