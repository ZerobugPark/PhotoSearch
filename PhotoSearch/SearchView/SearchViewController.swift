//
//  SerachViewController.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/17/25.
//

import UIKit

class SearchViewController: UIViewController {

    static let id = "SerachViewController"
    private var results: [Result] = [] {
        didSet {
            self.searchView.collectionView.reloadData()
        }
    }
    private var backupResults: [Result] = []
    
    private lazy var getInfo: UnslpashGetImage = UnslpashGetImage(total: 0, total_pages: 0, results: results)
                                                
    private var page = 1
    
    private var searchView = SearchView()
    
    private var filter: String = "relevant"
    
    private var colorFilter: String = ""
    private var previousButtonTag: Int?
    
    private var searchText = ""
    
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
        
        // 서치바 네비게이션 컨트롤러 영역 미침범
        searchView.searchController.hidesNavigationBarDuringPresentation = false
        buttonAddTarget()
    
        searchView.searchController.searchBar.setShowsCancelButton(false, animated: false)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchView.searchController.searchBar.becomeFirstResponder()
    }
    
    
    
    private func buttonAddTarget() {
        
        for i in 0..<searchView.colorButtons.count {
            searchView.colorButtons[i].addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
        }
        searchView.filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
    }
    

    @objc private func filterButtonTapped(_ sender: UIButton) {
    
        guard !searchText.isEmpty else { return }
       
        page = 1 // 페이지 초기화
        
        
        let title = searchView.filterButton.titleLabel?.text == "관련순" ? "최신순" : "관련순"
        searchView.filterButton.setTitle(title, for: .normal)
        filter = filter == "relevant" ? "latest" : "relevant"
       
        var api: UnsplashRequest
        
        if previousButtonTag != nil {
            api = UnsplashRequest.searchImageWithColor(query: searchText, filter: filter, page: String(page), color: colorFilter)
        } else {
            api = UnsplashRequest.searchImage(query: searchText, filter: filter, page: String(page))
        }
            
        
        NetworkManager.shared.callRequest(api: api, type: UnslpashGetImage.self) { value in
           
            self.getInfo = value
            
            if self.getInfo.total == 0, self.getInfo.results.isEmpty {
                self.searchView.label.text = "검색결과가 없습니다."
                self.searchView.label.isHidden = false
            } else {
                self.searchView.label.isHidden = true
            }
            self.results = self.getInfo.results
            
            if self.getInfo.total > 0, !self.getInfo.results.isEmpty {
                self.searchView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            
        } failHandler: { status in
            let msg = Error.errorMsg(satus: status)
            self.showAlert(msg: msg)
        }
        
        
    }
    
    
    
    @objc private func colorButtonTapped(_ sender: UIButton) {
        
        guard !searchText.isEmpty else { return }
        
        page = 1 // 페이지 초기화
  
        
        changeButtonColor(tag: sender.tag, status: true)
        
        if previousButtonTag == sender.tag {
            
            // 검색결과가 있는 상태에서, 색상 버튼을 다시 누르면 처음 검색한 데이터가 보일 수 있도록
            results = backupResults
            searchView.collectionView.reloadData()
            searchView.label.isHidden = true
            searchView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            
            searchView.colorButtons[sender.tag].configuration?.baseForegroundColor = .black
            searchView.colorButtons[sender.tag].configuration?.baseBackgroundColor = #colorLiteral(red: 0.9450977445, green: 0.9450982213, blue: 0.9537070394, alpha: 1)
            previousButtonTag = nil
            return
        }

        
        switch sender.tag {
        case 0: colorFilter = "red"
        case 1: colorFilter = "black"
        case 2: colorFilter = "white"
        case 3: colorFilter = "yellow"
        case 4: colorFilter = "orange"
        case 5: colorFilter = "purple"
        case 6: colorFilter = "magenta"
        case 7: colorFilter = "green"
        case 8: colorFilter = "teal"
        case 9: colorFilter = "blue"
        default: colorFilter = "red"
        }

        NetworkManager.shared.callRequest(api: .searchImageWithColor(query: searchText, filter: filter, page: String(page), color: colorFilter), type: UnslpashGetImage.self ) { value in
           
            self.getInfo = value
            
            if self.getInfo.total == 0, self.getInfo.results.isEmpty {
                self.searchView.label.text = "검색결과가 없습니다."
                self.searchView.label.isHidden = false
            } else {
                self.searchView.label.isHidden = true
            }
            self.results = self.getInfo.results
            
            if self.getInfo.total > 0, !self.getInfo.results.isEmpty {
                self.searchView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            
        } failHandler: { status in
            let msg = Error.errorMsg(satus: status)
            self.showAlert(msg: msg)
        }
        previousButtonTag = sender.tag
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
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
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
        
        
        let vc = DetailViewController()
        vc.resultInfo = results[indexPath.item]
        navigationController?.pushViewController(vc, animated: false)
    }
    
    
}

// MARK: - SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        changeButtonColor(status: false)
        results.removeAll()
        filter =  "relevant"
        searchView.collectionView.reloadData()
        
        guard let text = searchBar.text?.replacingOccurrences(of: " ", with: ""), !text.isEmpty  else {
            let msg = "1글자 이상의 검색어를 입력해주세요."
            showAlert(msg: msg)
            // 서치바 원상태로 복귀
            searchView.searchController.isActive = false
            return
        }
        
        searchText = text
        page = 1
        
        NetworkManager.shared.callRequest(api: .searchImage(query: searchText, filter: filter, page: String(page)), type: UnslpashGetImage.self) { value in
           
            self.getInfo = value
             
            if self.getInfo.total == 0, self.getInfo.results.isEmpty {
                self.searchView.label.text = "검색결과가 없습니다."
                self.searchView.label.isHidden = false
            } else {
                self.searchView.label.isHidden = true
            }
            self.results = self.getInfo.results
            self.backupResults = self.results
            
            if self.getInfo.total > 0, !self.getInfo.results.isEmpty {
                self.searchView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        } failHandler: { status in
            let msg = Error.errorMsg(satus: status)
            self.showAlert(msg: msg)
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        results.removeAll()
        searchView.collectionView.reloadData()
        self.searchView.label.text = "사진을 검색해보세요."
        self.searchView.label.isHidden = false
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchView.searchController.searchBar.text = ""
        return true
    }

}

// MARK: - CollectionView Prefetching
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
     
        if page > getInfo.total_pages {
            return
        }
        for item in indexPaths {
            if results.count - 2 == item.item {
                if previousButtonTag != nil {
                    NetworkManager.shared.callRequest(api: .searchImageWithColor(query: searchText, filter: filter, page: String(page), color: colorFilter), type: UnslpashGetImage.self) { value in
                        self.getInfo = value
                        self.results = self.getInfo.results
                        self.page += 1
                    } failHandler: { status in
                        let msg = Error.errorMsg(satus: status)
                        self.showAlert(msg: msg)
                    }
                 
                } else {
                    NetworkManager.shared.callRequest(api: .searchImage(query: searchText, filter: filter, page: String(page)), type: UnslpashGetImage.self){ value in
                        self.getInfo = value
                        self.results.append(contentsOf: self.getInfo.results)
                        self.page += 1
                    
                    } failHandler: { status in
                        let msg = Error.errorMsg(satus: status)
                        self.showAlert(msg: msg)
                    }
                }
            }
        }
    }
}


extension SearchViewController {
    
    private func showAlert(msg: String) {
        let alert = UIAlertController(title: "안내", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        
        alert.addAction(ok)
        present(alert,animated: true)
        
    }
}
