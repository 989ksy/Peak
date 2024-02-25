//
//  ProductViewController.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/23/23.
//

import UIKit
import WebKit
import SnapKit
import RealmSwift

class ProductViewController: BaseViewController, WKUIDelegate {
    
    let dividerLine = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    var webView: WKWebView!
    var sharedData : Item?
    
    let repository = ShoppingRepository()
    
    override func loadView() {
        
        //웹뷰 설정
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션바 세팅
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = ConstantColor.Green
        self.navigationController?.navigationBar.topItem?.title = ""
        
        tabBarController?.tabBar.barTintColor = .white //탭바
        
        self.webView.backgroundColor = .white //웹뷰배경색
        
        guard let data = sharedData else { return }
        
        //제목
        //제목특수문자제거
        let fixedTitle = data.title.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        self.navigationItem.title = "\(fixedTitle)"
        
        print("==== 네비게이션 컨트롤러 타이틀: \(fixedTitle)")
        print("===== 제품이름: \(data.title)")
        
        //웹뷰 기본세팅값
        let myURL = URL(string: "https://msearch.shopping.naver.com/product/\(data.productID)")
        print("===== 제품 아이디: \(data.productID)")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        //네비게이션 버튼 기본세팅_ 저장 안 되어있으면 빈 하트, 되어 있으면 색칠 된 하트
        let realm = try! Realm()
        let isSavedData = realm.objects(Shopping.self).where {
            $0.productId == data.productID}
        
        if isSavedData.isEmpty == true { //Reaml X, 저장하고 필하트
            print("상세페이지 하트 채워짐")
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favorietButtonTapped))
            
            print ("===상세페이지, 데이터 저장 성공")
            
        } else { //Realm O, 삭제하고 빈하트
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favorietButtonTapped))
            
            print ("===상세페이지, 데이터 삭제 성공")
        }
        
        
        
    }
    
    //MARK: - 좋아요 버튼 클릭 시
    
    @objc func favorietButtonTapped (_ sender: UIBarButtonItem) {
        print("==<검색 상세페이지>==좋아요버튼 터치")
        
        //Realm - 하트 정보
        guard let data = sharedData else {return}
        
        let realm = try! Realm()
        let isSavedData = realm.objects(Shopping.self).where {
            $0.productId == data.productID
        }
        
        print("=== 좋아요버튼, 저장된 데이터: \(isSavedData)")
        print("== productID : \(data.productID)")
        
        if isSavedData.isEmpty == true { //Reaml X, 저장하고 필하트
            print("상세페이지 하트 채워짐")
            
            let task = Shopping(productImage: data.image, productName: data.title, storeName: data.mallName, price: data.lprice, webLink: data.link, favorite: true, date: Date(), productId: data.productID)
            
            repository.createItem(task)
            sender.image = UIImage(systemName: "heart.fill")
            
            print ("===상세페이지, 데이터 저장 성공")
            
        } else { //Realm O, 삭제하고 빈하트
            
            let deletingData = realm.objects(Shopping.self).where {
                $0.productId == data.productID }.first
            do {
                try realm.write {
                    realm.delete(deletingData!)
                    print("===상세페이지, 데이터 삭제 성공")
                    sender.image = UIImage(systemName: "heart")
                }
                
            } catch {
                print("===상세페이지, 데이터 삭제 X")
            }
        }
        
        print("버튼 액션 끝!")
        
    }
    
    //MARK: - 웹뷰 설정
    
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
    
    //MARK: - 레이아웃 설정
    
    override func configureView() {
        super.configureView()
        view.addSubview(dividerLine)
    }
    
    override func setConstraints() {
        dividerLine.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    
}
