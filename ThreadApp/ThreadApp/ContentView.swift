//
//  ContentView.swift
//  ThreadApp
//
//  Created by 박지혜 on 7/1/24.
//

import SwiftUI

struct ContentView: View {
    @State var message = ""
    @State var results = ""
    @State var sliderValue = 0.0
    
    var body: some View {
        VStack {
            Button("Click Me") {
                let startTime = NSDate()
                // 아랫 부분이 오래 걸리는 작업이므로 동시 실행
                let queue = DispatchQueue.global(qos: .default) /// qos: 우선순위
                queue.async {
                    let fetchedData = fetchSomethingFromServer()
                    let processedData = processData(fetchedData)
                    
                    var firstResult: String!
                    var secondResult: String!
                    // 그룹을 만들어서 동시 실행
                    let group = DispatchGroup()
                    
                    queue.async(group: group) {
                        firstResult = calculateFirstResult(processedData)
                    }
                    queue.async(group: group) {
                        secondResult = calculateSecondResult(processedData)
                    }
                    
                    // 그룹으로 묶여있는 것들 중 최종완료 시점에 notify가 실행됨
                    group.notify(queue: queue) {
                        let resultsSummary = "First: [\(firstResult!)]\nSecond: [\(secondResult!)]"
                        results = resultsSummary
                        
                        let endTime = NSDate()
                        message = "Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds."
                    }
                }
            }
            TextEditor(text: $results)
            Slider(value: $sliderValue)
            Text("Message =  \(message)")
        }
        .padding()
    }
    
    func fetchSomethingFromServer() -> String {
        Thread.sleep(forTimeInterval: 1)
        return "Hi there"
    }
    
    func processData(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 2)
        return data.uppercased()
    }
    
    func calculateFirstResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 3)
        let message = "Number of chars: \(String(data).count)"
        return message
    }
    
    func calculateSecondResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 4)
        return data.replacingOccurrences(of: "E", with: "e")
    }
}

#Preview {
    ContentView()
}
