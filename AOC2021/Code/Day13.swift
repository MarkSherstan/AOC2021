import Foundation

public class Day13 {
    var mat: [[Int]]
    var folds: ArraySlice<Substring>

    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "Day13", withExtension: "txt")!
        let input = try! String(contentsOf: url).split(separator: "\n", omittingEmptySubsequences: false).split(separator: "")
        let coords = input[0]
        self.folds = input[1]

        // Build out matrix
        var x = [Int]()
        var y = [Int]()

        for coord in coords {
            let point = coord.split(separator: ",")
            x.append(Int(point[0])!)
            y.append(Int(point[1])!)
        }

        self.mat = Array(repeating: Array(repeating: 0, count: x.max()!+1), count: y.max()!+1)
        for (X, Y) in zip(x, y) {
            self.mat[Y][X] = 1
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

    // Main logic
    func run(mat: [[Int]], isPart1: Bool) -> [[Int]] {
        // Local variable
        var localMat = mat
        
        // Loop through fold instructions
        for fold in folds {
            let instructions = fold.split(separator: "=")
            if instructions[0].contains("x") {
                localMat = flipX(fold: Int(instructions[1])!, mat: localMat)

                if isPart1 {
                    return localMat
                }
            } else if instructions[0].contains("y") {
                localMat = flipY(fold: Int(instructions[1])!, mat: localMat)

                if isPart1 {
                    return localMat
                }
            }
        }

        return localMat
    }

    // Part 1
    public func part1() -> String {
        let firstFold = run(mat: mat, isPart1: true)
        let reduced = firstFold.reduce([], +)
        
        return String(reduced.filter{$0 > 0}.count)
    }

    // Part 2
    public func part2() -> String {
        let fold = run(mat: mat, isPart1: false)
        
        // Build result
        var sol = ""
        for row in fold {
            for c in row {
                if c > 0 {
                    sol += "#"
                } else {
                    sol += " "
                }
            }
            sol += "\n"
        }
        
        return sol
    }
}
