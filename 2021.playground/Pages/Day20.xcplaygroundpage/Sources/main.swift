import Foundation

// Matrix structure
struct Matrix {
    var mat: [[Character]]
    var mat2: [[Character]]!
    var rows: Int!
    var cols: Int!
    
    init(matrix: [[Character]]) {
        self.mat = matrix
        self.rows = matrix.count        // y
        self.cols = matrix[0].endIndex  // x
        self.mat2 = Array(repeating: Array(repeating: Character("."), count: self.cols), count: self.rows)
    }
}

public class Day20 {
    var matrix: Matrix
    var algorithm: [Character]

    // Read in data
    public init() {
        // Import data
        let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
        let input = try! String(contentsOf: url).split(separator: "\n")

        // Split data input and pad
        self.algorithm = Array(String(input[0]))
        var image = [[Character]]()
        let padding = 75
        let horizontalPad = Array(repeating: Character("."), count: padding)
        let verticalPad = Array(repeating: Character("."), count: input[1].count + (2 * padding))

        for _ in 0..<padding {
            image.append(verticalPad)
        }

        for i in 1..<input.count {
            image.append(horizontalPad + Array(input[i]) + horizontalPad)
        }

        for _ in 0..<padding {
            image.append(verticalPad)
        }

        // Configure matrix struct
        self.matrix = Matrix(matrix: image)
    }

    // Enhance function
    func enhance(x: Int, y: Int, loop: Int) {
        // Directions x = cols and y = rows
        let dx = [-1, 0, 1, -1, 0, 1, -1, 0, 1]
        let dy = [-1, -1, -1, 0, 0, 0, 1, 1, 1]
        var bin = ""
        
        // Loop through surrounding elements
        for (dirX, dirY) in zip(dx, dy) {
            let xx = x + dirX
            let yy = y + dirY
            
            if (xx < 0 || xx >= matrix.cols || yy < 0 || yy >= matrix.rows) {
                // Infinite helper
                if loop % 2 == 0 {
                    bin.append("1")
                } else {
                    bin.append("0")
                }
            } else if matrix.mat[yy][xx] == "#" {
                bin.append("1")
            } else {
                bin.append("0")
            }
        }

        // Lookup algorithm enhance value
        let pos = Int(bin, radix: 2)!
        matrix.mat2[y][x] = algorithm[pos]
    }

    // Part 1
    public func part1() {
        // Enhance twice
        for i in 1...2 {
            // Loop through all elements
            for row in 0..<matrix.rows {
                for col in 0..<matrix.cols {
                    enhance(x: col, y: row, loop: i)
                }
            }

            // Update matrix
            matrix.mat = matrix.mat2
        }

        // Solution
        let flattened = matrix.mat.flatMap { $0 }
        print("Part 1: ", flattened.filter{$0 == "#"}.count)
    }

    // Part 2
    public func part2() {
        print("Part 2: ", 000)
    }
}
