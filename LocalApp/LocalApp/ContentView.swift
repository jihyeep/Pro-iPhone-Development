//
//  ContentView.swift
//  LocalApp
//
//  Created by 박지혜 on 7/3/24.
//

import SwiftUI

struct ContentView: View {
    @State var changeColor = false
    
    var body: some View {
        VStack {
            // Text, Button
            Text(LocalizedStringKey("greeting-label"))
            Text("greeting-label")
            Button("button-label") {
                changeColor.toggle()
            }
        }
        .padding()
        .background(changeColor ? Color.red : Color.yellow)
    }
}

#Preview("기본 - 한국어") {
    ContentView()
}

#Preview("English") {
    ContentView()
        .environment(\.locale, .init(identifier: "en"))
}

#Preview("French") {
    ContentView()
        .environment(\.locale, .init(identifier: "fr"))
}

#Preview("Spanish") {
    ContentView()
        .environment(\.locale, .init(identifier: "es"))
}
