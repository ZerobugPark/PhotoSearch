//
//  HomeViewController.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/17/25.
//

import UIKit


final class HomeViewController: UIViewController {
    
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
        
        NetworkManager.shared.callRequest(api: .topics, type: [TopicList].self) { value in
            self.topics = value
            self.randomTopic()
        } failHandler: { status in
            let msg = Error.errorMsg(satus: status)
            self.showAlert(msg: msg)
        }
        
        
        
    }
    
    
    private func randomTopic() {
        topics = topics.shuffled()
        
        let group = DispatchGroup()
        
        
        for i in 0..<mainView.collectionViews.count {
            group.enter()
            let topic = TitleEnum(rawValue: topics[i].slug)?.title ?? "일치하는 케이스가 없습니다"
            //print(topics[i].slug)
            mainView.topicLabels[i].text = topic
            
            NetworkManager.shared.callRequest(api: .topicImage(slug: topics[i].slug), type: [UnslpashTopic].self) { value in
                self.topicDatas[i] = value
                group.leave()
                
            }    failHandler: { status in
                let msg = Error.errorMsg(satus: status)
                self.showAlert(msg: msg)
                group.leave()
            }
            
            
        }
        
        group.notify(queue: .main) {
            for i in 0..<self.mainView.collectionViews.count
            {
                if self.topicDatas[i].count != 0 {
                    
                    self.mainView.collectionViews[i].reloadData()
                    self.mainView.collectionViews[i].scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
                }
            }
            
        }
        
    }
    
    private func errorMsg(status: Int) {
        
    }
    
}

// MARK: - CollectionView Delegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        //이것도 줄일 수 있네
        
        //        if collectionView.tag == 0 {
        //            return topicDatas[0].count // 결국 같은 건데, 왜 리턴을 따로 했을까 ㅋㅋㅋㅋ
        //        } else if collectionView.tag == 1 {
        //            return topicDatas[1].count
        //        } else if collectionView.tag == 2 {
        //            return topicDatas[2].count
        //        } else {
        //            return 0
        //        }
        
        return topicDatas[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell  else { return UICollectionViewCell() }
        if topicDatas[collectionView.tag].count != 0 {
            cell.setup(data: topicDatas[collectionView.tag][indexPath.item])
        }
        return cell
        
        //        // 이거 줄이자, cell의 section을 들고오면되네
        //        if collectionView.tag == 0 { // 결국 같은 건데, 왜 리턴을 따로 했을까 ㅋㅋㅋㅋ
        //            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell  else { return UICollectionViewCell() }
        //            if topicDatas[0].count != 0 {
        //                cell.setup(data: topicDatas[0][indexPath.item])
        //            }
        //            return cell
        //        } else if  collectionView.tag == 1 {
        //            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
        //            if topicDatas[1].count != 0 {
        //                cell.setup(data: topicDatas[1][indexPath.item])
        //            }
        //            return cell
        //        } else if collectionView.tag == 2 {
        //            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell() }
        //            if topicDatas[2].count != 0 {
        //                cell.setup(data: topicDatas[2][indexPath.item])
        //            }
        //            return cell
        //        } else {
        //            return UICollectionViewCell()
        //        }
        
    }
}

// MARK: - ScrollViewDelegate Delegate
extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        randomTopic()
    }
}

// MARK: - Alert

extension HomeViewController {
    
    private func showAlert(msg: String) {
        let alert = UIAlertController(title: "안내", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        
        alert.addAction(ok)
        present(alert,animated: true)
        
    }
}
