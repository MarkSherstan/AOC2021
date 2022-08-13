//
//  ContentView.swift
//  AOC2021
//
//  Created by Mark Sherstan on 2022-08-11.
//

import SwiftUI

struct ContentView: View {
    var idx = Index()
    @State private var selection = ""
    @State private var p1Result: String = ""
    @State private var p2Result: String = ""
    @State private var solveTime: String = ""
    
    var body: some View {
        
        VStack (alignment: .leading) {
            Text("Advent of Code 2021").font(.largeTitle)
            
            HStack {
                VStack {
                    Picker("Select day:", selection: $selection) {
                        ForEach(idx.days, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                VStack (alignment: .leading) {
                    Text("Part 1:")
                    TextField("", text: $p1Result)
                    
                    Spacer()
                    
                    Text("Part 2:")
                    TextField("", text: $p2Result)
                    
                    Spacer()
                    
                    Text("Time [s]:")
                    TextField("", text: $solveTime)
                    
                    Spacer()
                    
                    Button(action: {
                        let ans = idx.run(day: selection)
                        p1Result = ans.p1
                        p2Result = ans.p2
                        solveTime = ans.solveTime
                    }) {
                        Text("Run")
                    }
                }.padding()
            }.padding()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().frame(minWidth: 400, idealWidth: 400, maxWidth: .infinity, minHeight: 400, idealHeight: 400, maxHeight: .infinity)
    }
}
