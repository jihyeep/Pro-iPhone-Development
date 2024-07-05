//
//  ContentView.swift
//  VideoApp
//
//  Created by 박지혜 on 7/5/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State var player: AVPlayer?
    
    var body: some View {
        VideoPlayer(player: player) {
            // 비디오 플레이어 영역 위에 view 작업
            VStack {
                Text("Overlay text to appear")
                    .foregroundStyle(.white)
            }
        }
            .frame(height: 320)
            .onAppear {
                guard let videoURL = Bundle.main.url(forResource: "SaturnV", withExtension: "mov") else {
                    print("Video file not found")
                    return
                }
                player = AVPlayer(url: videoURL as URL)
            }
    }
}

#Preview {
    ContentView()
}
