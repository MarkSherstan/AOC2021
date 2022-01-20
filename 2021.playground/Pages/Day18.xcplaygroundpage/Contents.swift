import Foundation

let startTime = NSDate()

let day18 = Day18()
day18.part1()
day18.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
