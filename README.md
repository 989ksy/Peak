# Peak ⛰️

<img width="100" height="100" src="https://github.com/989ksy/Peak/assets/122261047/332f97cf-8786-498b-8905-37bed77f58e4">
</br>
</br>

**🛒 캠퍼들을 위한 쇼핑 위시리스트 어플리케이션**


## Preview
![peak](https://github.com/989ksy/Peak/assets/122261047/0f5e4edd-d690-4bd1-a21e-1cc7a22fd470)

</br>

## 프로젝트

**개발기간:** 2023년 9월 7일 ~ 2023년 9월 11일

**iOS 최소 지원 버전:** 16.0 

**Package Dependency Manager:** Swift Package Manager


</br>

## 특징

- 네이버 쇼핑 API를 이용한 상품 목록 조회, 상품 검색 및 페이지네이션 기능
- Realm CRUD를 활용한 좋아요 추가/제거 기능 (모든 화면 동기화)
- 데이터베이스에 저장된 좋아요 상품 목록에서 실시간 검색

</br>


## 스택

- `UIKit`, `CodeBase UI`, `AutoLayout`
- `Alamofire`, `Realm`, `Kingfisher`, `SnapKit`
- `WebKit`
- `Repository`

</br>

## 구현기능

- 네이버 쇼핑 API를 통해 받은 상품 데이터를 **Offset-based Pagination** 기반으로 상품 목록 구현
- Realm의 CRUD 기능을 활용하여 **Primary Key**로 설정한 ProductID를 기준으로 상품을 저장 및 삭제
- Realm 비즈니스 로직을 추상화한 **Repository Pattern** 사용으로 코드 중복 최소화
- Kingfisher의 **이미지 캐싱**, **다운샘플링** 기능을 사용하여 **메모리 사용량 개선**
- **WebKit**을 사용하여 네이버 상세 페이지로 **뷰 렌더링**
- **CustomView** 사용으로 통일성 있는 UI 로직 구현

</br>

## 트러블 슈팅

### 1. prepareForReuse
#### [문제사항]

컬렉션뷰를 활용한 화면에서 새로운 데이터를 불러올 때마다 재사용 중인 cell의 좋아요 버튼 이미지가 DB에 저장 유무와 상관없이 선택 되어있는 문제 발생

#### [문제해결]

셀 재사용 시 호출 되는 prepareForReuse 로직을 추가 하고, 내부에 버튼의 이미지 정보를 초기화 로직 구현


``` Swift

override func prepareForReuse() {
super.prepareForReuse()

self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
self.priceLabel.text = nil
self.storeNameLabel.text = nil
self.productNameLabel.text = nil

}
```

</br>

### 2. 이미지 다운샘플링

#### [문제사항]

API를 통해 이미지를 컬렉션뷰에 보여주는 과정에서 화면을 빠르게 스크롤 할때마다 셀 이미지 로딩이 지연됨

#### [문제해결]

Kingfisher에서 제공해주는 이미지 캐싱 기능과 다운샘플링 로직을 통해 이미지 로딩 지연 문제를 해결하며 메모리 사용 최소화

``` Swift
if let imageURL = URL(string: dataImage) {
    cell.productImage.kf.setImage(
        with: imageURL,
        placeholder: UIImage(),
        options: [
            .processor(DownsamplingImageProcessor(
                    size: CGSize(width: 250, height: 250)
                )),
            .scaleFactor(UIScreen.main.scale),
            .cacheOriginalImage
        ])
}
```

</br>


## 회고

* URL Session 기반 라이브러리인 **Alamofire**를 사용해 네이버 쇼핑 API를 이용한 쇼핑 위시리스트 앱을 만들었습니다. 재사용 셀에 이미지 로딩이 지연 되는 문제를 Kingfisher에서 제공해주는 캐싱 기능으로 해결하며, 해당 라이브러리의 장점을 활용하여 메모리 사용을 최적화하여 관리할 수 있었습니다.
* 데이터베이스 Realm을 사용할 때 **Repository Pattern**을 도입하여 코드 중복을 최소화하고 유지 보수에 용이한 로직을 구현했습니다.
* 이번 프로젝트 진행을 하면서 아쉬웠던 점은 사용자의 네트워크 사용과 관련해서 발생할 수 있는 여러 상황에 대한 대응이 미흡했던 점입니다. 이후 진행되는 프로젝트에서는 비행기 모드나 네트워크 연결 불안정과 같은 상황에 유연하게 대응할 수 있는 로직을 네트워크 유무를 감지하는 NWPathMonitor를 학습한 뒤 해당 기능을 통해 구현해 볼 예정입니다.
