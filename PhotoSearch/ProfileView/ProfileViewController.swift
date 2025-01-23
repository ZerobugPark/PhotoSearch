//
//  ProfileViewController.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/23/25.
//

import UIKit

final class ProfileViewController: UIViewController {


    var profileView = ProfileView()
    
    override func loadView() {
        view = profileView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        UserDefaults.standard.set("Login", forKey: "UserStatus")
    }

    @objc func okButtonTapped() {
        print(#function)
    }
    
    func configureNavigationBar() {
        navigationItem.title = "프로필 화면"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "탈퇴하기", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white

    }

}
