import Foundation

// Import data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let input = try String(contentsOf: url).split(separator: "\n", omittingEmptySubsequences: false).split(separator: "")
let coords = input[0]
let folds = input[1]

// Build out matrix
var x = [Int]()
var y = [Int]()

for coord in coords {
    let point = coord.split(separator: ",")
    
    x.append(Int(point[0])!)
    y.append(Int(point[1])!)
}

var mat = Array(repeating: Array(repeating: 0, count: x.max()!+1), count: y.max()!+1)
for (X, Y) in zip(x, y) {
    mat[Y][X] = 1
}

// Get instructions
x.removeAll()
y.removeAll()
for fold in folds {
    let instructions = fold.split(separator: "=")
    if instructions[0].contains("x") {
        x.append(Int(instructions[1])!)
        y.append(-1)
    } else {
        x.append(-1)
        y.append(Int(instructions[1])!)
    }
}

// Flip y
func flipY(fold: Int, mat: [[Int]]) -> [[Int]] {
    // Initial params
    var idx = 2
    
    // Make the new matrix with previous values
    var mat2 = Array(repeating: Array(repeating: 0, count: mat[0].endIndex), count: fold)
    for row in 0..<mat2.count {
        for col in 0..<mat2[0].endIndex {
            mat2[row][col] = mat[row][col]
        }
    }
    
    // Transform the fold
    for i in (fold+1)..<mat.count { // Loop rows first
        for j in 0..<mat[0].endIndex { // Loop columns
            mat2[i-idx][j] += mat[i][j]
        }
        idx += 2
    }
    
    // Solution
    return mat2
}

// Flip x
func flipX(fold: Int, mat: [[Int]]) -> [[Int]] {
    // Initial params
    var idx = 2
    
    // Make the new matrix with previous values
    var mat2 = Array(repeating: Array(repeating: 0, count: fold), count: mat.count)
    for row in 0..<mat2.count {
        for col in 0..<mat2[0].endIndex {
            mat2[row][col] = mat[row][col]
        }
    }
        
    // Transform the fold
    for i in 0..<mat.count { // Loop rows first
        for j in (fold+1)..<mat[0].endIndex { // Loop columns
            mat2[i][j-idx] += mat[i][j]
            idx += 2
        }
        idx = 2
    }
    
    // Solution
    return mat2
}

// Hard code part 1 for now
mat = flipX(fold: x[0], mat: mat)
var reduced = mat.reduce([], +)
print("Part 1: ", reduced.filter{$0 > 0}.count)


// Guessing this is part 2... Perform the folds
for (X, Y) in zip(x, y) {
    if X == -1 {
        // Fold y
        mat = flipY(fold: Y, mat: mat)
        break
    } else {
        // Fold x
        mat = flipY(fold: X, mat: mat)
        break
    }
}
