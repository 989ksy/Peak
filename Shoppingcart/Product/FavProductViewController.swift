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
    var codableData: Item? //근데 그냥 비어있는 거 아닌가?
    
    let repository = ShoppingRepository()

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
        navigationController?.navigationBar.barTintColor = .black
        
        tabBarController?.tabBar.barTintColor = .black //탭바


        
    //네비게이션바 좋아요 버튼
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favorietButtonTapped))
        
    }
    
    @objc func favorietButtonTapped (_ sender: UIBarButtonItem) {
        print("==<좋아요 상세페이지>==좋아요버튼 터치")
        
        // 쇼핑데이터(객체에 저장되어 있음.) -> 다시 좋아요 누를 땐 객체 데이터와 비교 어려움
        
        guard let data = shoppingData else { return }

        let realm = try! Realm()
        let isSavedData = realm.objects(Shopping.self).where {
            $0.productId == data.productId
        }
        
        if isSavedData.isEmpty == false {
            
            do {
                try realm.write {
                    realm.delete(isSavedData)
                }
                print("=== 데이터 삭제 성공")
            } catch {
                print("=== 데이터 삭제 실패")
            }
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favorietButtonTapped))
            
            navigationController?.popViewController(animated: true) //임시
            
        } else { //원래 저장해야함. data가..코더블 값이 ..여야하는데 favVC엔 없는게 문제..인듯
            print("상세페이지 문제발생")
            
//            let task = Shopping(productImage: data.productImage, productName: data.productName, storeName: data.storeName, price: data.price, webLink: data.webLink, favorite: true, date: Date(), productId: data.productId)
//                repository.createItem(task)
//
//            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favorietButtonTapped))
//            print ("===상세페이지, 데이터 저장 성공")
            
        }

    }
    
        
        
    
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

