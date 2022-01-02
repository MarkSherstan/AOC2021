import Foundation

// Matrix structure with reference data
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
    
    func minCost(matrix: Matrix, row: Int, col: Int) -> Int {
        var dp = Array(repeating: Array(repeating: 0, count: matrix.cols!), count: matrix.rows!)
        
        for i in 1...row {
            dp[i][0] = dp[i-1][0] + matrix.matrix[i][0]
        }
                
        for j in 1...col {
            dp[0][j] = dp[0][j-1] + matrix.matrix[0][j]
        }
                
        for i in 1...row {
            for j in 1...col {
                dp[i][j] = min(dp[i-1][j], dp[i][j-1]) + matrix.matrix[i][j]
            }
        }
                
        return dp[row][col]
    }

    // That's not the right answer; your answer is too high. If you're stuck, make sure you're using the full input data; there are also some general tips on the about page, or you can ask for hints on the subreddit. Please wait one minute before trying again. (You guessed 402.) [Return to Day 15]
                    
    // Part 1
    public func part1() {
        print("Part 1: ", minCost(matrix: matrix, row: matrix.rows!-1, col: matrix.cols!-1))
    }

    // Part 2
    public func part2() {
        print("Part 2: ", 000)
    }
}
