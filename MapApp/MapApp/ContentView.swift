//
//  ContentView.swift
//  MapApp
//
//  Created by 박지혜 on 7/4/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let paris = CLLocationCoordinate2D(latitude: 48.856613, longitude: 2.352222)
}

struct ContentView: View {
    let locatoinManager = CLLocationManager()
    
    @State var message = "Map of Paris"
//    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: .paris, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion(center: .paris, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    
    var body: some View {
        VStack {
//            Map(coordinateRegion: $region, showsUserLocation: true)
                // 맵 스타일 적용
//                .mapStyle(.imagery) /// 항공사진
            // Annotation
            Map(position: $position) {
                Annotation("에펠탑", coordinate: .paris) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundStyle(.purple)
                        .background(.white)
                        .clipShape(Circle())
                }
            }
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
