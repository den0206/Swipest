//
//  SettingCell.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/10.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

protocol SettingCellDelegate : class {
    func updateUserInfo(_ cell : SettingCell, value : String,sectin : settingSections)
    
    func updateAgeRange(_ cell : SettingCell, sender : UISlider)
}

class SettingCell : UITableViewCell {
    
    var viewModel : SettingViewModel! {
        didSet {
            configure()
        }
    }
    
    weak var delegate : SettingCellDelegate?
    //MARK: - Parts
    
    lazy var inputField : UITextField = {
        let tf = UITextField()
        
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
//        tf.placeholder = "Enter value here"
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 50, width: 20)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        tf.addTarget(self, action: #selector(editindDidEnd), for: .editingDidEnd)
        return tf
    }()
    
    var sliderStack = UIStackView()
    let minAgeLabel = UILabel()
    let maxAgeLabel = UILabel()
    
    lazy var minAgeSlider = createAgeRangeSlider()
    lazy var maxAgeSlider = createAgeRangeSlider()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
//
//        minAgeLabel.text = "Min 18"
//        maxAgeLabel.text = "Max 60"
        
        addSubview(inputField)
        inputField.fillSuperview()
        
        let minStack = UIStackView(arrangedSubviews: [minAgeLabel,minAgeSlider])
        minStack.spacing = 24
        
        let maxStack = UIStackView(arrangedSubviews: [maxAgeLabel,maxAgeSlider])
        maxStack.spacing = 24
        
        
        sliderStack = UIStackView(arrangedSubviews: [minStack, maxStack])
        sliderStack.axis = .vertical
        sliderStack.spacing = 16
        
        addSubview(sliderStack)
        sliderStack.centerY(inView: self)
        sliderStack.anchor(left : leftAnchor,right: rightAnchor,paddingLeft: 24,paddingRight: 24)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func editindDidEnd(sender : UITextField) {
        
        guard let value = sender.text else {return}
        
        delegate?.updateUserInfo(self, value: value, sectin: viewModel.section)
    }
    
    @objc func handleRangeChange(sender : UISlider) {
        
        if sender == minAgeSlider {
            minAgeLabel.text = viewModel.minAgeLabelText(value: sender.value)
        } else {
            maxAgeLabel.text = viewModel.maxAgeLabelText(value: sender.value)
        }
        
        delegate?.updateAgeRange(self, sender: sender)
        
    }
    
    
    //MARK: - Helpers
    
    func createAgeRangeSlider() -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 60
        
        slider.addTarget(self, action: #selector(handleRangeChange), for: .valueChanged)
        
        return slider
        
    }
    
    private func configure() {
         
        inputField.isHidden = viewModel.shoulHideInputField
        sliderStack.isHidden = viewModel.shoulHideSlidr
        
        inputField.placeholder = viewModel.placeHolderText
        
        inputField.text = viewModel.value
        
        /// set value label
        minAgeLabel.text = viewModel.minAgeLabelText(value: viewModel.minAgeSliderValue)
        maxAgeLabel.text = viewModel.maxAgeLabelText(value: viewModel.maxAgeSliderValue)

        
        minAgeSlider.setValue(viewModel.minAgeSliderValue, animated: true)
        maxAgeSlider.setValue(viewModel.maxAgeSliderValue, animated: true)
        
    }
}
