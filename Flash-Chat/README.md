# iOS_ToyProject

## Flash Chat
![chat1](https://user-images.githubusercontent.com/70695311/105577818-34266400-5dbf-11eb-80c7-cb673d26638c.gif)

*  CLTypingLabel을 이용해 동적인 메인화면 구현
*  Register, Login 두 가지 버튼으로 회원가입, 로그인이 가능하다.
*  회원가입을 위해 이메일과 패스워드를 입력한다.
    - Firebase의 Authentication으로 이용한다.
    - 인증을 위해 이메일 형식을 입력해야만 한다.
    - 인증을 위해 password는 6자리 이상을 입력해야만 한다.
* 회원가입 완료시 채팅창 화면으로 이동한다.

![chat2](https://user-images.githubusercontent.com/70695311/105577821-35f02780-5dbf-11eb-9772-3ec33a8a5847.gif)

* Login 에서는 기존 회원가입한 정보로 로그인이 가능하다.
    - 기존 회원가입 정보는 Firebase의 Authentication의 데이터베이스에 저장된다.
* 로그인을 완료하면 채팅창 화면으로 이동한다.
* 채팅창은 자신과 외부로만 구분된다.
    - Textfield의 메세지 내용과 보낸 사람은 firebase의 Cloud Firestore에 저장된다.
    - 채팅을 보내면 addSnapshotListener에 의해 실시간으로 업데이트된다.
    - querySnapShot?.documents에서 정보를 다시 가져와 화면에 제공한다.
    - order를 이용해 시간 순서로 정렬하여 채팅 내용을 뷰에 제공한다. 

![chat3](https://user-images.githubusercontent.com/70695311/105577823-37215480-5dbf-11eb-9350-a10ffff866f8.gif)

* 오른쪽 상단의 Logout을 이용하여 로그아웃이 가능하다.
* 다른 아이디로 로그인하면 기존의 내용이 외부에서 받은 채팅으로 변경된다.
    - 자신과 외부의 대화 내용을 구분한다. 
    - 같은 cell.xib를 사용하지만 색상, ishidden 등을 사용해 조정한다.
* IQKeyboardManager는 Swift Package Dependency로 이용한다.
    - 키보드의 상태를 IQKeyboardManager를 이용하여 Appdelegate에 기능을 추가할 수 있다.  
    - 키보드가 화면을 가리는 것을 방지하며 키보드 올리기
    - 키보드 외부를 터치하면 키보드 내리기 
    
![chat4](https://user-images.githubusercontent.com/70695311/105577824-38528180-5dbf-11eb-996a-7ffff482b24f.gif)

* 앱 종료 후 다른 아이디로 들어가도 내용은 사라지지 않는다.
    - 회원정보와 메세지 내용은 Firebase를 이용하여 외부에 저장한다.
 
 <img width="600" alt="스크린샷 2021-01-23 오후 8 57 07" src="https://user-images.githubusercontent.com/70695311/105578337-b49a9400-5dc2-11eb-93c1-7b01767aed6f.png">
 <img width="600" alt="스크린샷 2021-01-23 오후 8 57 18" src="https://user-images.githubusercontent.com/70695311/105578338-b7958480-5dc2-11eb-9c74-137beec28ddd.png">

#### What I learned
- Third party libraries 
    - Cocoapods
    - Swift Package Manager
- Firebase
    - store data in the cloud using Firebase Firestore
    - query, sort the database
- .xib 파일을 이용한 커스텀뷰

#### What I need to supplement
- 채팅 내용이 적을 때 Textfield만 키보드에 따라 올라가고 TableView의 내용은 올라가면 안된다. 아직 이 부분을 수정하지 못했다. 
    - 다른 사람들의 키보드 컨트롤 하는 것을 찾아보았는데 보통 Notification을 사용한다. 아직 이 부분을 공부하지 못해 third party libraries를 유용하게 사용하는 것도 좋지만 스스로 더 좋은 뷰를 만들어야겠다.
- Firebase를 이용하여 채팅앱을 만들었다. Firebase를 사용하면 가이드를 통해 비교적 복잡한 부분의 코드를 구현하기 쉽고 cocoapods로 Firebase의 필요한 내용들을 설치하면 되기 때문에 편리하다. 하지만 실제 개발을 할 때는 Firebase 없이 어떻게 서버에서 주는 데이터를 처리할지 고민해야겠다. 인터넷을 보니 소켓을 이용한 부분이 있던데 한번 공부해야겠다.


