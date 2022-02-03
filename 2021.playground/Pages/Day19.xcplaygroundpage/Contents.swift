import Foundation

let startTime = NSDate()

let day19 = Day19()
day19.part1()
day19.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
