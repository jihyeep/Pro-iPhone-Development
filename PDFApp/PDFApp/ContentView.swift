//
//  ContentView.swift
//  PDFApp
//
//  Created by 박지혜 on 7/8/24.
//

import SwiftUI
import PDFKit

struct ContentView: View {
    let fileURL = Bundle.main.url(forResource: "example", withExtension: "pdf")
    
    var body: some View {
        VStack {
            ViewMe(url: fileURL!)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

// UIViewRepresentable - SwiftUI와 UIKit 통합
struct ViewMe: UIViewRepresentable {
    let url: URL

    func makeUIView(context: UIViewRepresentableContext<ViewMe>) -> PDFView {
        // UIKit의 UIView 사용
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        
    }
}
