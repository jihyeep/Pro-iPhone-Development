//
//  ContentView.swift
//  AudioApp
//
//  Created by 박지혜 on 7/5/24.
//

import SwiftUI

struct ContentView: View {
    var audioPlayerManager = AudioPlayerManager()
    @State var playAudio: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                if !playAudio {
                    audioPlayerManager.play()
                } else {
                    audioPlayerManager.pause()
                }
                playAudio.toggle()
            }, label: {
                // 재생 버튼이 아닌 상태의 의미
                Text(playAudio ? "Play audio": "Pause audio")
            })
        }
        .padding()
        .onAppear {
            audioPlayerManager.loadAudio(name: "Small World", withExtension: "mp3")
        }
    }
}

#Preview {
    ContentView()
}
