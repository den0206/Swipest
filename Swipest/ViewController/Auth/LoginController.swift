//
//  LoginController.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/06.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class LoginController : UIViewController {
    
    //MARK: - Parts
    
    private let iconImageView : UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysTemplate))
        iv.tintColor = .white
        iv.setDimensions(height: 100, width: 100)
        
        return iv
    }()
    
    private lazy var emailTextField : UITextField = {
        
        return configTerxtField(placehiolder: "Email", isSecureMode: true)
    }()
    
    private lazy var passwordTextField : UITextField = {
        
        return configTerxtField(placehiolder: "password", isSecureMode: true)
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
        configurGradientLayer()

        
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.anchor(top : view.safeAreaLayoutGuide.topAnchor , paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,passwordTextField])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top : iconImageView.bottomAnchor, left : view.leftAnchor, right: view.rightAnchor,paddingTop: 24,paddingLeft: 32,paddingRight: 32)
        
    }
    
    func configurGradientLayer() {
        
        let topColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0,1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.frame
    }
    
    //MARK: - Helpers
    
    func configTerxtField(placehiolder : String, isSecureMode : Bool) -> UITextField {
        let tf = UITextField()
        
        let space = UIView()
        
        space.setDimensions(height: 50, width: 12)
        tf.leftView = space
        tf.leftViewMode = .always
        
        tf.borderStyle = .none
        tf.textColor = .white
        tf.backgroundColor = UIColor(white: 1, alpha: 0.2)
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.layer.cornerRadius = 5
        tf.attributedPlaceholder = NSAttributedString(string: placehiolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor(white: 1, alpha: 0.2)])
        tf.isSecureTextEntry = isSecureMode
        
        return tf
        
    }
}
