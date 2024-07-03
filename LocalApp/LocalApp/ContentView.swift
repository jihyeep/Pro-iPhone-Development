//
//  ContentView.swift
//  LocalApp
//
//  Created by 박지혜 on 7/3/24.
//

import SwiftUI

struct ContentView: View {
    @State var changeColor = false
    @State var message = ""

    var placeHolder: LocalizedStringKey = "placeholder-label"
    
    let date = Date()
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long /// full, long, medium, short
        dateFormatter.timeStyle = .medium /// full, long, medium, short
        return dateFormatter
    }()
    
    var body: some View {
        VStack {
            Text(LocalizedStringKey("greeting-label \(message)"))
            // Text, Button은 LocalizedStringKey 를 직접 넣을 수 있음
            Text("greeting-label \(message)")
            Button("button-label") {
                changeColor.toggle()
            }
            TextField(placeHolder, text: $message)
            Text(date, formatter: dateFormatter)
        }
        .padding()
        .background(changeColor ? Color.red : Color.yellow)
    }
}

// 언어 미리보기 설정
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
