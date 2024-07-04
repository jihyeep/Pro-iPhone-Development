//
//  ContentView.swift
//  MapApp
//
//  Created by 박지혜 on 7/4/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let locatoinManager = CLLocationManager()
    
    @State var message = "Map of Paris"
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.856613, longitude: 2.352222), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    var body: some View {
        VStack {
            Map(coordinateRegion: $region)
            TextEditor(text: $message)
                .frame(width: .infinity, height: 100)
        }
        .onAppear {
            locatoinManager.desiredAccuracy = kCLLocationAccuracyBest
            // 위치 업데이트의 빈도 제어
            locatoinManager.distanceFilter = kCLDistanceFilterNone /// 빈번한 업데이트
            locatoinManager.requestWhenInUseAuthorization()
            locatoinManager.startUpdatingLocation()
        }
    }
}

#Preview {
    ContentView()
}
