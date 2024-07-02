//
//  ContentView.swift
//  BindingApp
//
//  Created by 박지혜 on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var message = ""
    
    var body: some View {
        VStack {
            Text("Hello, \(message)")
            DisplayTextField(newVariable: $message)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct DisplayTextField: View {
    @Binding var newVariable: String
    
    var body: some View {
        HStack {
            Text("Send a greeting:")
            TextField("Type a message here", text: $newVariable)
        }
    }
}
