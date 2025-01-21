//
//  ShortsViewController.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/21/25.
//

import UIKit

class ShortsViewController: UIViewController {

    static let id = "ShortsViewController"
    
    let shortsView = ShortsView()
    
    var results: [Result] = [] {
        didSet {
            shortsView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        view = shortsView
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
           appearance.configureWithTransparentBackground()
           appearance.backgroundColor = .red
           navigationController?.navigationBar.standardAppearance = appearance
           navigationController?.navigationBar.scrollEdgeAppearance = appearance

        shortsView.tableView.delegate = self
        shortsView.tableView.dataSource = self
        
        shortsView.tableView.register(ShortsTableViewCell.self, forCellReuseIdentifier: ShortsTableViewCell.id)
        shortsView.tableView.rowHeight = UIScreen.main.bounds.size.height
       // loadRandomImage()
    }
    
    private func loadRandomImage() {
        NetworkManager.shared.callRequestRandomImage(api: .randomImgae(count: String(10))) { value in
            self.results = value
            print(self.results[0])
        }
        
    }



}


extension ShortsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  shortsView.tableView.dequeueReusableCell(withIdentifier: ShortsTableViewCell.id, for: indexPath) as? ShortsTableViewCell else {
         
            return UITableViewCell()
        }
        print("나야나")
        cell.mainimageView.backgroundColor = .white
        
        return cell
    }
    
    
}
