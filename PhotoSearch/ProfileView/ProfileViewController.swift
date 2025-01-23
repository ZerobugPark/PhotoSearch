//
//  ProfileViewController.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/23/25.
//

import UIKit

final class ProfileViewController: UIViewController {


    private var profileView = ProfileView()
    
    override func loadView() {
        view = profileView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        UserDefaults.standard.set("Login", forKey: "UserStatus")
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(nicknameReceivedNotification), name: NSNotification.Name("Nickname"), object: nil)
        
        
        
        profileView.nicknameButton.addTarget(self, action: #selector(nickNameButtonTapped), for: .touchUpInside)
        profileView.birthdayButton.addTarget(self, action: #selector(birthdayButtonTapped), for: .touchUpInside)
        profileView.levelButton.addTarget(self, action: #selector(levelButtonTapped), for: .touchUpInside)
    }

    @objc private func nicknameReceivedNotification(notifcation: NSNotification) {
        print(#function)
        if let value = notifcation.userInfo?["nickname"] as? String {
            profileView.nicknameLabel.text = value
        } else {
            profileView.nicknameLabel.text = "unknown"
        }
        
    }
    
    @objc private func okButtonTapped() {
        print(#function)
    }
    
    @objc private func nickNameButtonTapped(_ sender: UIButton) {
        let vc = NicknameViewController()
        vc.textField.text = profileView.nicknameLabel.text
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc private func birthdayButtonTapped(_ sender: UIButton) {
        let vc = BirthdayViewController()
        vc.date = { value in
            self.profileView.birthdayLabel.text = value
        }
        
        let formatter = DateFormatter()
        
        let stringDate = profileView.birthdayLabel.text
        print(stringDate)
        
        if let date = profileView.birthdayLabel.text {
            vc.datePicker.date = formatStringToDate(stringDate: date, inputFormat: "yy.MM.dd",  outputFormat: "yyyy-MM-dd hh:mm:ss ZZZ") ?? Date()
        }
        
    
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func levelButtonTapped(_ sender: UIButton) {
        let vc = LevelViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }

    
    private func configureNavigationBar() {
        navigationItem.title = "프로필 화면"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "탈퇴하기", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white

    }

    private func formatStringToDate(stringDate: String, inputFormat: String, outputFormat: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat //"yy.MM.dd"
        guard let date = dateFormatter.date(from: stringDate) else {
            print("변환 오류")
            return nil
        }
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        dateFormatter.dateFormat = outputFormat //"yy.MM.dd"
        return date
    }
        
}
