//
//  ContentView.swift
//  ConcurrencyApp
//
//  Created by 박지혜 on 7/1/24.
//

import SwiftUI

enum Response {
    case success
}

struct ContentView: View {
    @State var message = ""
    @State var sliderValue = 0.0
    
    var body: some View {
        VStack {
            Button("Click Me") {
                let startTime = NSDate()

                callFunction()
                let endTime = NSDate()
                message = "Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds"
            }
            Spacer()
            Slider(value: $sliderValue)
            Text("Message = \(message)")
        }
        .padding()
    }
    
    func doSomething() async throws -> Response {
        try await Task.sleep(nanoseconds: 2_000_000_000) /// async 함수에 들어오니 비동기로 실행되어 실행 시간이 줄어듦
        print("sleep done.")
        return Response.success
    }
    
    func callFunction() {
        Task(priority: .high) {
            do {
                _ = try await doSomething()
            } catch {
                
            }
        }
    }
}

#Preview {
    ContentView()
}
