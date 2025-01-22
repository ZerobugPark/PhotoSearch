//
//  ShortsCollectionViewCell.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/21/25.
//

import UIKit

import Kingfisher
import SnapKit

class ShortsCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "ShortsCollectionViewCell"
    
    let mainimageView = UIImageView()
    let profileImageView = CustomImageView()
    let nameLable = CustomLabel(boldStyle: false, fontSize: 12, color: .white)
    let dateLable = CustomLabel(boldStyle: true, fontSize: 12, color: .white)
    
    let stackView = UIStackView()
    
    override func configureHierarchy() {
        
        contentView.addSubview(mainimageView)
        addSubview(profileImageView)
        addSubview(stackView)
        stackView.addArrangedSubview(nameLable)
        stackView.addArrangedSubview(dateLable)
    }
    
    
    override func configureLayout() {
        
        mainimageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        
        }
        profileImageView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(12)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(30)
            make.width.equalTo(30)
            
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(12)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
    }
    
    override func configureView() {
        mainimageView.contentMode = .scaleToFill
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        
        nameLable.textColor = .white
        dateLable.textColor = .white
        
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            self.profileImageView.clipsToBounds = true
        }
    }
    

    
    func setup(data: Result) {
        
        var url = URL(string: data.urls.small)
        mainimageView.kf.setImage(with: url)
        
        url = URL(string: data.user.profile_image.small)
        profileImageView.kf.setImage(with: url)
        nameLable.text = data.user.name
        dateLable.text = releaseDateString(data.created_at) + " 게시됨"
        
    }
    
    private func releaseDateString(_ releaseDate: String) -> String {
        guard let isoDate = ISO8601DateFormatter().date(from: releaseDate) else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy. MMM dd"
        let dateString = dateFormatter.string(from: isoDate)
        return dateString
    }
}
