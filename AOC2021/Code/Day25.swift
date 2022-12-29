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
    }
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
    
    /// Part 1
    func part1() -> String {
        return "A"
    }
    
    /// Part 2
    func part2() -> String {
        return "B"
    }
}
