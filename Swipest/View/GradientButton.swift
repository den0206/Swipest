//
//  SendMessageButton.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/15.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class SendMessageButton : UIButton {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let gradientLayer = CAGradientLayer()
        let leftColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        let rightColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        
        gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        layer.cornerRadius = rect.height /  2
        clipsToBounds = true
        gradientLayer.frame = rect
    }
}

// gradient (外枠)

class KeepSwipingButton : UIButton {
    
    override func draw(_ rect: CGRect) {
        let gradientLayer = CAGradientLayer()
        let leftColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        let rightColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        
        gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        let cornerRadius = rect.height / 2
        let maskLayer = CAShapeLayer()
        let maskPath = CGMutablePath()
        
        maskPath.addPath(UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath)
        
        /// mask Border Width
        maskPath.addPath(UIBezierPath(roundedRect: rect.insetBy(dx: 2, dy: 2), cornerRadius: cornerRadius).cgPath)
    
        maskLayer.path = maskPath
        
        maskLayer.fillRule = .evenOdd
        
        gradientLayer.mask = maskLayer
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        layer.cornerRadius = rect.height /  2
        clipsToBounds = true
        gradientLayer.frame = rect
    }
    
}
