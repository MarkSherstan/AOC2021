//
//  ContentView.swift
//  Day22
//
//  Created by Mark Sherstan on 2022-08-01.
//

import SwiftUI

struct ContentView: View {
    var p1 = Part1()
    @State var test1Result: String = "Part 1: "
    @State var test2Result: String = "Part 2: "
    @State var timeResult: String = "Time Elapsed: "
    
    var body: some View {
        
        VStack(spacing: 50) {
            HStack(spacing: 50) {
                VStack(spacing: 20) {
                    Button(action: {
                        let result = self.p1.updateTest1()
                        test1Result = "Part 1: " + String(result.sol)
                        timeResult = "Time Elapsed: " + String(result.time)
                    }) {
                        Text("P1 Test")
                    }
                    
                    Button(action: {
                    }) {
                        Text("Part 1")
                    }
                }
                
                VStack(spacing: 20) {
                    Button(action: {
                        test2Result = "Part 2: " + String(self.p1.updateTest2())
                    }) {
                        Text("P2 Test")
                    }
                    
                    Button(action: {
                    }) {
                        Text("Part 2")
                    }
                }
            }
            
            VStack(alignment: .leading){
                Text(test1Result)
                Text(test2Result)
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
