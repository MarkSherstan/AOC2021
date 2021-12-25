import Foundation

// Import data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let input = try String(contentsOf: url).split(separator: "\n")

// Format data
var mat = [[Int]]()
for row in input {
    mat.append(row.compactMap{$0.wholeNumberValue})
}

struct Matrix {
    var matrix: [[Int]]
    var rows: Int?
    var cols: Int?

    init(matrix: [[Int]]) {
        self.matrix = matrix
        self.rows = matrix.count
        self.cols = matrix[0].endIndex
    }
}

var matrix = Matrix(matrix: mat)

// See if the input coords are a min
func check(rowIdx: Int, colIdx: Int, matrix: Matrix) -> Int {
    // Values to check
    let val = matrix.matrix[rowIdx][colIdx]
    var compare = [val]
     
    let vertical = [[rowIdx - 1, rowIdx + 1], [rowIdx, rowIdx], [rowIdx - 1, rowIdx + 1]]
    let horizontal = [[colIdx, colIdx], [colIdx - 1, colIdx + 1], [colIdx - 1, colIdx + 1]]
    
    // Run through the combos
    for i in 0..<2 {
        let up = vertical[i][0]
        let down = vertical[i][1]
        let left = horizontal[i][0]
        let right = horizontal[i][1]
        
        // Top left
        if (up >= 0 ) && (left >= 0) {
            // Double Pass
            compare.append(matrix.matrix[up][left])
        }
        
//        else if (up >= 0 ) && (left < 0) {
//            // Up pass - Left Fail
//            compare.append(matrix.matrix[up][0])
//        } else if (up < 0 ) && (left >= 0) {
//            // Up Fail - Left Pass
//            compare.append(matrix.matrix[0][left])
//        } else {
//            // Double Fail
//        }
                
        // Top right
        if (up >= 0 ) && (right <= matrix.cols! - 1) {
            // Double Pass
            compare.append(matrix.matrix[up][right])
        }
        
//        else if (up >= 0 ) && (right >= matrix.cols!) {
//            // Up pass - Right Fail
//            compare.append(matrix.matrix[up][matrix.cols! - 1])
//        } else if (up < 0 ) && (right <= matrix.cols! - 1) {
//            // Up Fail - Right Pass
//            compare.append(matrix.matrix[0][right])
//        } else {
//            // Double Fail
//        }
        
        // Bottom left
        if (down <= matrix.rows! - 1) && (left >= 0) {
            // Double Pass
            compare.append(matrix.matrix[down][left])
        }
        
//        else if (down <= matrix.rows! - 1) && (left < 0) {
//            // Down pass - Left Fail
//            compare.append(matrix.matrix[down][0])
//        } else if (down >= matrix.rows!) && (left >= 0) {
//            // Down Fail - Left Pass
//            compare.append(matrix.matrix[matrix.rows! - 1][left])
//        } else {
//            // Double Fail
//        }
        
        // Bottom right
        if (down <= matrix.rows! - 1) && (right <= matrix.cols! - 1) {
            // Double Pass
            compare.append(matrix.matrix[down][right])
        }
        
//        else if (down <= matrix.rows! - 1) && (right >= matrix.cols!) {
//            // Down pass - Right Fail
//            compare.append(matrix.matrix[down][matrix.cols! - 1])
//        } else if (down >= matrix.rows!) && (right <= matrix.cols! - 1) {
//            // Down Fail - Right Pass
//            compare.append(matrix.matrix[matrix.rows! - 1][right])
//        } else {
//            // Double Fail
//        }
    }

    // Return risk level
    if compare.min()! == val {
        if compare.filter({$0 == val}).count == 1 {
            return val + 1
        } else {
            return 0
        }
    } else {
        return 0
    }
}

// Run the calc
var total = 0
for row in 0..<matrix.rows! {
    for col in 0..<matrix.cols! {
        total += check(rowIdx: row, colIdx: col, matrix: matrix)
    }
}

print("Part 1: ", total)
