//
//  ContentView.swift
//  Speech2TextApp
//
//  Created by 박지혜 on 7/8/24.
//

import SwiftUI
import Speech

struct ContentView: View {
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    
    @State var recognitionrequest: SFSpeechAudioBufferRecognitionRequest?
    @State var recognitionTask: SFSpeechRecognitionTask? /// 비동기 task로 동작
    
    @State var message = ""
    @State var buttonStatus = true
    
    var body: some View {
        VStack {
            TextEditor(text: $message)
                            .frame(width: 350, height: 400)
                        Button(buttonStatus ? "Start recording" : "Stop recording", action: {
                            buttonStatus.toggle()
                            if buttonStatus {
                                stopRecording()
                            } else {
                                startRecording()
                            }
                        })
                        .padding()
                        .background(buttonStatus ? Color.green : Color.red)
        }
        .padding()
    }

    // MARK: - Methods
    func startRecording() {
        message = "Start recording"
        // 입력 노드
        /// 마이크 입력
        let node = audioEngine.inputNode
        // 음성 인식 요청 객체 생성
        recognitionrequest = SFSpeechAudioBufferRecognitionRequest()
        /// 부분 결과 보고
        recognitionrequest?.shouldReportPartialResults = true
        // 오디오 포맷
        let recordingFormat = node.outputFormat(forBus: 0)
        // 입력 노드에 탭을 설치하여 오디오 버퍼 수집
        /// 마이크 입력이 버퍼에 캡처되고 이를 음성 인식 요청 객체에 추가
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            recognitionrequest?.append(buffer)
        }
        
        // 오디오 엔진 준비 및 시작
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        
        // 음성 인식기 생성
        guard let recognizeMe = SFSpeechRecognizer() else {
            return
        }
        if !recognizeMe.isAvailable {
            return
        }
        
        // 음성 인식 작업 시작
        /// result가 있으면, 인식된 텍스트를 transcribedString에 저장하고, 이를 message 변수에 할당
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionrequest ?? SFSpeechAudioBufferRecognitionRequest.init(), resultHandler: { result, error in
            if let result = result {
                let transcribedString = result.bestTranscription.formattedString
                message = transcribedString
            } else if let error = error {
                print(error)
            }
        })
    }
    
    func stopRecording() {
        audioEngine.stop()
        recognitionTask?.cancel()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionrequest?.endAudio()
    }
}

#Preview {
    ContentView()
}
