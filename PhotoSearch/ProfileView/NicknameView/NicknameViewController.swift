//
//  NicknameViewController.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/23/25.
//

import UIKit

class NicknameViewController: UIViewController {

    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        textField.becomeFirstResponder()
    }
    
    @objc func okButtonTapped() {
        
        guard let text = textField.text else {
            let msg = "닉네임을 입력해주세요"
            showAlert(msg: msg)
            return
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("Nickname"), object: nil, userInfo: ["nickname": text])
        
        navigationController?.popViewController(animated: true)
    }
    
    func configureView() {
        navigationItem.title = "닉네임"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        textField.placeholder = "닉네임을 입력해주세요"
    }

}

extension NicknameViewController {
    
    private func showAlert(msg: String) {
        let alert = UIAlertController(title: "안내", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        
        alert.addAction(ok)
        present(alert,animated: true)
        
    }
}
