//
//  SettingViewController.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/09.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import JGProgressHUD

private let headerIdentifer = "headerIdetifer"
private let reuseIdentifer = "SettingCell"

protocol SettingViewControllerDelegate : class {
    func settingController(_ controller : SettingViewController, user : User)
    func handleLogout(_ controller : SettingViewController)
}

class SettingViewController : UITableViewController {
    
    lazy var headerView = SettingsHeaderView(user: user)
    private let footerView = SettingFooterView()
    private var imageIndex = 0
    
    private var user : User
    
    weak var delegate : SettingViewControllerDelegate?
    
    init(user :User) {
        self.user = user
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
        
        print(user)
    }
    
    //MARK: -UI
    
    private func configureUI() {
        navigationItem.title = "Setting"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        
    }
    
    
    private func configureTableView() {
        
        tableView.separatorStyle = .none
        
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        
        headerView.delegate = self
        footerView.delegate = self

        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 80)

        tableView.register(SettingCell.self, forCellReuseIdentifier: reuseIdentifer)
 
        tableView.backgroundColor = .systemBackground
        
        
    }
    
    //MARK: - Actions
    
    @objc func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDone() {
        /// for endEditing
        view.endEditing(true)
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Uploading..."
        hud.show(in: view)
        
        Service.saveUserDate(user: user) { (error) in
            self.delegate?.settingController(self, user: self.user)

        }
    }
    
    //MARK: -API
    
    func uploadImage(image : UIImage) {
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Uploading..."
        hud.show(in: view)
        
        ///insert index
        Service.uploadImage(image: image) { (imageUrl) in
            self.user.profileImageUrl.append(imageUrl)
            hud.dismiss()
        }
    }
    
    
}

//MARK: - Tableview Delegate

extension SettingViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return settingSections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! SettingCell
        
        guard let section = settingSections(rawValue: indexPath.section) else {return cell}
        let viewModel = SettingViewModel(user: user, section: section)
        
        cell.delegate = self
        cell.viewModel = viewModel
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = settingSections(rawValue: indexPath.section) else {return 0}
        
        return section == .ageRange ? 96 : 45
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let section = settingSections(rawValue: section) else {return nil}
        
        return section.description
        
    }
    
    
}

//MARK: - Imagepicker Delegats

extension SettingViewController : SettingsHeaderDelegate , UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func selectingPhoto(_ header: SettingsHeaderView, didSelect index: Int) {
        
        self.imageIndex = index
        
        let picker = UIImagePickerController()

        picker.delegate = self

        present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        
        headerView.buttons[imageIndex].setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        /// update Photo
        uploadImage(image: selectedImage)
        
        dismiss(animated: true, completion: nil)
        
    }
    
}

extension SettingViewController : SettingCellDelegate {
   
    
    func updateUserInfo(_ cell: SettingCell, value: String, sectin: settingSections) {
        
        switch sectin {
            
        case .name:
            user.name = value
        case .profession:
            user.profession = value
        case .age:
            user.age = Int(value) ?? user.age
        case .bio:
            user.bio = value
        case .ageRange:
            break
        }
        
    }
    
    
    func updateAgeRange(_ cell: SettingCell, sender: UISlider) {
        
        /// update Age
        if sender == cell.minAgeSlider {
            user.minSeekingAge = Int(sender.value)
        } else {
            user.maxSeekingAge = Int(sender.value)
        }
    }
    
}

extension SettingViewController : SettingFooterViewDelegate {
    func handleLogout() {
        delegate?.handleLogout(self)
    }

}
