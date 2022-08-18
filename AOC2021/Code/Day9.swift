import Foundation

public class Day9 {
    // Matrix structure with quick reference data
    struct Matrix {
        var matrix: [[Int]]
        var rows: Int?
        var cols: Int?
        var boolMatrix: [[Int]]?
        var labelMatrix: [[Int]]?
        
        init(matrix: [[Int]]) {
            self.matrix = matrix
            self.rows = matrix.count
            self.cols = matrix[0].endIndex
            self.boolMatrix = matrix
            self.labelMatrix = matrix
            
            for i in 0..<self.rows! {
                for j in 0..<self.cols! {
                    self.labelMatrix![i][j] = 0
                    
                    if self.matrix[i][j] == 9 {
                        self.boolMatrix![i][j] = 0
                    } else {
                        self.boolMatrix![i][j] = 1
                    }
                }
            }
        }
    }
    
    var matrix: Matrix
    
    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "Day9", withExtension: "txt")!
        let input = try! String(contentsOf: url).split(separator: "\n")
        
        var mat = [[Int]]()
        for row in input {
            mat.append(row.compactMap{$0.wholeNumberValue})
        }
        
        self.matrix = Matrix(matrix: mat)
    }
    
    // Depth First Search
    func DFS(x: Int, y: Int, currentLabel: Int) {
        // Directions
        let dx = [1, 0, -1, 0]
        let dy = [0, 1, 0, -1]

        // Out of bounds
        if (x < 0 || x == matrix.rows!) {return}
        if (y < 0 || y == matrix.cols!) {return}
      
        // Already labeled or not a 1
        if ((matrix.labelMatrix![x][y] > 0) || (matrix.boolMatrix![x][y] != 1)) {return};

        // Mark the current cell
        matrix.labelMatrix![x][y] = currentLabel;

        // Recursively mark the neighbors
        for (dirX, dirY) in zip(dx, dy) {
            DFS(x: x+dirX, y: y+dirY, currentLabel: currentLabel)
        }
    }
    
    // Label all connected regions and return a dictionary of unique IDs and the area
    func getAreaDictionary() -> [Int: Int] {
        var count = 0
        for row in 0..<matrix.rows! {
            for col in 0..<matrix.cols! {
                if ((matrix.labelMatrix![row][col] == 0) || (matrix.boolMatrix![row][col] == 1)) {
                    count += 1
                    DFS(x: row, y: col, currentLabel: count)
                }
            }
        }
        
        // Create dictionary containing number of occurances for each region
        let reduced = matrix.labelMatrix!.reduce([], +)
        var areaDictionary: [Int: Int] = [:]
        reduced.forEach { areaDictionary[$0, default: 0] += 1 }
        
        return areaDictionary
    }

    // See if the input coords are a min compared to surroundings
    func check(rowIdx: Int, colIdx: Int, matrix: Matrix) -> Bool {
        // Values to check
        let val = matrix.matrix[rowIdx][colIdx]
        var compare = [val]
        
        let vertical = [[rowIdx - 1, rowIdx + 1], [rowIdx, rowIdx]]
        let horizontal = [[colIdx, colIdx], [colIdx - 1, colIdx + 1]]
        
        // Run through the combos
        for i in 0..<2 {
            let up = vertical[i][0]
            let down = vertical[i][1]
            let left = horizontal[i][0]
            let right = horizontal[i][1]
            
            // Top left
            if (up >= 0 ) && (left >= 0) {
                compare.append(matrix.matrix[up][left])
            }
            
            // Top right
            if (up >= 0 ) && (right <= matrix.cols! - 1) {
                compare.append(matrix.matrix[up][right])
            }
            
            // Bottom left
            if (down <= matrix.rows! - 1) && (left >= 0) {
                compare.append(matrix.matrix[down][left])
            }
            
            // Bottom right
            if (down <= matrix.rows! - 1) && (right <= matrix.cols! - 1) {
                compare.append(matrix.matrix[down][right])
            }
        }
        
        // Logic return
        if compare.min()! == val {
            if compare.filter({$0 == val}).count == 1 {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    // Part 1
    public func part1() -> String {
        var riskLevel = 0
        
        for row in 0..<matrix.rows! {
            for col in 0..<matrix.cols! {
                if check(rowIdx: row, colIdx: col, matrix: matrix) {
                    riskLevel += (matrix.matrix[row][col] + 1)
                }
            }
        }
        
        return String(riskLevel)
    }
    
    // Part 2
    public func part2() -> String {
        let areaDictionary = getAreaDictionary()
        var sizeArray = [Int]()
        
        for row in 0..<matrix.rows! {
            for col in 0..<matrix.cols! {
                if check(rowIdx: row, colIdx: col, matrix: matrix) {
                    let temp = matrix.labelMatrix![row][col]
                    sizeArray.append(areaDictionary[temp]!)
                }
            }
        }
        
        sizeArray.sort(by: >)
        
        return String(sizeArray[0] * sizeArray[1] * sizeArray[2])
    }
}
