//
//  DetailViewController.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/18/25.
//

import UIKit

import Kingfisher

final class DetailViewController: UIViewController {
    
    
    private var detailView = DetailView()
    var detailModel = DetailViewModel()
    
    //var resultInfo: Result? //뷰컨에서 받는 데이터
    
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        detailModel.input.viewDidLoad.value = ()
        bind()
    }
    
    private func bind() {

        detailModel.output.errorMessage.lazyBind { [weak self] msg in
            self?.showAlert(msg: msg)
        }
        
        detailModel.output.getinfo.lazyBind { [weak self] info in
            
            self?.detailView.profileImageView.kf.setImage(with: info.profileImageURL)
            self?.detailView.mainImage.kf.setImage(with: info.mainImageURL)
            
            self?.detailView.nameLable.text = info.userName
            self?.detailView.dateLable.text = info.dateLabel
            self?.detailView.latestLabel.text = info.latestLabel
            
            for i in 0..<info.descripionTitle.count {
                self?.detailView.descripionLables[i].text = info.descripionTitle[i]
                self?.detailView.descripionResultLables[i].text = info.descripionResultLables[i]
        
            }
            
            self?.detailView.informationLable.text = info.informationLable
            
        }
    }
    
    deinit {
        print("DetailViewController Deinit")
    }
  
    

    
    
}

extension DetailViewController {
    
    private func showAlert(msg: String) {
        let alert = UIAlertController(title: "안내", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        
        alert.addAction(ok)
        present(alert,animated: true)
        
    }
}
