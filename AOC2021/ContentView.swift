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
    let days = ["Day1", "Day2"]
    
    var body: some View {
        VStack {
            Picker("Select a day:", selection: $selection) {
                ForEach(days, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.menu)

            Button(action: {
                idx.run(day: selection)
            }) {
                Text("click here")
            }
//            Text("Selected color: \(colors[selection])")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
