//
//  FavProductViewController.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/10.

// 좋아요 상세 페이지(웹뷰 활용)

import UIKit
import WebKit
import SnapKit
import RealmSwift

class FavProductViewController: BaseViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var shoppingData: Shopping? //목록 데이터 그릇
    var bowlData: Item? // codable 그릇
    
//    override func loadView() {
//        super.loadView()
////        view = webView
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let data = shoppingData else { return }
        
    //제목 + 제목특수문자제거
        let fixedTitle = data.productName.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        self.title = "\(fixedTitle)"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white] //타이틀 색상
        
        print("==== 네비게이션 컨트롤러 타이틀: \(fixedTitle)")
        print("===== 제품이름: \(data.productName)")
        
    //기본세팅값
        let myURL = URL(string: "https://msearch.shopping.naver.com/product/\(data.productId)")
        
        print("===== 제품 아이디: \(data.productId)")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    //네비게이션바 세팅
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white

        
    //네비게이션바 좋아요 버튼
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favorietButtonTapped))
        
    }
    
    @objc func favorietButtonTapped (_ sender: UIBarButtonItem) {
        print("==<좋아요 상세페이지>==좋아요버튼 터치")
        
        //        guard let data = bowlData else {return}
        guard let data = shoppingData else {return}
        print("여기서부터 안 나옴?")
        
        //1. 데이터 저장여부 확인
        let realm = try! Realm()
        do {
            try realm.write {
                realm.delete(shoppingData!)
                sender.image = UIImage(systemName: "heart")
            }
        } catch {
            
        }
    }
//
//        let isSavedData = realm.objects(Shopping.self).where{
//            $0.productId == data.productId
//        }
//        print("== 저장 여부 확인함")
//
//        //2. 저장되어 있으면 삭제
//        if isSavedData.isEmpty == true {
//            print("그럴리가 없음")
//        } else {
//            let deletingData = realm.objects(Shopping.self).where{
//                $0.productId == data.productId }.first
//            do{
//                try realm.write{
//                    realm.delete(deletingData!)
//                    print("===<좋아요상세페이지> 데이터 삭제 성공")
//                }
//            } catch {
//                print("===<좋아요상세페이지> 데이터 삭제 실패")
//            }
//        }
//
//        print("버튼 액션 끝~")
//
//    }
    
    override func configureView() {
        super.configureView()
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        
        view.addSubview(webView)
        
    }
    
    override func setConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func reloadButtonclicked() {
        webView.reload()
    }
    
    func goBackButtonClicked() {
        if webView.canGoBack  {
            webView.goBack()
        }
    }
    
    func goForwardButtonClicked() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
}

