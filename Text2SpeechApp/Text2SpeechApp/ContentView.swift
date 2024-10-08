//
//  ContentView.swift
//  Text2SpeechApp
//
//  Created by 박지혜 on 7/8/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    let audio = AVSpeechSynthesizer()
    
    @State var convertText = AVSpeechUtterance(string: "")
    @State var textToRoad = "This is a test of the emergency broadcast system"
    @State var sliderValue: Float = 0.5 /// 음성 속도
    
    var body: some View {
        VStack {
            TextEditor(text: $textToRoad)
                .frame(width: 250, height: 200)
            Slider(value: $sliderValue, in: 0...1)
            Button {
                convertText = AVSpeechUtterance(string: textToRoad)
                convertText.rate = sliderValue
                
                // 다양한 음성 지원 (안되는 것도 있음)
                // https://gist.github.com/Koze/d1de49c24fc28375a9e314c72f7fdae4
                let voice = AVSpeechSynthesisVoice(language: "en-GB")
//                let voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.siri_male_en-GB_compact")
                convertText.voice = voice
                
                audio.speak(convertText)
            } label: {
                Text("Read Text Out Loud")
            }
        }
    }
}

#Preview {
    ContentView()
}
