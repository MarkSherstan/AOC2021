import Foundation

public class Day17 {
    // Target/input struct
    struct Target {
        let xMin: Int
        let xMax: Int
        let yMin: Int
        let yMax: Int
    }

    // Probe pos and vel struct
    struct Probe {
        var xPos = 0
        var yPos = 0
        var xVel: Int
        var yVel: Int
    }

    var target: Target
    var successArray = [Int]()

    // Load data and run calculation
    public init() {
        let url = Bundle.main.url(forResource: "Day17", withExtension: "txt")!
        let input = try! String(contentsOf: url).split(separator: "\n")
        let areaStringArray = input[0].replacingOccurrences(of: "target area: x=", with: "").replacingOccurrences(of: " y=", with: "").replacingOccurrences(of: "..", with: ",").split(separator: ",")
        let areaArray = areaStringArray.map { Int($0)!}
        
        self.target = Target(xMin: areaArray[0], xMax: areaArray[1], yMin: areaArray[2], yMax: areaArray[3])
        run()
    }

    // Func for moving the probe
    func step(probe: inout Probe) {
        // Update position
        probe.xPos += probe.xVel
        probe.yPos += probe.yVel
        
        // Update x velocity
        if probe.xVel > 0 {
            probe.xVel -= 1
        } else if probe.xVel < 0 {
            probe.xVel += 1
        }
        
        // Update y velocity
        probe.yVel -= 1
    }

    // Sim function
    func sim(xVel: Int, yVel: Int, heightSuccessArray: inout [Int]) {
        // Initial conditions
        var probe = Probe(xVel: xVel, yVel: yVel)
        var highest = Int.min

        while true {
            // Run simulation
            step(probe: &probe)
            
            // Keep track of highest position
            if probe.yPos > highest {
                highest = probe.yPos
            }
            
            // Overshoot exit condition
            if (probe.xVel == 0) && (probe.xPos < target.xMin) || (probe.xVel == 0) && (probe.xPos > target.xMax) {
                return
            }
            
            if probe.yPos < target.yMin {
                return
            }
            
            // Target location exit condition
            if (probe.xPos <= target.xMax) && (probe.xPos >= target.xMin) {
                if (probe.yPos <= target.yMax) && (probe.yPos >= target.yMin) {
                    heightSuccessArray.append(highest)
                    return
                }
            }
        }
    }

    // Run through combinations
    func run() {
        // Intervals
        let X = stride(from: 0, through: target.xMax, by: 1)
        let Y = stride(from: -1000, through: 1000, by: 1)
        
        // Run through combos
        for x in X {
            for y in Y {
                sim(xVel: x, yVel: y, heightSuccessArray: &successArray)
            }
        }
    }
    
    // Part 1
    public func part1() -> String {
        return String(successArray.max()!)
    }

    // Part 2
    public func part2() -> String {
        return String(successArray.count)
    }
}
