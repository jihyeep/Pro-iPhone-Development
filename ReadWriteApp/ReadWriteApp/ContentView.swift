//
//  ContentView.swift
//  ReadWriteApp
//
//  Created by 박지혜 on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    @State var createText = ""
    @State var displayText = ""
    
    var body: some View {
        VStack {
            TextEditor(text: $createText)
            HStack {
                Button(action: {
                    let fm = FileManager.default
                    // userDomainMask 안에 있는 documentDirectory를 모두 가져옴
                    let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
                    // 경로 마지막에 file.txt를 붙임
                    let url = urls.last?.appendingPathComponent("file.txt")
                    do {
                        // atomically: 파일에 쓰다가 중간에 멈추지 말아라 -> lock 걸림
                        try createText.write(to: url!, atomically: true, encoding: String.Encoding.utf8)
                    } catch { // 파일 액세스는 항상 에러가 날 수 있음
                        print("File writing error")
                    }
                }) {
                    Text("Write File")
                }
                Button(action: {
                    let fm = FileManager.default
                    let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
                    let url = urls.last?.appendingPathComponent("file.txt")
                    do {
                        let fileContent = try String(contentsOf: url!, encoding: String.Encoding.utf8)
                        displayText = fileContent
                    } catch {
                        print("File reading error")
                    }
                }) {
                    Text("Read File")
                }
            }
            .padding()
            TextEditor(text: $displayText)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
