//
//  HomeViewController.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/17/25.
//

import UIKit

class HomeViewController: UIViewController {

    static let id = "HomeViewController"
    
    let mainView = HomeView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
        for i in 0..<mainView.collectionViews.count {
            mainView.collectionViews[i].delegate = self
            mainView.collectionViews[i].dataSource = self
            mainView.collectionViews[i].tag = i
            mainView.collectionViews[i].register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.id)
        }
       
    }
    

}

// MARK: - CollectionView Delegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
        
        return 10 //items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.imageView.backgroundColor = .blue
            return cell
        } else if  collectionView.tag == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.imageView.backgroundColor = .red
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.imageView.backgroundColor = .green
            return cell
        }
        

        
    }
    
    
    
}
