//
//  BirthdayViewController.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/23/25.
//

import UIKit

class BirthdayViewController: UIViewController {

    let datePicker = UIDatePicker()
    var date: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @objc func okButtonTapped() {
        let dateToString = formatDateToString(date: datePicker.date, outputFormat: "yy.MM.dd")
        date?(dateToString)
        navigationController?.popViewController(animated: true)
   
    }
    
    private func configureView() {
        navigationItem.title = "생일"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
        }
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
    }
    
    
    

    private func formatDateToString(date: Date, outputFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: datePicker.date)
    }



}

