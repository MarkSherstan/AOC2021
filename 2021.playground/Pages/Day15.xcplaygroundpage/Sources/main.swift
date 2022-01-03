import Foundation

// Matrix structure with reference data
struct Matrix {
    var matrix: [[Int]]
    var rows: Int!
    var cols: Int!
    var dis: [[Int]]!
    
    init(matrix: [[Int]]) {
        self.matrix = matrix
        self.rows = matrix.count
        self.cols = matrix[0].endIndex
        self.dis = Array(repeating: Array(repeating: Int.max, count: self.cols!), count: self.rows!)
    }
}

// Hold cell data -> posible protocols: Hashable, Equatable
struct Cell {
    var x: Int
    var y: Int
    var distance: Int
}

// Main logic
public class Day15 {
    var matrix: Matrix
    
    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
        let input = try! String(contentsOf: url).split(separator: "\n")
        
        var mat = [[Int]]()
        for row in input {
            mat.append(row.compactMap{$0.wholeNumberValue})
        }
        
        self.matrix = Matrix(matrix: mat)
    }
    
    // Dijkstra algorithm
    func djk(matrix: inout Matrix) -> Int {
        // Directions to check
        let dx = [1, 0, -1, 0]
        let dy = [0, 1, 0, -1]
        
        // Cell array structure
        var st = [Cell]()
        st.append(Cell(x: 0, y: 0, distance: 0))
        
        // First cell is not entered, set to zero
        matrix.dis![0][0] = 0
        
        while !st.isEmpty {
            // Get cell with min distance and then delete it from array (always first entry)
            let k = st.removeFirst()
            
            // Loop through neighbours
            for (xx, yy) in zip(dx, dy) {
                let x = k.x + xx;
                let y = k.y + yy;
                
                // Check boundaries
                if (x < 0 || x >= matrix.rows!) {continue}
                if (y < 0 || y >= matrix.cols!) {continue}
                
                // If distance from current cell is smaller, then update distance of neighbour cell
                if (matrix.dis[x][y] > matrix.dis[k.x][k.y] + matrix.matrix[x][y]) {
                    
                    // Update distance and insert updated cell in array
                    matrix.dis[x][y] = matrix.dis[k.x][k.y] + matrix.matrix[x][y];
                    st.append(Cell(x: x, y: y, distance: matrix.dis[x][y]));
                }
            }
            
            // Sort the array of structs
            st.sort { (a: Cell, b: Cell) -> Bool in
                if a.distance == b.distance {
                    if a.x != b.x {
                        return a.x < b.x
                    } else {
                        return a.y < b.y
                    }
                }
                return a.distance < b.distance
            }
        }
        
        // Solution
        return matrix.dis[matrix.rows - 1][matrix.cols - 1]
    }
        
    // Part 1
    public func part1() {
        print("Part 1: ", djk(matrix: &matrix))
    }
    
    // Part 2
    public func part2() {
        print("Part 2: ", 000)
    }
}
