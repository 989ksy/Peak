//
//  ProductViewController.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/09.

// 검색 상세 페이지(웹뷰 활용)

import UIKit
import WebKit
import RealmSwift

class ProductViewController: BaseViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var sharedData : Item?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.backgroundColor = .black
        
        guard let data = sharedData else { return }
        
    //제목
    //제목특수문자제거
        let fixedTitle = data.title.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        self.navigationItem.title = "\(fixedTitle)"
        
        print("==== 네비게이션 컨트롤러 타이틀: \(fixedTitle)")
        print("===== 제품이름: \(data.title)")
        
    //기본세팅값
        let myURL = URL(string: "https://msearch.shopping.naver.com/product/\(data.productID)")
        
        print("===== 제품 아이디: \(data.productID)")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    //네비게이션바 세팅 (을 하면 왜 네비게이션 제목 안보임?)
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .black
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.tintColor = .white
        }
        
        
    //네비게이션바 좋아요 버튼
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favorietButtonTapped))
    }
    
    @objc func favorietButtonTapped () {
        print("검색 상세페이지 좋아요버튼 터치")
        
        //Realm - 하트 정보
        
        guard let data = sharedData else {return}
        
        let realm = try! Realm()
        let isSavedData = realm.objects(Shopping.self).where {
            $0.productId == data.productID
        }
        
        if isSavedData.isEmpty == true {
            print("상세페이지 하트 채워짐")
        } else {
            print("상세페이지 하트 비워짐")
        }
        
    }
    
    override func configureView() {
        super.configureView()
    }
    
    override func setConstraints() {}
    
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
