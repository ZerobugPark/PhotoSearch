//
//  HomeViewController.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/17/25.
//

import UIKit


class HomeViewController: UIViewController {
    
    static let id = "HomeViewController"
    
    private let mainView = HomeView()
    
    private var topics: [TopicList] = []
    
    private var topicDatas: [[UnslpashTopic]] = [[],[],[]]
    
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
        
//        NetworkManager.shared.callRequestTopic(api: .topics) { value in
//            self.topics = value
//            self.randomTopic()
//        }
        
        NetworkManager.shared.callRequest(api: .topics, type: [TopicList].self) { value in
            self.topics = value
            self.randomTopic()
            print(value)
        } failHandler: {
            print("")
        }
        

        
    }
    
    
    private func randomTopic() {
        topics = topics.shuffled()
        
        let group = DispatchGroup()
        
        
        for i in 0..<mainView.collectionViews.count {
            group.enter()
            let topic = TitleEnum(rawValue: topics[i].slug)?.title ?? "일치하는 케이스가 없습니다"
            print(topics[i].slug)
            mainView.topicLabels[i].text = topic
            
            NetworkManager.shared.callRequest(api: .topicImage(slug: topics[i].slug), type: [UnslpashTopic].self) { value in
                self.topicDatas[i] = value
                group.leave()

            } failHandler: {
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("끝")
            for i in 0..<self.mainView.collectionViews.count
            {
                self.mainView.collectionViews[i].reloadData()
                self.mainView.collectionViews[i].scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
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
        } else if collectionView.tag == 2 {
            return topicDatas[2].count
        } else {
            return 0
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell  else { return UICollectionViewCell() }
            if topicDatas[0].count != 0 {
                cell.setup(data: topicDatas[0][indexPath.item])
            }
            return cell
        } else if  collectionView.tag == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
            if topicDatas[1].count != 0 {
                cell.setup(data: topicDatas[1][indexPath.item])
            }
            return cell
        } else if collectionView.tag == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
            if topicDatas[2].count != 0 {
                cell.setup(data: topicDatas[2][indexPath.item])
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
        
        
        
    }
    
    
    
}

// MARK: - ScrollViewDelegate Delegate
extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print(#function)
        
        randomTopic()
        
    }
}
