//
//  ViewController.swift
//  UIKitCodeonly
//
//  Created by 박지혜 on 7/8/24.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.title = "Button"
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "ViewController"
        
        self.view.addSubview(button)
        
        button.addAction(UIAction { [weak self] action in
            let hostingController = UIHostingController(rootView: SwiftUIView(name: "Nancy"))
            self?.navigationController?.pushViewController(hostingController, animated: true)
        }, for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
