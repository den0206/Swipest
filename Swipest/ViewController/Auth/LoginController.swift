//
//  LoginController.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/06.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class LoginController : UIViewController {
    
    private var vm = LoginViewModel()
    
    //MARK: - Parts
    
    private let iconImageView : UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysTemplate))
        iv.tintColor = .white
        iv.setDimensions(height: 100, width: 100)
        
        return iv
    }()
    
    private lazy var emailTextField : UITextField = {
        
        return configTerxtField(placehiolder: "Email")
    }()
    
    private lazy var passwordTextField : UITextField = {
        
        return configTerxtField(placehiolder: "password", isSecureMode: true)
    }()
    
    private let loginButton : AuthButton = {
        let button = AuthButton(title: "Login", type: .system)
        button.addTarget( self, action: #selector(handleLogin), for: .touchUpInside)
        return button
        
    }()
    
    private let showRegistrationButton : UIButton = {
        let button = UIButton(type: .system)
        let attributesText = NSMutableAttributedString(string: "アカウントを持っていませんか？", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        
        attributesText.append(NSMutableAttributedString(string: " SIGN UP", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]))
        
        button.setAttributedTitle(attributesText, for: .normal)
        button.addTarget(self, action: #selector(handleShowUp), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func configureUI() {
        navigationController?.navigationBar.isHidden = true
        
        /// important
        navigationController?.navigationBar.barStyle = .black
        
        /// viewcopntroller Extension
        configureGradientLayer()

        
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.anchor(top : view.safeAreaLayoutGuide.topAnchor , paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,passwordTextField, loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top : iconImageView.bottomAnchor, left : view.leftAnchor, right: view.rightAnchor,paddingTop: 24,paddingLeft: 32,paddingRight: 32)
        
        view.addSubview(showRegistrationButton)
        showRegistrationButton.anchor(left : view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        
        /// add Observer
        let texts = [emailTextField,passwordTextField]
        
        for tf in texts {
            tf.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        }
        
    }
    

    //MARK: - Helpers
    
    
    
    //MARK: - Actions
    
    @objc func handleLogin() {
        print("Login")
    }
    
    @objc func handleShowUp() {
        let registVC = RegistrationController()
        
        navigationController?.pushViewController(registVC, animated: true)
    }
    
    @objc func textDidChange(sender : UITextField) {
        
        if sender == emailTextField {
            vm.email = sender.text
        } else {
            vm.password = sender.text
        }
        
        if vm.formValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}
