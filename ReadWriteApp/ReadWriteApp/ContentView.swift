//
//  ContentView.swift
//  ReadWriteApp
//
//  Created by 박지혜 on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    let placeHolder = "텍스트를 입력하세요."
    @State var createText = "텍스트를 입력하세요."
    @State var displayText = ""
    
    @FocusState var textFieldFocus: Bool
    
    var body: some View {
        VStack {
            TextEditor(text: $createText)
                .foregroundStyle(placeHolder == createText ? .gray : .black)
                .focused($textFieldFocus)
                .onChange(of: textFieldFocus) {
                    /* textField에 포커스 이동 시 placeHolder가 표시되어 있으면,
                       입력 textField를 초기화하고 입력 대기 상태로 만듦 */
                    if textFieldFocus, placeHolder == createText {
                        createText = ""
                    /* 다른 입력으로 포커스 이동 시 입력한 텍스트가 없으면,
                       placeHoler 기본 텍스트로 대치 */
                    } else if !textFieldFocus, createText.isEmpty {
                        createText = placeHolder
                    }
                }            
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
                    // FileManager는 불필요한 데이터 저장일 수 있기 때문에 쓸 때마다 불러오는 것이 좋음
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
