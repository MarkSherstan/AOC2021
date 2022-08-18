import Foundation

public class Day11 {
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
    
    var matrix: Matrix
    var matrix0: Matrix
    var counter = 0
    
    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "Day11", withExtension: "txt")!
        let input = try! String(contentsOf: url).split(separator: "\n")
        
        var mat = [[Int]]()
        for row in input {
            mat.append(row.compactMap{$0.wholeNumberValue})
        }

        self.matrix = Matrix(matrix: mat)
        self.matrix0 = Matrix(matrix: mat)
    }

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
    
    // Main logic
    func run(isPart1: Bool) -> Int {
        // Ensure simulation is zeroed
        matrix = matrix0
        counter = 0
        
        // Main simulation
        var step = 1
        while(true) {
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
            
            // Exit conditions
            if (step == 100) && (isPart1) {
                return counter;
            } else if Set(matrix.matrix.reduce([], +)).count == 1 {
                return step;
            }
            
            // Increment step count
            step += 1
        }
    }
    
    // Part 1
    public func part1() -> String {
        return String(run(isPart1: true))
    }

    // Part 2
    public func part2() -> String {
        return String(run(isPart1: false))
    }
}
