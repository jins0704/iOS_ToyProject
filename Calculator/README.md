# iOS_ToyProject

# Calculator

![계산기](https://user-images.githubusercontent.com/70695311/106234378-12ecca00-623c-11eb-801c-baa882645a01.gif)

## What I learned
- Swift Access Level 
    - private : 특정 entity는 선언된 ({}) 괄호 안에서만 사용 가능
    - fileprivate : 특정 entity는 선언된 파일 안에서만 사용 가능
    - internal : default 값, 해당 모듈 전체에서 사용 가능
    - public : 다른 모듈에서 사용 가능, 다른 모듈에서 override, subclass 불가
    - open  : 다른 모듈에서 사용 가능, 다른 모듈에서 override, subclass 가능
    - 선언하려는 entity에 대해 접근 수준에 제한을 명확하게 사용함을써 더욱 안전하게 사용해야겠다.
    
- Struct vs Class
        - 불과 두달 전에 이 둘의 차이를 정리를 해봤지만 최근 여러 토이프로젝트에서 Model 생성 시 struct와 class의 특징을 고려하여 선언하지 않았다. 그저 struct로 선언하고 warning이 떴을 때 mutating 혹은 let -> var로 바꿔주며 오류 해결에 급급했다. 물론 지금까지 해온 프로젝트의 model들을 struct로 선언한 부분에 대해서는 문제가 없다는 것을 안다. 하지만 struct는 상속을 할 수 없다는 점, struct는 stack에 class는 heap에 저장된다는 점을 꼭 기억하며 분명하게 사용해야 할 것이다.   
        
        <img width="300" alt="스크린샷 2021-01-29 오후 2 24 31" src="https://user-images.githubusercontent.com/70695311/106235267-bb4f5e00-623d-11eb-904d-7d5f002653fe.png">

    

## What I need to supplement

-  Swift에서 해당 property에 get, set을 사용할 수 있다. 이렇게 직접적으로 붙이는 방식이 아직 많이 어색하다. JAVA에서도 getter, setter를 공부해봤지만 get, set 뿐만 아니라 didSet, willSet까지 더 다양하다. 이것을 이용하려면 따로 추가적인 storage도 필요하고 직관적으로 생각하기도 힘든데 왜 이런 것을 사용할까? '데이터를 안전하게 보관, 이용하려고 encapsulation한 형태로 쓴다' 까지가 나의 생각이었다. 이번 프로젝트를 통해 사용해보니 구체적으로 property를 private하게 사용하고 property의 값이 유효한 값인지 검증을 통해 할당 되니 안전해 좋다라고 명확히 하였다. 뿐만 아니라 시스템상에서 이용, 전달되는 데이터가 무엇인지 분명해진다. Access level과 더불어 항상 생각하고 이용하도록 노력해야겠다. 
