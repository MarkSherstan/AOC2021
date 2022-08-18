import Foundation

public class Day5 {
    // Structure for storing coordinates
    struct Coords {
        let num: Int
        var x1 = [Int]()
        var y1 = [Int]()
        var x2 = [Int]()
        var y2 = [Int]()
    }
    
    var coords: Coords
    
    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "Day5", withExtension: "txt")!
        let text = try! String(contentsOf: url).split(separator: "\n")
        
        self.coords = Coords(num: text.count)
        
        for line in text {
            let A = String(line)
            let B = A.components(separatedBy: " -> ")
            let C = B[0].components(separatedBy: ",").map{Int($0)!}
            let D = B[1].components(separatedBy: ",").map{Int($0)!}
            
            self.coords.x1.append(C[0])
            self.coords.y1.append(C[1])
            self.coords.x2.append(D[0])
            self.coords.y2.append(D[1])
        }
    }
    
    // Main logic
    func run(isPart2: Bool) -> Int {
        // Create max grid
        let xMax = max(coords.x1.max()!, coords.x2.max()!) + 1
        let yMax = max(coords.y1.max()!, coords.y2.max()!) + 1
        var grid = Array(repeating: Array(repeating: 0, count: xMax), count: yMax)
        
        // Loop through grid and populate coords
        for i in 0..<coords.num {
            // Coords
            let x1 = coords.x1[i]
            let y1 = coords.y1[i]
            let x2 = coords.x2[i]
            let y2 = coords.y2[i]
            
            // Set up paths
            var rows: StrideThrough<Int>
            var cols: StrideThrough<Int>
            
            if x1 < x2 {
                cols = stride(from: x1, through: x2, by: 1)
            } else {
                cols = stride(from: x1, through: x2, by: -1)
            }
            
            if y1 < y2 {
                rows = stride(from: y1, through: y2, by: 1)
            } else {
                rows = stride(from: y1, through: y2, by: -1)
            }
            
            // Part 1 and 2: Straight lines
            if (x1 == x2) || (y1 == y2) {
                for row in rows {
                    for col in cols {
                        grid[row][col] += 1
                    }
                }
            } else if isPart2 {
                // Part 2: Diagonal included
                for (row, col) in zip(rows, cols) {
                    grid[row][col] += 1
                }
            }
        }
        
        // Get overlap results
        var overlap = 0;
        for i in 0..<grid.count {
            overlap += grid[i].filter{$0 >= 2}.count
        }
        
        return overlap
    }
    
    
    // Part 1
    public func part1() -> String {
        return String(run(isPart2: false))
    }
    
    // Part 2
    public func part2() -> String {
        return String(run(isPart2: true))
    }
}
