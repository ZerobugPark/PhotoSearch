//
//  SerachViewController.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/17/25.
//

import UIKit

class SerachViewController: UIViewController {

    static let id = "SerachViewController"
    

    
    var searchView = SearchView()
    
    override func loadView() {
        view = searchView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 타이틀에 서치바를 넣을 때에는 base 뷰는 불가능한거 같음
        // 네비게이션은 viewcontroller에 있기 때문에, 추가가 어려움. 상수를 하나 만들어서 갔다 써야 할듯.
        
        navigationItem.searchController = searchView.searchBar
        
        navigationItem.title = "Search PHOTO"
        
        view.backgroundColor = .white
    }
    

  
}
