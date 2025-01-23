//
//  ShortsViewController.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/21/25.
//

import UIKit
import SnapKit

final class ShortsViewController: UIViewController {
    
    static var id = "ShortsViewController"
    
    
    private var shortsView = ShortsView()
    
    var results: [Result] = [] {
        didSet {
            shortsView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = shortsView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithTransparentBackground()
//        //navigationBarAppearance.configureWithTransparentBackground() //  그림자 제거 후 기존 백그라운드 색상사용
//        UINavigationBar.appearance().isTranslucent = true
//        UINavigationBar.appearance().backgroundColor = .clear
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        UINavigationBar.appearance().shadowImage = UIImage()
//        
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true // 상태바 불투명 or 투명
        //self.navigationController?.view.backgroundColor = .clear // 네비게이션 영역  색상 설정
        //self.navigationController?.navigationBar.backgroundColor = .clear //네비게이션 바 색상 설정
        
        //edgesForExtendedLayout = .top //없어도 댐
        //view.backgroundColor = .clear
        
        navigationItem.backButtonTitle = ""
        
        shortsView.collectionView.delegate = self
        shortsView.collectionView.dataSource = self
        shortsView.collectionView.register(ShortsCollectionViewCell.self, forCellWithReuseIdentifier: ShortsCollectionViewCell.id)
        
        loadRandomImage()
        
    }
    
    
    
    private func loadRandomImage() {
        NetworkManager.shared.callRequest(api: .randomImgae(count: String(10)), type: [Result].self) { value in
            self.results = value
        } failHandler: { status in
            let msg = Error.errorMsg(satus: status)
            self.showAlert(msg: msg)
        }
        
    }
    
}


extension ShortsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortsCollectionViewCell.id, for: indexPath) as? ShortsCollectionViewCell else {
            return UICollectionViewCell()
        }
        //cell.mainimageView.backgroundColor = .red
        cell.setup(data: results[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        vc.resultInfo = results[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

extension ShortsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.size.height - view.safeAreaInsets.bottom
        let width = view.frame.size.width
        
        return CGSize(width: width, height: height)
    }
}


extension ShortsViewController {
    
    private func showAlert(msg: String) {
        let alert = UIAlertController(title: "안내", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        
        alert.addAction(ok)
        present(alert,animated: true)
        
    }
}
