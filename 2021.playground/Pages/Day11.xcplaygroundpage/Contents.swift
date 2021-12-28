import Foundation

// Matrix structure with quick functions and reference data
struct Matrix {
    var matrix: [[Int]]
    var rows: Int?
    var cols: Int?
    var boolMatrix: [[Int]]?
    
    init(matrix: [[Int]]) {
        self.matrix = matrix
        self.rows = matrix.count
        self.cols = matrix[0].endIndex
        self.boolMatrix = Array(repeating: Array(repeating: 0, count: self.cols!), count: self.rows!)
    }
        
    mutating func resetBoolMatrix() {
        self.boolMatrix = Array(repeating: Array(repeating: 0, count: self.cols!), count: self.rows!)
    }
}

// Import data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let input = try String(contentsOf: url).split(separator: "\n")

var mat = [[Int]]()
for row in input {
    mat.append(row.compactMap{$0.wholeNumberValue})
}

// Global variables
var matrix = Matrix(matrix: mat)
var counter = 0

// Flash function
func flash(x: Int, y: Int) {
    // Out of bounds
    if (x < 0 || x == matrix.rows!) {return}
    if (y < 0 || y == matrix.cols!) {return}
  
    // Increment
    matrix.matrix[x][y] += 1
    
    // Can flash and already flashed checks
    if (matrix.boolMatrix![x][y] == 1) {return}
    if (matrix.matrix[x][y] < 10) {return}
    
    // Mark the current cell as flashed and increment counter
    matrix.boolMatrix![x][y] = 1;
    counter += 1

    // Directions
    let dx = [1, 0, -1, 0, 1, -1, 1, -1]
    let dy = [0, 1, 0, -1, 1, -1, -1, 1]
    
    // Recursively increment and check the neighbors
    for (dirX, dirY) in zip(dx, dy) {
        flash(x: x+dirX, y: y+dirY)
    }
}

// Main simulation
for _ in 0..<100 {
    // Perform the flashes
    for row in 0..<matrix.rows! {
        for col in 0..<matrix.cols! {
           flash(x: row, y: col)
        }
    }
    
    // All flashed octopus go to zero
    for row in 0..<matrix.rows! {
        for col in 0..<matrix.cols! {
            if matrix.boolMatrix![row][col] == 1 {
                matrix.matrix[row][col] = 0
            }
        }
    }
    matrix.resetBoolMatrix()
}

print("Part 1: ", counter)
