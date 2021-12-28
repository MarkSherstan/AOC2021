import Foundation

let startTime = NSDate()

let day9 = Day9()
day9.part1()
day9.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
