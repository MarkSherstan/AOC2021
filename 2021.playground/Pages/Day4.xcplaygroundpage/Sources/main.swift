import Foundation

// Matrix structure with quick reference data
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

public class Day4 {
    var matrix: Matrix
    var bingoNumbers: [Int]
    var scoreArray: [Int]
    var winOrderArray: [Int]
    
    // Import and extract the data -> then run the main program
    public init() {
        let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
        let text = try! String(contentsOf: url).split(separator: "\n")

        self.bingoNumbers = String(text[0]).components(separatedBy: ",").map{Int($0)!}
        let bingoCards = (text.count-1) / 5
        var mat = [[[Int]]]()
        var counter = 1
        
        for i in 0..<bingoCards {
            mat.append([[Int]]())
            
            for j in 0..<5 {
                mat[i].append([Int]())
                let temp = String(text[counter]).components(separatedBy: " ").filter{$0 != ""}.map{Int($0)!}
                mat[i][j].append(contentsOf: temp)
                counter += 1
            }
        }

        self.matrix = Matrix(matrix: mat)
        
        // Run the program
        self.scoreArray = [Int](repeating: 0, count: matrix.mats!)
        self.winOrderArray = [Int]()
        run()
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
    func bingo(mat: Matrix) -> [Int] {
        var sum = 0
        var bingos = [Int]()
        
        // Check rows
        for i in 0..<mat.mats! {
            for j in 0..<mat.rows! {
                for k in 0..<mat.cols! {
                    sum += mat.boolMatrix![i][j][k]
                }
                if sum == mat.rows! {
                    bingos.append(i)
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
                    bingos.append(i)
                } else {
                    sum = 0
                }
            }
        }

        return bingos
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
    
    // Generate an array of all the scores and the order they won
    func run() {
        for i in 0..<bingoNumbers.count {
            matrix.boolMatrix = checkValue(mat: matrix, check: bingoNumbers[i])
            let bingoCardsWon = bingo(mat: matrix)
                
            for j in 0..<bingoCardsWon.count {
                if scoreArray[bingoCardsWon[j]] == 0 {
                    scoreArray[bingoCardsWon[j]] = score(mat: matrix, matNum: bingoCardsWon[j], callNum: bingoNumbers[i])
                    winOrderArray.append(bingoCardsWon[j])
                }
            }
            
            if scoreArray.contains(0) == false {
                break
            }
        }
    }

    // Part 1
    public func part1() {
        print("Part 1: ", scoreArray[winOrderArray.first!])
    }
        
    // Part 2
    public func part2() {
        print("Part 2: ", scoreArray[winOrderArray.last!])
    }
}
