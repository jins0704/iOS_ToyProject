# iOS_ToyProject
# goPopUp

![gopopgif](https://user-images.githubusercontent.com/70695311/107182437-147a7700-6a20-11eb-9474-9fedf0e80462.gif)

1. WebKit

* Web 브라우저를 만드는데 기반을 제공하는 오픈소스 응용 framework
   - HTTP 서버와 통신하기 위해 Info.plist에서 App Transport Security Settings -> Allow Arbitrary Loads를 Yes로 추가한다.
   - 프로젝트의 Frameworks, Libraries, and Embedded Content에서 WebKit.framework를 추가한다.

2. Popup

* 커스텀 팝업창을 위해 새로운 스토리보드를 만든다.  현재 메인 뷰 컨트롤러에서는 커스텀 팝업창을 위한 스토리보드를 가져올 수 있다. 또한 
    - let storyboard = UIStoryboard.init(name: "PopUp", bundle: nil) // 팝업 스토리보드 가져오기
    - let popUpVC = storyboard.instantiateViewController(identifier: "PopUpVC") //스토리보드 통해 팝업 컨트롤러 가져오기
    -  popUpVC.modalPresentationStyle = .overCurrentContext //덮어 보여주는 스타일
    - popUpVC.modalTransitionStyle = .crossDissolve //스르르 사라지는 스타일

* 팝업창에서 버튼이 눌렸는지에 대한 정보를 현재 메인 뷰 컨트롤러에서 응답을 받아야하는데 이 부분은 protocol delegate 패턴을 이용한다.
    - popUpVC.popupDelegate = self 로 팝업창의 컨트롤러를 메인 컨트롤러가 쥐었다고 생각한다. 
    - 일종의 리모콘과 같은 형식이라고 생각하고 만약 팝업창의 버튼이 눌린 경우 popupDelegate의 함수를 호출한다.
    - 이것을 메인 컨트롤러에서 반응하여 적절한 행동을 취한다.
