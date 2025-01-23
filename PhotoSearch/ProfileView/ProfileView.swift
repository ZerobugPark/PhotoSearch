//
//  ProfileView.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/23/25.
//

import UIKit

final class ProfileView: BaseView {

    let nicknameButton = CustomButton(title: "닉네임")
    let birthdayButton = CustomButton(title: "생일")
    let levelButton = CustomButton(title: "레벨")
    
    let nicknameLabel = CustomLabel(title: "NO NAME")
    let birthdayLabel = CustomLabel(title: "NO DATE")
    let levelLabel = CustomLabel(title: "NO LEVEL")
    
    

    override func configureHierarchy() {
        
        self.addSubview(nicknameButton)
        self.addSubview(birthdayButton)
        self.addSubview(levelButton)
        
        self.addSubview(nicknameLabel)
        self.addSubview(birthdayLabel)
        self.addSubview(levelLabel)

    }
    
    override func configureLayout() {
        
        nicknameButton.snp.makeConstraints { make in
            make.leading.top.equalTo(self.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        birthdayButton.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(24)
            make.top.equalTo(nicknameButton.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }

        levelButton.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(24)
            make.top.equalTo(birthdayButton.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(24)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(nicknameButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(24)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(birthdayButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }

        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(24)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(levelButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }

        
    }
    
    override func configureView() {
        
        self.backgroundColor = .white


    }

}
