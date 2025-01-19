//
//  SearchView.swift
//  PhotoSearch
//
//  Created by youngkyun park on 1/18/25.
//

import UIKit

import SnapKit

class SearchView: BaseView {
 
    let searchController = UISearchController()
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    let label = CustomLabel(boldStyle: true, fontSize: 20)
    
    var colorButtons: [CustomButton] = []
    
    let filterButton = CustomButton()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    

    
    override func configureHierarchy() {
        
        addSubview(scrollView)
        addSubview(filterButton)
        scrollView.addSubview(stackView)
        addSubview(collectionView)
        addSubview(label)
       
        
        for i in 0..<ColorEnum.allCases.count  {
            let button = CustomButton(color: ColorEnum.allCases[i].color, tagNum: i)
            let title = ColorEnum.allCases[i].rawValue
            button.setTitle(title, for: .normal)
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
            make.width.equalTo(75)
            make.height.equalTo(25)
            
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom)
            make.horizontalEdges.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        label.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.width.equalTo(180)
            make.height.equalTo(30)
        }
        
        
    }
    
    override func configureView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        
        filterButton.setTitle("관련순", for: .normal)
        
        label.text = "사진을 검색해보세요."

        
    }
    
    
    

    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let deviceWidth = UIScreen.main.bounds.size.width
        let spacing: CGFloat = 4
        let inset: CGFloat = 0
        let objectWidth = (deviceWidth - (spacing + (inset*2))) / 2
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 4
        
        
        layout.itemSize = CGSize(width: objectWidth, height: objectWidth*1.5)
        layout.sectionInset = UIEdgeInsets(top: 2, left: inset, bottom: 0, right: inset)
        

        layout.scrollDirection = .vertical
        
        return layout
    }
    
    
    
    
}

