import Foundation

let startTime = NSDate()

let day13 = Day13()
day13.part1()
day13.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
