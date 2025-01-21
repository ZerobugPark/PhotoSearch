//
//  ShortsView.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/21/25.
//

import UIKit

import SnapKit


class ShortsView: BaseView {

   
    let tableView = UITableView(frame: .zero, style: .plain)


    override func configureHierarchy() {
        
        self.addSubview(tableView)
    }
    
    override func configureLayout() {
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
  
    }
    
    override func configureView() {
        //tableView.backgroundColor = .red
     
    }
    
}
