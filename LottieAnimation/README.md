# iOS_ToyProject
# LottieAnimation

![annim1](https://user-images.githubusercontent.com/70695311/106880427-b26bfa00-671f-11eb-9eb8-06180a152f08.gif)

1. LottieAnimation

* JSON 기반의 Adobe After Effects Animation을 분석하여 화면에 애니메이션을 렌더링해주는 라이브러리
다만 애니메이션 뷰를 스토리보드를 이용하지않고 코딩으로 오토레이아웃을 잡아야했다. 
   -  animationView.translatesAutoresizingMaskIntoConstraints = false를 통해 프로그래밍으로 잡을 수 있도록 한다.
   - animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true를 통해 X축의 중앙에 정렬할 수 있도록 한다. 
   - animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true를 통해 Y축의 중앙에 정렬할 수 있도록 한다.
Lottie 애니메이션을 앱의 시작할 때 보여주고 애니메이션이 끝나면 처음 로그인 화면을 보여주는 뷰로 넘어가도록 한다.

![annim2](https://user-images.githubusercontent.com/70695311/106880431-b39d2700-671f-11eb-9bcc-61059d773fa3.gif)

2. AnimiationOptions - Transition

* UIView의 AnimationOptions 중 Transition을 이용해보았다.  사용한 옵션은 transitionFlipFromLeft, transitionFlipFromRight, transitionCurlUp, transitionCurlDown, transitionFlipFromTop, ttransitionFlipFromBottom 총 5가지이다. 현재 프로젝트를 진행 중인데 거기서 필요한 테이블 뷰의 셀을 어떻게 더 좋은 뷰로 보여줄 수 있을까 찾다가 발견했다. 이런게 있다고 외우기보다 지금처럼 계속해서 몰랐던 무엇인가를 찾아나가며 응용해야겠다.
