//
//  ContentView.swift
//  Day22
//
//  Created by Mark Sherstan on 2022-08-01.
//

import SwiftUI

struct ContentView: View {
    var d22 = Day22()
    @State var part1Result: String = ""
    @State var part2Result: String = ""
    @State var timeResult: String = "Time Elapsed [s]: "
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 20) {
                HStack(spacing: 50) {
                    VStack(spacing: 20) {
                        Button(action: {
                            let result = self.d22.updatePart1()
                            part1Result = String(result.sol)
                            timeResult = "Time Elapsed [s]: " + String(format: "%.3f", result.time)
                        }) {
                            Text("Part 1")
                        }
                        Text(part1Result)
                    }
                    
                    VStack(spacing: 20) {
                        Button(action: {
                            let result = self.d22.updatePart2()
                            part2Result = String(result.sol)
                            timeResult = "Time Elapsed [s]: " + String(format: "%.3f", result.time)
                        }) {
                            Text("Part 2")
                        }
                        Text(part2Result)
                    }
                }
                Text(timeResult)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().frame(width: 200, height: 200)
    }
}
