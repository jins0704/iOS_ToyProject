# iOS_ToyProject
# API_Project

### 나의 스파게티 코드들... 더 배우고 나아가자!

### 라이브러리 
    - Alamofire
    - SwiftyJSON
    - Toast_Swift
### 사용한 API
    - unsplash

![apialamo](https://user-images.githubusercontent.com/70695311/107909781-536a7880-6f9c-11eb-9e14-956ef5c2457e.gif)

1.  API 처리하기

* Alamofire
    - Alamofire는 무엇인가? 
            - Http 통신을 하기 위해 사용하는 라이브러리
    - 왜 Alamofire를 사용하는가?
            - 이전 프로젝트에서 URLSession을 이용하여 통신을 해봤다. 알아보니 iOS에서 네트워크 통신을 하기 위해 Alamofire를 많이 사용한다고 한다. 간결하고 코드의 길이가 줄어들며 가독성을 향상시키기 위함이라고 한다. Alamofire 역시 URLSession을 기반으로 된 라이브러리이니 한번 사용해보자. 
    
          let url = API.BASE_URL + "search/photos"
            let queryParam = ["query" : userInput, "client_id" : API.CLIENT_ID]

          AF.request(url, method: .get, parameters: queryParam).validate(statusCode: 200..<300).responseJSON { (response) in
                debugPrint(response)
          }
   
   - 1차적으로 Alamofire를 이용하여 네트워크 통신을 하는 코드를 짰다. 우선 API 통신을 위한 url, 데이터 요청을 위한 쿼리의 형태를 설정한다. 그 다음으로 request를 하는 것이다. Alamofire, GET방식으로 데이터는 아까 설정한 쿼리 형태로 request해줘. 다만 200번대 성공시에만 받을거야. 
       
         var urlToCall : URLRequestConvertible?
           
         if let urlConvertible = urlToCall{
                AlamofireManager
                    .shared
                    .session
                    .request(urlConvertible)
                    .validate(statusCode: 200..<401)
                    .responseJSON { (response) in
                        debugPrint(response)
                    }
         }
    
    - 2차 코드를 수정했다.  Alamofire 매니저를 이용하여 조금 더 구체적이고 세분화되게 나만의 DataRequest를 하기 위함이었다. 또한 라우터를 사용하여 공동 패턴으로 네트워크 스택을 구축하도록 하는 것이 가능해졌다. AlamofireManager라는 클래스를 만들어 shared를 통해 singleton을 적용시키고 세션은 interceptors와 monitors를 임의적으로 생성해 추가시킬 수 있어 더 간결한 매니징이 가능해졌다. 하지만 request를 하는 부분에서 경우에 따라 라우터를 수정해야하는 부분이 문제였다. 이후 SearchRouter를 enum으로 따로 만들어 달라지는 api에 따라 내가 원하는 라우터로 받을 수 있는 부분을 AlamofireManager에 추가시켰고 코드에서 확인이 가능하다. 
    
            AlamofireManager.shared.getPhotos(searchTerm: self.userInput!, completion: { result in
            switch result{
                case .success(let fetchedPhotos):
                    self.getPhotos = fetchedPhotos
                    DispatchQueue.main.async {
                        self.myCollectionView.reloadData()
                    }
                case .failure(let error):
                    self.view.makeToast("검색결과가 없습니다.", duration: 1.0, position: .center)
                    print(error.rawValue)
                    }
              })
    
    -  즉 singleton으로 된 AlamofireManager가 있다. 이것의 세션은 내가 적용하는 인터셉터와 이벤트 모니터들로 구성된다. 인터셉터는 서버에 요청을 보낼 때, 중간에 가로채서 어떤 작업을 한 뒤 다시 서버로 보내는 역할이다. func adapt에는 client_id를 넣고 서버로 보낼 수 있게 하였고 func retry 부분으로 실패시 다시 어떤 수행을 할지 적용했다. 이벤트 모니터는 request에 따른 로그를 받도록 했다. URLRequestConvertible는 SearchRouter로 네트워크 스택 구축 시 공통 패턴을 채택할 수 있도록 하여 enum 형태로 원하는 함수로 입력값에 따라 적합한 데이터 request를 할 수 있도록 했다. 

![apinoti](https://user-images.githubusercontent.com/70695311/107909768-4f3e5b00-6f9c-11eb-9029-52363d1a71b3.gif)


2. NotificationCenter - Keyboard

* 모바일앱으로 프론트를 공부하며 이벤트 처리 전달은 수도없이 일어난다. 이벤트 전달을 하는 방법은 크게 completion block closure, protocol delegate, notification center가 있는데 이 중 사용해보지 않은 Notification Center를 이용하여 키보드 이벤트를 처리하기로 했다.

- 우선 NotificationCenter를 이용하려면 등록과 해제를 해줘야한다.
    - func viewWillAppear에서 등록 -  NotificationCenter.default.addObserver
    - func viewWillDisappear에서 해제 -  NotificationCenter.default.removeObserver
    
- 여기서 키보드 이벤트를 처리해야하는 이유는 키보드가 올라올 때 화면을 가리는 경우 때문이다. 이런 경우 키보드와 가장 하단에 있는 UIView의 사이즈를 받아 가리면 뷰의 프레임 y를 값을 수정해주고 키보드가 내려갈 때 원상태로 되돌리도록 한다. 

- 이 밖에 gestureRecognizer를 추가하여 어떤 UIView를 터치했냐에 따라 becomeFirstResponder() , resignFirstResponder() 처럼 포커싱을 주거나 해제를 하여 키보드를 자동적으로 반응하도록 한다. 이것에 따라 NotificationCenter에서 이벤트를 전달받아 특정 func를 수행 할 수 있다. 
![apitoggle](https://user-images.githubusercontent.com/70695311/107909786-55343c00-6f9c-11eb-843c-40d368658a89.gif)

3. Custom Toggle
    
       @IBAction func heartBtnClicked(_ sender: UIButton) {
          animated(btn: heartBtn)
          self.isHeart.toggle()
       }
      
       func animated(btn : UIButton){
          let activatedImage = UIImage(systemName: "heart.fill")?.withTintColor( colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)).withRenderingMode(.alwaysOriginal)
          let normalImage =  UIImage(systemName: "heart")?.withTintColor( colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)).withRenderingMode(.alwaysOriginal)
          
          
          UIView.animate(withDuration: 0.1) {
              //작아지는 애니메이션
              btn.transform = btn.transform.scaledBy(x: 0.5, y: 0.5)
              btn.setImage(self.isHeart ? normalImage : activatedImage, for: .normal)
              
          } completion: { _ in
              
              //원래대로 돌아오기
              UIView.animate(withDuration: 0.1) {
                  btn.transform = CGAffineTransform.identity
              }
          }
       }
    
-  일종의 Swich라고 보면 되고 버튼의 애니메이션 처리를 위해 만들었다. UIView.animate의 animate 처리 부분과 컴플리션 블럭 클로져 부분 두 단계를 통해 만들 수 있었다. 다만 사실 여러 버튼이 생긴다면 코드가 복잡해질 것 같아 따로 Cell Class에서 수행하는 것이 아닌 하트버튼 클래스를 만들고 셀에 적용해보려고 했는데 이 부분은 실패했다.. 아직 데이터 처리에 대한 부분이 많이 미숙한 것을 느꼈다. 최근 여러 프로젝트들을 만들고 있는데 다른 사람들의 프로젝트 코드들을 보면 내 코드들은 너무 스파게티 코드인 것 같다. 반복적으로 코드를 적지말고 오늘 배운 Notification Center, Protocol Delegate 등을 생각하며 코드의 재사용성을 늘려갈 것이다. 






