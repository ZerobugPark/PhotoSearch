//
//  DetailViewModel.swift
//  PhotoSearch
//
//  Created by youngkyun park on 2/10/25.
//

import Foundation

class DetailViewModel: BaseViewModel {
    
    var resultInfo: Result? //뷰컨에서 받는 데이터
    
    private(set) var input: Input
    private(set) var output: Output
    
    
    struct Input {
        let viewDidLoad: Observable<Void> = Observable(())
    }
    
    struct Output {
        let errorMessage: Observable<String> = Observable("")
        let getinfo: Observable<Info> = Observable(Info())
    }
    
    struct Info {
        var profileImageURL: URL?
        var mainImageURL: URL?
        var userName: String = ""
        var dateLabel: String = ""
        var latestLabel: String = ""
        var descripionTitle: [String] = ["크기", "조회수", "다운로드"]
        var informationLable = "정보"
        var descripionResultLables: [String] = []
    }
    
    
    init() {
        print("DetailViewModel Init")
        input = Input()
        output = Output()
        transform()
        
    }
    
    func transform() {
        input.viewDidLoad.lazyBind { [weak self] _ in
            self?.getUserDeatil()
        }
    }
    
    
    private func getUserDeatil() {
        guard let id = resultInfo?.id else { return }
        
        NetworkManager.shared.callRequest(api: .userDetail(id: id),type: UserDetail.self) { value in
            
            let userDetail = value
            self.loadData(value: userDetail)
        } failHandler: { status in
            let msg = Error.errorMsg(satus: status)
            self.output.errorMessage.value = msg
            
        }
    }
    
    private func loadData(value: UserDetail) {
        
        guard let result = resultInfo else { return }
        var resultData = Info()
        
        resultData.profileImageURL = URL(string: result.user.profile_image.small)
        
        resultData.mainImageURL = URL(string: result.urls.small)
        
        resultData.userName = result.user.name
        resultData.dateLabel = releaseDateString(result.created_at) + " 게시됨"
        resultData.latestLabel =  "(latest: \(releaseDateString(result.updated_at)))"
        let resolution = "\(result.width) X \(result.height)" // 이미지 크기
        resultData.descripionResultLables.append(resolution)
        let views = value.views.total.formatted() // 조회수
        resultData.descripionResultLables.append(views)
        let totalDownload = value.downloads.total.formatted()  // 다운로드
        resultData.descripionResultLables.append(totalDownload)
        
    
        print(resultData)
        output.getinfo.value = resultData
        
        
    }
    
    private func releaseDateString(_ releaseDate: String) -> String {
        // 서버에서 주는 형태 (ISO규약에 따른 문자열 형태)
        // isoDate - Iso 형태의 문자열을 Iso 형태의 날짜 형식으로 변환
        guard let isoDate = ISO8601DateFormatter().date(from: releaseDate) else { return "" }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy. MMM dd"
        let dateString = dateFormatter.string(from: isoDate)
        return dateString
    }
    
    
    deinit {
        print("DetailViewModel Deinit")
    }
    
    
    
    
}
