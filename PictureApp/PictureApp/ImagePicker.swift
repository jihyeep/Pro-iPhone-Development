//
//  ImagePicker.swift
//  PictureApp
//
//  Created by 박지혜 on 7/8/24.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType = UIImagePickerController.SourceType.camera
    @Binding var chosenImage: UIImage
    @Environment(\.presentationMode) var presentationMode /// 이미지 선택이 끝나면 뷰를 닫음

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let myImagePicker = UIImagePickerController()
        myImagePicker.sourceType = sourceType
        // context.coordinator는 makeCoordinator() 메서드가 반환한 Coordinator 인스턴스를 제공함
        /// 선언형인 SwiftUI에서 명령형인 UIKit을 사용하기 위해 coordinator를 사용함
        myImagePicker.delegate = context.coordinator
        return myImagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }

    // ImagePicker의 delegate 메서드 처리
    /// SwiftUI에서 UIKit 뷰 컨트롤러의 delegate와 dataSource를 관리하는 데 사용되는 coordinator 객체를 생성
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePicked: ImagePicker

    init(_ imagePicked: ImagePicker) {
        self.imagePicked = imagePicked
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 사용자가 이미지를 선택하면 선택된 이미지를 chosenImage에 할당
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePicked.chosenImage = image
        }
        imagePicked.presentationMode.wrappedValue.dismiss()
    }
}
