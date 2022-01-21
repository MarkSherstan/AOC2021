import Foundation

// Matrix structure
struct Matrix {
    var mat: [[Character]]
    var mat2: [[Character]]!
    var rows: Int!
    var cols: Int!
    
    init(matrix: [[Character]]) {
        self.mat = matrix
        self.rows = matrix.count
        self.cols = matrix[0].endIndex
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
        let horizontalPad = Array(repeating: Character("."), count: 25)
        let verticalPad = Array(repeating: Character("."), count: input[1].count + 50)

        for _ in 0..<10 {
            image.append(verticalPad)
        }

        for i in 1..<input.count {
            let val = horizontalPad + Array(input[i]) + horizontalPad
            image.append(val)
        }

        for _ in 0..<10 {
            image.append(verticalPad)
        }

        // Configure matrix struct
        self.matrix = Matrix(matrix: image)
    }

    // Enhance function
    func enhance(x: Int, y: Int) {
        // Directions (is this backwards?)
        let dx = [-1, -1, -1, 0, 0, 0, 1, 1, 1]
        let dy = [-1, 0, 1, -1, 0, 1, -1, 0, 1]
        var bin = ""
        
        // Loop through surrounding elements
        for (dirX, dirY) in zip(dx, dy) {
            let xx = x + dirX
            let yy = y + dirY
            
            if (xx < 0 || xx == matrix.rows) || (yy < 0 || yy == matrix.cols) {
                bin.append("0")
            } else if matrix.mat[xx][yy] == "#" {
                bin.append("1")
            } else {
                bin.append("0")
            }
        }

        // Lookup algorithm enhance value
        let pos = Int(bin, radix: 2)!
        matrix.mat2[x][y] = algorithm[pos]
    }

    // Part 1
    public func part1() {
        // Enahnce twice
        for _ in 1...2 {
            // Loop through all elements
            for i in 0..<matrix.rows {
                for j in 0..<matrix.cols {
                    enhance(x: i, y: j)
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
