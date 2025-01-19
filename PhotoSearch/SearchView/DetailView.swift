//
//  DetailView.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/19/25.
//

import UIKit

class DetailView: BaseView {
    
    
    
    let profileImageView = CustomImageView()
    let nameLable = CustomLabel(boldStyle: false, fontSize: 12)
    let DateLable = CustomLabel(boldStyle: true, fontSize: 12)
    
    let stackView = UIStackView()
    
    let mainImge = CustomImageView(cornerRadius: false)
    
    let informationLable =  CustomLabel(boldStyle: true, fontSize: 22)
    
    var descripionLables: [CustomLabel] = []
    var descripionResultLables: [CustomLabel] = []

    override func configureHierarchy() {
        
        addSubview(profileImageView)
        addSubview(stackView)
        stackView.addArrangedSubview(nameLable)
        stackView.addArrangedSubview(DateLable)
        addSubview(mainImge)
        addSubview(informationLable)
        
        for i in 0..<3 {
            let label = CustomLabel(boldStyle: true, fontSize: 15)
            let resultLabel = CustomLabel(boldStyle: false, fontSize: 15)
            
            descripionLables.append(label)
            addSubview(descripionLables[i])
            
            descripionResultLables.append(resultLabel)
            addSubview(descripionResultLables[i])
            
        }

       
        
    }
    
    override func configureLayout() {
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(4)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.height.equalTo(30)
            make.width.equalTo(30)
            
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(4)
            make.leading.equalTo(profileImageView.snp.trailing).offset(4)
        }
        
        mainImge.snp.makeConstraints { make in
            make.top.equalTo(self.profileImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(self)
            make.height.equalTo(200)
            
        }
        informationLable.snp.makeConstraints { make in
            make.top.equalTo(mainImge.snp.bottom).offset(8)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.height.equalTo(30)
            make.width.equalTo(40)
        }
        
        for i in 0..<3 {
            
            descripionLables[i].snp.makeConstraints { make in
                if i == 0{
                    make.top.equalTo(mainImge.snp.bottom).offset(8)
                } else {
                    make.top.equalTo(descripionLables[i-1].snp.bottom).offset(8)
                }
                
                make.leading.equalTo(self).offset(80)
                make.height.equalTo(20)
                make.width.greaterThanOrEqualTo(30)
            }
            
            descripionResultLables[i].snp.makeConstraints { make in
                if i == 0{
                    make.top.equalTo(mainImge.snp.bottom).offset(8)
                } else {
                    make.top.equalTo(descripionResultLables[i-1].snp.bottom).offset(8)
                }
    
                make.trailing.equalTo(self).inset(8)
                make.height.equalTo(20)
                make.width.greaterThanOrEqualTo(30)
            }
    
        }
        
    }
    
    override func configureView() {
        
        let descripionTitle: [String] = ["크기", "조회수", "다운로드"]
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 2

        profileImageView.backgroundColor = .red
        nameLable.text = "dsadadsadsad"
        DateLable.text = "DAsdadadsadasd"
        mainImge.backgroundColor = .blue
        
        informationLable.text = "정보"
        
        
        for i in 0..<descripionLables.count {

            descripionLables[i].text = descripionTitle[i]
            descripionLables[i].textAlignment = .left
            descripionResultLables[i].backgroundColor = .green
            descripionResultLables[i].text = "dsadadsadsad"
            descripionResultLables[i].textAlignment = .right
        }
        
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        }
        
    }
    
}
