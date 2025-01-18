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
    
    var topics: [TopicList] = []
    
    var topicDatas: [[UnslpashTopic]] = [[],[],[]]
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mainView.scrollView.delegate = self
        
        for i in 0..<mainView.collectionViews.count {
            mainView.collectionViews[i].delegate = self
            mainView.collectionViews[i].dataSource = self
            mainView.collectionViews[i].tag = i
            mainView.collectionViews[i].register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.id)
        }
        
        NetworkManager.shared.callRequestTopic { value in
            self.topics = value
            self.randomTopic()
        }
       
    }
    
    
    func randomTopic() {
        topics = topics.shuffled()
        
        for i in 0..<mainView.collectionViews.count {
                //이미지 뷰 추가
            let topic = TitleEnum(rawValue: topics[i].slug)?.title ?? "일치하는 케이스가 없습니다"
            print(topics[i].slug)
            mainView.topicLabels[i].text = topic
            
            NetworkManager.shared.callRequestTopicImage(topic: topics[i].slug) { value in
                self.topicDatas[i] = value
                self.mainView.collectionViews[i].reloadData()
                self.mainView.collectionViews[i].scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
               // print(self.topicDatas)
            }
        }
    }
    
 
}

// MARK: - CollectionView Delegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
        if collectionView.tag == 0 {
            return topicDatas[0].count
        } else if collectionView.tag == 1 {
            return topicDatas[1].count
        } else {
            return topicDatas[2].count
        }
        //print(collectionView.tag)
        
        //return 10 //items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //print(#function,collectionView.tag)
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else {
    
                return UICollectionViewCell()
            }
            if topicDatas[0].count != 0 {
                cell.setup(data: topicDatas[0][indexPath.item])
            }
          
            
            //cell.imageView.backgroundColor = .blue
            return cell
        } else if  collectionView.tag == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else {

                return UICollectionViewCell()
            }
            if topicDatas[1].count != 0 {
                cell.setup(data: topicDatas[1][indexPath.item])
            }
            //cell.imageView.backgroundColor = .red
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else {
                return UICollectionViewCell()
            }
            if topicDatas[2].count != 0 {
                cell.setup(data: topicDatas[2][indexPath.item])
            }
            //cell.imageView.backgroundColor = .green
            return cell
        }
        

        
    }
    
    
    
}


extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print(#function)

        randomTopic()
      
    }
}
