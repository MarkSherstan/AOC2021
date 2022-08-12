//
//  ContentView.swift
//  AOC2021
//
//  Created by Mark Sherstan on 2022-08-11.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = "R"
    let colors: [String: String] = ["R": "Red", "G": "Green"]
    let colorKeyArray: [String]
    
    init() {
        self.colorKeyArray = Array(self.colors.keys)
    }
    
    var body: some View {
        VStack {
            Picker("Select a paint color", selection: $selection) {
                ForEach(colorKeyArray, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.menu)

            Text("Selected color: \(colors[selection]!)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
