//
//  RegistrationController.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/06.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class RegistrationController : UIViewController {
    
    private var vm = RegistrationViewModel()
    private var profileImage : UIImage?
    weak var delegate : AuthDelegate?
    
    
    //MARK: - Parts
    
    private let photoSelectPhotoButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        button.setDimensions(height: 275, width: 275)
        button.clipsToBounds = true
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
        
        /// add Obsrver
        let texts = [emailTextField, fullnameTextField, passwordTextField]
        
        for tf in texts {
            tf.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
            
        }
        
    }
    
    //MARK: - Actions
    
    @objc func selectPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handleSignUp() {
        
        //MARK: - Sign UP
        
        guard let profileImage = profileImage else {return}
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullname = fullnameTextField.text else {return}
        
        let credential = AuthCredential(email: email, fullname: fullname, password: password, profileImage: profileImage)
        
        print(credential)
        
        AuthService.registerUser(credential: credential) { (error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {return}
            guard let homeVC = window.rootViewController as? HomeController else {return}
            
            homeVC.checkIfUserIsLoggedIn()
            
            self.delegate?.AuthComplete()
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @objc func handleShowIn() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func textDidChange(sender : UITextField) {
        
        if sender == emailTextField {
            vm.email = sender.text
        } else if sender == fullnameTextField{
            vm.fullname = sender.text
        } else {
            vm.password = sender.text
        }
        
        if vm.formValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}

extension RegistrationController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        
        self.profileImage = image
        
        photoSelectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        photoSelectPhotoButton.layer.borderColor = UIColor.white.cgColor
        photoSelectPhotoButton.layer.borderWidth = 3
        photoSelectPhotoButton.layer.cornerRadius = 275 / 2
        photoSelectPhotoButton.imageView?.contentMode = .scaleAspectFill
        
        dismiss(animated: true, completion: nil)
        
    }
}
