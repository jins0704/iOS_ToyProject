# iOS_MapsAPI

## Naver Map 
    
 ##### * 초기 설정
    1. pod init 초기화
    2. 대용량 파일을 받기 위해 git-lfs intsall 실행
    3. pod 'NMapsMap' 추가
    4. pod install --repo-update 적용
    5. Info.plist의 Information Property List에 key : NMFClientId value : clientID > 
    6. import NMapsMap
    7. let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
    
##### * Eror case1 : Undefined symbols for architecture x86_64 _objc_class_$ 
    1. 기존 사용중이던 Pods 폴더 제거
    2. pod cache clean NMapsMap 실행
    3. brew install git-lfs 실행
        *Homebrew가 없는 경우 /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 실행
        3-1. brew 설치 후, brew doctor 실행하여 확인
        3-2. brew install git-lfs 실행
        3-3. git-lfs install
    4. 프로젝트 폴더로 이동하여 pod install --repo-update 실행


