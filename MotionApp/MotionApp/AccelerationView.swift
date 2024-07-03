//
//  ContentView.swift
//  MotionApp
//
//  Created by 박지혜 on 7/3/24.
//

import SwiftUI
import CoreMotion

struct AccelerationView: View {
    let motionManager = CMMotionManager()
    // queue를 통해 신호를 잡아서 처리함
    let queue = OperationQueue()
    
    @State private var x: Double = 0.0
    @State private var y: Double = 0.0
    @State private var z: Double = 0.0
    
    var body: some View {
        VStack {
Text("x: \(x)")
Text("x: \(y)")
Text("x: \(z)")
        }
        .padding()
        .onAppear {
            // queue에 쌓임
            motionManager.startAccelerometerUpdates(to: queue) { (data: CMAccelerometerData?, error: Error?) in
                guard let data = data else {
                    print("error: \(error!)")
                    return
                }
                
                let trackMotion: CMAcceleration = data.acceleration
                motionManager.accelerometerUpdateInterval = 2.5 /// 센서가 예민해서 주기를 2.5로 설정
                DispatchQueue.main.async {
                    x = trackMotion.x
                    y = trackMotion.y
                    z = trackMotion.z
                }
        }
    }
}

#Preview {
    AccelerationView()
}
