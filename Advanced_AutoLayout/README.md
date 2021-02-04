# iOS_ToyProject

# Advanced_AutoLayout

지금까지 프로젝트를 진행하면서 오토레이아웃을 꾸역꾸역 잡아봤지만 많이 부족하다 느끼기에 더 공부하도록 한다. 

<img width="300" alt="스크린샷 2021-02-04 오전 12 57 06" src="https://user-images.githubusercontent.com/70695311/106840050-b9c0e280-66e2-11eb-89ad-c48537367e95.png">

* iOS를 공부하며 정말 많이 봤다. 보통 어떤 한 라벨을 뷰에 올려놓는다고 하자.  Vertical 부분 레이아웃은 잡았다고 가정하고 좌우 레이아웃을 조정할 때, 이런 문구를 볼 수 있다. 좌우 constraints를 설정했는데 Fix한게 문제라고 한다. Horizontal Space Constraints의 Relation이 equal이면 안된다는 것이다. 왜 그런지 레이아웃의 일련의 선형방정식을 적용해보자.
    Superview.Trailing = Multiplier * title.Trailing + Constant이다. trailing의 Constant는 0, multiplier 값을 1로 정했다고 하면  Superview.Trailing = title.Trailing이다. 여기서 문제가 titile.Trailing의 값이 라벨의 길이에 따라 달라질 수 있기 때문에 방정식이 성립하지 못할 수 있다. 따라서 라벨을 뷰에 넘어 가지 않게 Superview.Trailing >= title.Trailing로 수정할 필요가 있다는 것이다.

<img width="300" alt="스크린샷 2021-02-04 오전 1 00 06" src="https://user-images.githubusercontent.com/70695311/106846402-255d7c80-66f0-11eb-91e6-d5467bd5379a.png">

* Content Priority Ambiguity. 두개의 내용의 Vertical 우선순위가 모호하다는 것인데 왜 모호하다는 것인지 알아보자. 우선 여기서 두 Label은 우선순위가 같다. 하지만 Label의 텍스트가 추가됨에 따라 공간이 부족하다면 어떻게 될까. 그런 상황에 Compression resistance가 필요하다. 공간이 없어서 줄어들텐데 이때 두 라벨 중 어떤걸 줄어들게 할지 우선순위를 정해줘야한다는 것이다. 따라서 둘 중 하나의 우선순위를 낮추거나 높여야한다. 물론 priority값이 클수록 우선순위가 높다. 

<img width="200" alt="스크린샷 2021-02-04 오전 11 46 48" src="https://user-images.githubusercontent.com/70695311/106847130-a8cb9d80-66f1-11eb-96fe-feae43aa9c2f.png">
<img width="200" alt="스크린샷 2021-02-04 오전 11 47 24" src="https://user-images.githubusercontent.com/70695311/106847140-acf7bb00-66f1-11eb-9b13-39741daef538.png">
<img width="200" alt="스크린샷 2021-02-04 오후 2 11 28" src="https://user-images.githubusercontent.com/70695311/106847743-e11fab80-66f2-11eb-8be5-fa16507bca19.png">


* 이번에는 스크롤 뷰에 대해서 알아보자. 사실 스크롤이 필요한 경우는 컬렉션뷰나 테이블뷰에서 많은 데이터를 가져올 때 밖에 필요성을 못느꼈다. 하지만 막상 시뮬레이터를 실행해보면 스크롤이 자동으로 됐다. 분명히 스크롤 설정을 해줘야할텐데 왜 되는지 궁금하던 찰나 apple developer documentation에서 테이블 뷰와 컬렉션뷰 문서를 공부해봤다. 신기하게도 UITableView와 UICollectionView는 UIScrollView의 subclass라고한다. 아 이래서 자동을 됐다는 것을 알게된 후 이와 별개로 스크롤 뷰를 이용하기 위해 공부해본다. 우선 View Controller의 Simulated Size를 Freeform으로 변경한 후 Height를 원하는 만큼 조정해준다. 이제 스크롤 뷰의 위치를 Constraints를 잡아 조정해준다.  
    Scroll View를 살펴보면 Content Layout Guide은 스크롤 가능한 영역이고 Frame Layout Guide은 스크린 가능한 영역을 조절하는 것이다. 스크롤 뷰 안에 넣을 뷰와 Content Layout Guide의 앵커를 일치시킨다. 또한 높이만 달라질 것이기 때문에  안의 뷰와 스크롤의 Frame Layout Guide를 Equal Width로 하여 폭을 일치 시킨다. 이제 라벨을 스크롤 뷰안의 뷰에 넣고 앵커를 일치시키면 셀프사이징이 가능한 화면을 만들 수 있다.  

<img width="300" alt="스크린샷 2021-02-04 오전 11 55 41" src="https://user-images.githubusercontent.com/70695311/106848233-e7faee00-66f3-11eb-922f-ee2a9dd4c7f5.png">
<img width="300" alt="스크린샷 2021-02-04 오전 11 56 20" src="https://user-images.githubusercontent.com/70695311/106848245-ed583880-66f3-11eb-91a5-eb1507663150.png">

* 여기서의 문제를 보면 수평적인 부분만 봤을 때 leading은 constant는 100으로 잡혀있고 trailing constant는 120으로 잡혀있다. 여기에 추가적으로 뷰의 width 250으로 잡아 총 470의 공간이 필요한데 공간이 부족해서 오류가 생긴다. 이런 경우 오류를 여러가지 방법을 잡을 수 있지만 내가 도형의 폭을 고정해두고 우선순위로서 잡고 싶다면, leading or trailing 중 한쪽을 constraints를 삭제할 수도 있고 우선순위를 낮춰줄 수도 있다. 

<img width="300" alt="스크린샷 2021-02-04 오후 12 04 44" src="https://user-images.githubusercontent.com/70695311/106848762-ebdb4000-66f4-11eb-8a6a-d4a806bdcaa1.png">
<img width="300" alt="스크린샷 2021-02-04 오후 12 04 57" src="https://user-images.githubusercontent.com/70695311/106848770-ee3d9a00-66f4-11eb-85ef-b45cd3ce534f.png">


* 앞서 Compression resistance를 다룬 적이 있는데 이번에는 Hugging을 다뤄본다. Hugging은 공간이 부족한게 아니라 오히려 남아서 당겨져야하는 상황에 누굴 땡길 것이냐는 것이다. 이것도 마찬가지로 두 라벨의 우선순위를 조정하여 한쪽이 나머지 한쪽을 땡길지 조정하면 해결할 수 있다.
