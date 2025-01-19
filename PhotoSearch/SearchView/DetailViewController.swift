//
//  DetailViewController.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/18/25.
//

import UIKit

import Kingfisher

class DetailViewController: UIViewController {
    
    
    let detailView = DetailView()
    
    var resultInfo: Result?
    
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserDeatil()

       
    }
    
    
    private func getUserDeatil() {
        //print(userDetail)
        
        guard let id = resultInfo?.id else { return }
        
        NetworkManager.shared.callRequestGetUserDetail(id: id) { value in
            let userDetail = value
            self.loadData(value: userDetail)
            
        }
        
    }
    
    private func loadData(value: UserDetail) {
        
        
        guard let result = resultInfo else { return }
        
        var url = URL(string: result.user.profile_image.small)
        detailView.profileImageView.kf.setImage(with: url)
        
        url = URL(string: result.urls.small) // full 너무 오래걸림.
        detailView.mainImge.kf.setImage(with: url)
        
        detailView.nameLable.text = result.user.name
        detailView.dateLable.text = releaseDateString(result.created_at) + " 게시됨"
        detailView.latestLabel.text = "(latest: \(releaseDateString(result.updated_at)))"
        
        
        // 상세화면 입장시, BaseView에 미리 작업하면, 로딩되는 잠깐의 시간동안, baseView에 작업한 내용이 먼저 나옴, 그래서 화면전환이 어색함.
        let descripionTitle: [String] = ["크기", "조회수", "다운로드"]
        for i in 0..<detailView.descripionLables.count {
            detailView.descripionLables[i].text = descripionTitle[i]
            detailView.descripionLables[i].textAlignment = .left
            detailView.descripionResultLables[i].textAlignment = .right
        }
        
        
        // 정보 레이블
        detailView.descripionResultLables[0].text = "\(result.width) X \(result.height)" // 이미지 크기
        detailView.descripionResultLables[1].text = value.downloads.total.formatted() // 조회수
        detailView.descripionResultLables[2].text = value.views.total.formatted() // 다운로드
                
        
    }
    
    private func releaseDateString(_ releaseDate: String) -> String {
        // 서버에서 주는 형태 (ISO규약에 따른 문자열 형태)
        // isoDate - Iso 형태의 문자열을 Iso 형태의 날짜 형식으로 변환
        guard let isoDate = ISO8601DateFormatter().date(from: releaseDate) else { return "" }
        
        print(isoDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy. MMM dd"
        let dateString = dateFormatter.string(from: isoDate)
        return dateString
    }

    
}

