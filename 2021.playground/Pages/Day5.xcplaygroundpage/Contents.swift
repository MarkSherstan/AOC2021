import Foundation

let startTime = NSDate()

let day5 = Day5()
day5.part1()
day5.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
