//
//  ContentView.swift
//  ErrorApp
//
//  Created by 박지혜 on 7/9/24.
//

import SwiftUI

enum MajorProblems: Error {
    case divideByZero
    case noNegativeNumbersPlease
}

struct ContentView: View {

    @State var message = ""
    @State var numeratorSlider: Float = 0.0 /// 분자
    @State var denominatorSlider: Float = 0.0 /// 분모

    var body: some View {
        VStack {
            HStack {
                Text("Numerator = \(numeratorSlider)")
                Slider(value: $numeratorSlider, in: -20...20, step: 1.0)
            }
            HStack {
                Text("Denominator = \(denominatorSlider)")
                Slider(value: $denominatorSlider, in: -20...20, step: 1.0)
            }
            Button {
                divideFunction(numerator: Double(numeratorSlider), denominator: Double(denominatorSlider))
            } label: {
                Text("Divide")
            }
            Text(message)
        }
        .padding()
    }

    func divideFunction(numerator: Double, denominator: Double) {
        // if let과 try?를 이용한 간결한 에러 핸들링
        if let answer = try? checkMe(top: numerator, bottom: denominator) {
            message = "Answer = \(numerator / denominator)"
        } else {
            message = "Some other error occurred"
        }
        
        // 복잡한 에러처리 대신 단일 에러 핸들링
//        do {
//            try checkMe(top: numerator, bottom: denominator)
//            message = "Answer = \(numerator / denominator)"
//        } catch {
//            message = "Some other error occurred"
//        }
    }

    func checkMe(top: Double, bottom: Double) throws -> Double {
        guard (bottom != 0) else {
            throw MajorProblems.divideByZero
        }
        guard (top > 0 && bottom > 0) else {
            throw MajorProblems.noNegativeNumbersPlease
        }
        return top / bottom
    }
}

#Preview {
    ContentView()
}
