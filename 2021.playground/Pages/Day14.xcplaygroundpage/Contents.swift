import Foundation

let startTime = NSDate()

let day14 = Day14()
day14.part1()
//day14.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
