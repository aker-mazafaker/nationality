//
//  ViewController.swift
//  16.08classwork
//
//  Created by Akerke on 16.08.2023.
//

import UIKit
import KeychainAccess
import SnapKit

class ViewController: UIViewController {
    
    let keyChain = Keychain(service: "test")
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.tintColor = .white
        textField.textColor = .white
        textField.placeholder = "Ваше имя"
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.tintColor = .black
        button.setTitle("press", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    let backImage: UIImageView = {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.image = UIImage(named: "world_map")
        image.contentMode = .scaleToFill
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        makeConstraints()
    }
}

private extension ViewController {
    func setupScene() {
        view.addSubview(textField)
        view.addSubview(button)
        self.view.insertSubview(backImage, at: 0)
       
    }
    func makeConstraints() {
        textField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(300)
            $0.left.right.equalToSuperview().inset(70)
        }
        button.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(150)
            $0.left.right.equalToSuperview().inset(50)
        }
    
    }
    @objc func buttonTapped() {
       let secondVC = SecondViewController()
        secondVC.name = textField.text ?? ""
        self.present(secondVC, animated: true)
        
    }
    

    }

