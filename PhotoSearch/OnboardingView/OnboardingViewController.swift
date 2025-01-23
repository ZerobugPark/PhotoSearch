//
//  OnboardingViewController.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/23/25.
//

import UIKit

final class OnboardingViewController: UIViewController {

    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
        }
        button.layer.cornerRadius = 25
        button.backgroundColor = .white
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("시작하기", for: .normal)
        
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    deinit{
        //print("소멸되었습니다.")
    }
    
    @objc private func startButtonTapped(_ sender: UIButton){
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
        
        
        window.rootViewController = TabBarController()
        window.makeKeyAndVisible()
        
    
    }

}
