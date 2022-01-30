import Foundation

//  1               2               3
//  1   2   3       1   2   3       1   2   3
//  123 123 123     123 123 123     123 123 123

var rollSum2universeCount: [Int: Int] = [:]
var master: [String: [Int]] = [:]   // [pos1 score1 pos2 score2 #uni]
var result = [0, 0]

for i in 1...3 {
    for j in 1...3 {
        for k in 1...3 {
            let key = i + j + k
            if rollSum2universeCount[key] == nil {
                rollSum2universeCount[key] = 1
            } else {
                rollSum2universeCount[key]! += 1
            }
        }
    }
}

print(rollSum2universeCount)


func play(P1: Bool, master: inout [String: [Int]], result: inout [Int]) {
    var tempPos = 0
    var tempScore = 0
    
    for (key, value) in master {
        // Get a position and score of interest
        if P1 {
            tempPos = value[0]
            tempScore = value[1]
        } else {
            tempPos = value[2]
            tempScore = value[3]
        }
        
        // Go through all dice combinations
        for (rollValue, uniCount) in rollSum2universeCount {
            // Move on the board
            if (tempPos + rollValue) % 10 == 0 {
                tempPos = 10
            } else {
                tempPos = (tempPos + rollValue) % 10
            }
        
            // Update score
            tempScore += tempPos
            
            // Do we have a winner?
            if tempScore > 20 {
                if P1 {
                    result[0] += uniCount + value[4]
                    master.removeValue(forKey: key)
                    continue
                } else {
                    result[1] += uniCount + value[4]
                    master.removeValue(forKey: key)
                    continue
                }
            }
            
            // Build key for dictionary
            var masterKey = ""
            if P1 {
                masterKey = String(tempPos) + "|" + String(tempScore) + "|" + String(value[2]) + "|" + String(value[3])
            } else {
                masterKey = String(value[0]) + "|" + String(value[1]) + "|" + String(tempPos) + "|" + String(tempScore)
            }
            
            // Update dictionary
            if master[masterKey] == nil {
                if P1 {
                    master[masterKey] = [tempPos, tempScore, value[2], value[3], uniCount]
                } else {
                    master[masterKey] = [value[0], value[1], tempPos, tempScore, uniCount]
                }
            } else {
                if P1 {
                    master[masterKey]! = [tempPos, tempScore, value[2], value[3], uniCount + value[4]]
                } else {
                    master[masterKey]! = [value[0], value[1], tempPos, tempScore, uniCount + value[4]]
                }
            }
        }
    }
}


// Initial positions
master["4|0|8|0"] = [4, 0, 8, 0, 1]

while !master.isEmpty {
    play(P1: true, master: &master, result: &result)
    play(P1: false, master: &master, result: &result)
    
    print(result, master.count)
}

print("Done")



//var pos = 1
//for (key, value) in rollSum2universeCount {
//
//    if (pos + key) % 10 == 0 {
//        pos = 10
//    } else {
//        pos = (pos + key) % 10
//    }
//
//    let score = pos
//
//    print("Roll:", key, " Pos:", pos, " Score:", score, " universe:", value)
//
//}

let startTime = NSDate()

let day21 = Day21()
day21.part1()
day21.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
