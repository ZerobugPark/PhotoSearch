//
//  SearchView.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/18/25.
//

import UIKit

import SnapKit

class SearchView: BaseView {
 
    let searchBar = UISearchController()
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    
    var colorButtons: [CustomButton] = []
    
    let filterButton = CustomButton()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    

    
    override func configureHierarchy() {
        
        addSubview(scrollView)
        addSubview(filterButton)
        scrollView.addSubview(stackView)
        
        let colors:[UIColor] = [.red,.white,.black,.yellow, .green]
        let title:[String] = ["레드dddd","하ddddd얀색","검ddddd은색","노ddddd란색", "ddd초록색"]
        
        for i in 0..<5 {
            let button = CustomButton(color: colors[i], tagNum: i)
            button.setTitle(title[i], for: .normal)
            colorButtons.append(button)
            stackView.addArrangedSubview(colorButtons[i])
        }
      
        
    }
    
    override func configureLayout() {
        
        // 오른쪽 스크롤인데 왜 horizontal이지? 이거 스택뷰에 영향을 받나?
        // 스크롤바는 양방향이 가능하기 때문에, 하위 뷰 크기에 따라 상황이 레이아웃 상황이 바뀜!! 정리해 영균아!!
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(35)
            
        }
        stackView.snp.makeConstraints { make in
            // 스크롤바 내에서 leading을 사용시, trailing도 맞춰야함
            make.leading.equalTo(scrollView).offset(4)
            make.trailing.equalTo(scrollView).inset(80)
            make.centerY.equalTo(scrollView)
        }
        
        filterButton.snp.makeConstraints { make in
            //make.top.equalTo(self.safeAreaLayoutGuide)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
            make.centerY.equalTo(scrollView)
            make.width.equalTo(80)
            make.height.equalTo(25)
            
        }
        
        
    }
    
    override func configureView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        
        filterButton.setTitle("관련순", for: .normal)
        scrollView.backgroundColor = .cyan
        
    }
    
    
    

    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let deviceWidth = UIScreen.main.bounds.size.width
        let spacing: CGFloat = 4
        let inset: CGFloat = 4
        let objectWidth = (deviceWidth - (spacing + (inset*2))) / 2
        
        layout.itemSize = CGSize(width: objectWidth, height: 250)
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        

        layout.scrollDirection = .vertical
        
        return layout
    }
    
    
    
    
}
