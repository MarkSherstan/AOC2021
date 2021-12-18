import Cocoa

// Import data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let text = try String(contentsOf: url).split(separator: "\n")

// Extract the data
let testArray = String(text[0]).components(separatedBy: ",").map{Int($0)!}
let bingoCards = (text.count-1) / 5
var counter = 1

var input = [[[Int]]]()

for i in 0..<bingoCards {
    input.append([[Int]]())
    
    for j in 0..<5{
        input[i].append([Int]())
        let temp = String(text[counter]).components(separatedBy: " ").filter{$0 != ""}.map{Int($0)!}
        input[i][j].append(contentsOf: temp)
        counter += 1
    }
}

// Structure to save the data
struct Matrix {
    var matrix: [[[Int]]]
    var mats: Int?
    var rows: Int?
    var cols: Int?
    var boolMatrix: [[[Int]]]?

    init(matrix: [[[Int]]]) {
        self.matrix = matrix
        self.mats = matrix.count
        self.rows = matrix[0].count
        self.cols = matrix[0][0].endIndex
        self.boolMatrix = matrix

        for i in 0..<self.mats! {
            for j in 0..<self.rows! {
                for k in 0..<self.cols! {
                    self.boolMatrix![i][j][k] = 0
                }
            }
        }
    }
}

// Check if a value was found
func checkValue(mat: Matrix, check: Int) -> [[[Int]]] {
    var temp = mat.boolMatrix!

    for i in 0..<mat.mats! {
        for j in 0..<mat.rows! {
            for k in 0..<mat.cols! {
                if mat.matrix[i][j][k] == check {
                    temp[i][j][k] = 1
                }
            }
        }
    }
    return temp
}

// See if there is a bingo
func bingo(mat: Matrix) -> Int {
    var sum = 0

    // Check rows
    for i in 0..<mat.mats! {
        for j in 0..<mat.rows! {
            for k in 0..<mat.cols! {
                sum += mat.boolMatrix![i][j][k]
            }
            if sum == mat.rows! {
                return i
            } else {
                sum = 0
            }
        }
    }

    // Check columns
    for i in 0..<mat.mats! {
        for j in 0..<mat.cols! {
            for k in 0..<mat.rows! {
                sum += mat.boolMatrix![i][k][j]
            }
            if sum == mat.cols! {
                return i
            } else {
                sum = 0
            }
        }
    }

    return -1
}

// Calculate score
func score(mat: Matrix, matNum: Int, callNum: Int) -> Int {
    var sum = 0

    for j in 0..<mat.rows! {
        for k in 0..<mat.cols! {
            if mat.boolMatrix![matNum][j][k] == 0 {
                sum += mat.matrix[matNum][j][k]
            }
        }
    }

    return sum * callNum
}

// Calculation
var matrix = Matrix(matrix: input)
var finalVal: Int?
var finalMatrix: Int?

// Loop through test array
for i in 0..<testArray.count {
    matrix.boolMatrix = checkValue(mat: matrix, check: testArray[i])
    finalMatrix = bingo(mat: matrix)
    
    if finalMatrix != -1 {
        finalVal = testArray[i]
        break
    }
}

// Print results
print("Part 1: ", score(mat: matrix, matNum: finalMatrix!, callNum: finalVal!))
