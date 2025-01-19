//
//  SerachViewController.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/17/25.
//

import UIKit

class SerachViewController: UIViewController {

    static let id = "SerachViewController"
    
    var results: [Result] = []
    var backupResults: [Result] = []
    lazy var getInfo: UnslpashGetImage = UnslpashGetImage(total: 0, total_pages: 0, results: results)
                                                
    var page = 1
    
    let searchView = SearchView()
    
    var buttonStatus: [Bool] = []
    
    var filter: String = "relevant"
    
    override func loadView() {
        view = searchView
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 네비게이션 타이틀에 서치바를 넣을 때에는 base뷰에서 레이아웃 설정은 불가능한거 같음
        // 네비게이션은 viewcontroller에 있기 때문에, 추가가 어려움. 상수를 하나 만들어서 갔다 써야 할듯.
        // UISearchController()로 넣어야함, UISearchBar()는 안됨
        navigationItem.title = "SEARCH PHOTO"
        navigationItem.searchController = searchView.searchController
        
        navigationItem.backButtonTitle = ""
        
        searchView.collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
        
        // 서치 컨트롤러의 서치바를 델리게이트로 연결
        searchView.searchController.searchBar.delegate = self
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.prefetchDataSource = self
        
        colorButtonAddTarget()
        filterButtonAddTarget()
    }
    
    private func colorButtonAddTarget() {
        
        for i in 0..<searchView.colorButtons.count {
            searchView.colorButtons[i].addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
            buttonStatus.append(false)
            
        }
    }
    
    private func filterButtonAddTarget() {
        searchView.filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
    }
    
    @objc private func filterButtonTapped(_ sender: UIButton) {
        
        guard (searchView.searchController.searchBar.text?.count) != 0 else { return }
        changeButtonColor(status: false)
        
        let title = searchView.filterButton.titleLabel?.text == "관련순" ? "최신순" : "관련순"
        searchView.filterButton.setTitle(title, for: .normal)
        filter = filter == "relevant" ? "latest" : "relevant"
        
        NetworkManager.shared.callRequestGetImage(query: searchView.searchController.searchBar.text!, filter: filter, page: page) { value in
           
            self.getInfo = value
            
            if self.getInfo.total == 0 {
                self.searchView.label.text = "검색결과가 없습니다."
                self.searchView.label.isHidden = false
            } else {
                self.searchView.label.isHidden = true
            }
            self.results = self.getInfo.results
            self.searchView.collectionView.reloadData()
        }
        
        
    }
    
    
    @objc private func colorButtonTapped(_ sender: UIButton) {
        
        guard (searchView.searchController.searchBar.text?.count) != 0 else { return }
        
        var color: String = ""
        
        changeButtonColor(tag: sender.tag, status: true)

        if buttonStatus[sender.tag] {
            
            // 검색결과가 있는 상태에서, 색상 버튼을 다시 누르면 처음 검색한 데이터가 보일 수 있도록
            results = backupResults
            searchView.collectionView.reloadData()
            
            searchView.colorButtons[sender.tag].configuration?.baseForegroundColor = .black
            searchView.colorButtons[sender.tag].configuration?.baseBackgroundColor = #colorLiteral(red: 0.9450977445, green: 0.9450982213, blue: 0.9537070394, alpha: 1)
            buttonStatus[sender.tag].toggle()
            
            return
        }
        buttonStatus[sender.tag].toggle()
        
      
            
        switch sender.tag {
        case 0:
            color = "red"
        case 1:
            color = "black"
        case 2:
            color = "white"
        case 3:
            color = "yellow"
        case 4:
            color = "orange"
        case 5:
            color = "purple"
        case 6:
            color = "magenta"
        case 7:
            color = "green"
        case 8:
            color = "teal"
        case 9:
            color = "blue"
        default:
            color = "red"
        }
        
        NetworkManager.shared.callRequestGetImageWithColor(query: searchView.searchController.searchBar.text!, filter: filter, page: page, color: color) { value in
           
            self.getInfo = value
            
            if self.getInfo.total == 0 {
                self.searchView.label.text = "검색결과가 없습니다."
                self.searchView.label.isHidden = false
            } else {
                self.searchView.label.isHidden = true
            }
            self.results = self.getInfo.results
            self.searchView.collectionView.reloadData()
        }
        
       
        
    }
    
    // status: true -> 색상 버튼이 눌림, false: 서치 버튼 클릭 (서치 버튼 클릭시, 모든 버튼 초기화)
    private func changeButtonColor(tag: Int = 0, status: Bool) {
        for i in 0..<searchView.colorButtons.count {
            if i == tag, status {
                searchView.colorButtons[i].configuration?.baseForegroundColor = .white
                searchView.colorButtons[i].configuration?.baseBackgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            } else {
                searchView.colorButtons[i].configuration?.baseForegroundColor = .black
                searchView.colorButtons[i].configuration?.baseBackgroundColor = #colorLiteral(red: 0.9450977445, green: 0.9450982213, blue: 0.9537070394, alpha: 1)
            }
        }
    }
}

// MARK: - CollectionView Delegate
extension SerachViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(data: results[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function,indexPath)
        
        let vc = DetailViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

// MARK: - SearchBar Delegate
extension SerachViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        changeButtonColor(status: false)
        guard let text = searchBar.text  else { return
            
        }
        NetworkManager.shared.callRequestGetImage(query: text, filter: filter,page: page) { value in
            self.getInfo = value
            
            if self.getInfo.total == 0 {
                self.searchView.label.text = "검색결과가 없습니다."
                self.searchView.label.isHidden = false
            } else {
                self.searchView.label.isHidden = true
            }
            self.results = self.getInfo.results
            self.backupResults = self.results
            self.searchView.collectionView.reloadData()
            
        }
        
    }


    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel")
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchView.searchController.searchBar.text = ""
        return true
    }

}

// MARK: - CollectionView Prefetching
extension SerachViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        page += 1
        for item in indexPaths {
            if results.count - 2 == item.item {
                NetworkManager.shared.callRequestGetImage(query: searchView.searchController.searchBar.text!, filter: filter, page: page) { value in
                    self.getInfo = value
                    self.results.append(contentsOf: self.getInfo.results)
                    self.searchView.collectionView.reloadData()
                
                }
            }
        }
    }
    
    
}


