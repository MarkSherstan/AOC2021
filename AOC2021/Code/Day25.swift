//
//  Day25.swift
//  AOC2021
//
//  Created by Mark Sherstan on 2022-12-28.
//

import Foundation

class Day25 {
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
        
        mutating func update() {
            mat = mat2
            mat2 = Array(repeating: Array(repeating: Character("."), count: self.cols), count: self.rows)
        }
    }
    
    // Vars
    var matrix: Matrix
    
    // Read in data
    init() {
        let url = Bundle.main.url(forResource: "Day25", withExtension: "txt")!
        let input = try! String(contentsOf: url).split(separator: "\n")

        var temp: [[Character]] = []
        for row in input {
            temp.append(Array(row))
        }
       
        matrix = Matrix(matrix: temp)
    }
    
    func moveHorizontal(matrix: inout Matrix) {
        for row in 0..<matrix.rows {
            for col in 0..<matrix.cols {
                if matrix.mat[row][col] == "." {
                    continue
                }
                
                if (col + 1) < matrix.cols {
                    if matrix.mat[row][col] == ">" && matrix.mat[row][col + 1] == "." {
                        matrix.mat2[row][col + 1] = ">"
                    } else {
                        matrix.mat2[row][col] = ">"
                    }
                } else {
                    if matrix.mat[row][col] == ">" && matrix.mat[row][0] == "." {
                        matrix.mat2[row][0] = ">"
                    } else {
                        matrix.mat2[row][col] = ">"
                    }
                }
            }
        }
    }
    
    func moveVertical(matrix: inout Matrix) {
        for row in 0..<matrix.rows {
            for col in 0..<matrix.cols {
                if matrix.mat[row][col] == "." {
                    continue
                }
                
                if (row + 1) < matrix.rows {
                    if matrix.mat[row][col] == "v" && matrix.mat[row + 1][col] == "." {
                        matrix.mat2[row + 1][col] = "v"
                    } else {
                        matrix.mat2[row][col] = "v"
                    }
                } else {
                    if matrix.mat[row][col] == "v" && matrix.mat[0][col] == "." {
                        matrix.mat2[0][col] = "v"
                    } else {
                        matrix.mat2[row][col] = "v"
                    }
                }
            }
        }
    }
    
    func solve() {
        var i = 0
        while true {
            moveHorizontal(matrix: &matrix)
            moveVertical(matrix: &matrix)
            
            i += 1
            
            if matrix.mat == matrix.mat2 {
                break
            }
            
            matrix.update()
            print(i)
        }
    }
    
    /// Part 1
    func part1() -> String {
        solve()
        return "A"
    }
    
    /// Part 2
    func part2() -> String {
        return "B"
    }
}
