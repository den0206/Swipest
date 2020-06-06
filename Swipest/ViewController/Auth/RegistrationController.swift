//
//  RegistrationController.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/06.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class RegistrationController : UIViewController {
    
    
    
    //MARK: - Parts
    
    private let photoSelectPhotoButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        button.setDimensions(height: 275, width: 275)
//        button.layer.cornerRadius = 275 / 2
        return button
    }()
    
    private let emailTextField : UITextField = {
        return configTerxtField(placehiolder: "Email")
    }()
    
    private let fullnameTextField : UITextField = {
        return configTerxtField(placehiolder: "FullName")
    }()
    
    private let passwordTextField : UITextField = {
           return configTerxtField(placehiolder: "Password", isSecureMode: true)
    }()
    
    private let signUpButton : AuthButton = {
        
        let button = AuthButton(title: "Sign Up", type: .system)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
   
    
    private let alreadyHaveAccountButton : UIButton = {
        let button = UIButton(type: .system)
        let attributesText = NSMutableAttributedString(string: "既にアカウントを持っていますか？", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        
        attributesText.append(NSMutableAttributedString(string: " Log In", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]))
        
        button.setAttributedTitle(attributesText, for: .normal)
        button.addTarget(self, action: #selector(handleShowIn), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        
        /// viewcopntroller Extension
        configureGradientLayer()
        
        view.addSubview(photoSelectPhotoButton)
        photoSelectPhotoButton.centerX(inView: view)
        photoSelectPhotoButton.anchor(top : view.safeAreaLayoutGuide.topAnchor,paddingTop: 8)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, fullnameTextField, passwordTextField, signUpButton])
        
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top : photoSelectPhotoButton.bottomAnchor, left : view.leftAnchor, right: view.rightAnchor,paddingTop: 16,paddingLeft: 32,paddingRight: 32)
        
        
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left : view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
    }
    
    //MARK: - Actions
    
    @objc func selectPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handleSignUp() {
        print("Sign UP")
    }
    
    @objc func handleShowIn() {
        navigationController?.popViewController(animated: true)
    }
}

extension RegistrationController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        photoSelectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        photoSelectPhotoButton.layer.borderColor = UIColor.white.cgColor
        photoSelectPhotoButton.layer.borderWidth = 3
        photoSelectPhotoButton.imageView?.contentMode = .scaleAspectFill
        
        dismiss(animated: true, completion: nil)
        
    }
}
