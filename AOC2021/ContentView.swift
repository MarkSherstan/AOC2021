//
//  ContentView.swift
//  AOC2021
//
//  Created by Mark Sherstan on 2022-08-11.
//

import SwiftUI

struct ContentView: View {
    var idx = Index()
    @State private var selection = "R"
    let days = ["Day1", "Day2"] // Can make this variable local to Index class
    // Add header
    // Spot to copy and paste results?
    
    var body: some View {
        
        VStack (alignment: .leading) {
            Text("Advent of Code 2021").font(.largeTitle)
            
            HStack {
                VStack {
                    Picker("Select day:", selection: $selection) {
                        ForEach(days, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
//                    .labelsHidden()
                    

                    //            Text("Selected color: \(colors[selection])")
                }
                
                VStack (alignment: .leading) {
                    Text("Part 1:")
                    
                    Spacer()
                    
                    Text("Part 2:")
                    
                    Spacer()
                    
                    Text("Time [s]:")
                    
                    Spacer()
                    
                    Button(action: {
                        idx.run(day: selection)
                    }) {
                        Text("Run")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
