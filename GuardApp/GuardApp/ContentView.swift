//
//  ContentView.swift
//  GuardApp
//
//  Created by 박지혜 on 7/9/24.
//

import SwiftUI

struct ContentView: View {

    @State var showImage: UIImage = UIImage(systemName: "photo")!

    var body: some View {
        VStack {
            Image(uiImage: showImage)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 400)
            Button {
                getImage("xyz")
            } label: {
                Text("Add Picture")
            }
        }
        .padding()
    }

    func getImage(_ imageName: String) {
        // guard 를 이용한 구문으로 변경
        guard UIImage(named: imageName) != nil else {
            showImage = UIImage(systemName: "xmark.octagon.fill")!
            return
        }
        showImage = UIImage(named: imageName)!
    }
}

#Preview {
    ContentView()
}
