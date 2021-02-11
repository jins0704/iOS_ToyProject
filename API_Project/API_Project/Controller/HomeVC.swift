//
//  ViewController.swift
//  API_Project
//
//  Created by 홍진석 on 2021/02/09.
//

import UIKit
import Toast_Swift
import Alamofire

class HomeVC: BaseVC, UISearchBarDelegate, UIGestureRecognizerDelegate{

    @IBOutlet weak var searchFilterSegment: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    
    //키보드 탭해서 없애기
    var keyboardDismissTapGesture : UIGestureRecognizer = UIGestureRecognizer(target: self, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        
        self.searchButton.isHidden = true
        // 버튼 둥글게 만들기
        self.searchButton.layer.cornerRadius = 10
        // 검색창 위아래 선 없애기
        self.searchBar.searchBarStyle = .minimal
        
        //제스처 추가
        self.keyboardDismissTapGesture.delegate = self
        self.view.addGestureRecognizer(keyboardDismissTapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.searchBar.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Notification 생성 - Keyboard
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShowHandle(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHideHandle), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Notification 삭제 - keyboard
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardShowHandle(notification : NSNotification){
        
        
        //키보드 사이즈 가져오기
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            
//            print(keyboardSize.height)
//            print(searchButton.frame.origin.y)
//            print(searchButton.frame.height)

            // 키보드에 따라 뷰 올리기
            if keyboardSize.height < searchButton.frame.origin.y{
                let distance = searchButton.frame.origin.y - keyboardSize.height
                
                self.view.frame.origin.y = -distance
            }
        }
    }
    
    @objc func keyboardHideHandle(){
        //뷰 원상태로 되돌리기
        self.view.frame.origin.y = 0
    }
    
    func pushVC(){
        var searchID = ""
        
        switch searchFilterSegment.selectedSegmentIndex {
        case 0:
            searchID = SEGUE_ID.PHOTO_COLLECTION_VC
        case 1:
            searchID = SEGUE_ID.USER_LIST_VC
        default:
            searchID = SEGUE_ID.PHOTO_COLLECTION_VC
        }
        
        self.performSegue(withIdentifier: searchID, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case SEGUE_ID.USER_LIST_VC:
            let nextVC = segue.destination as! UserListVC
            guard let userInput = self.searchBar.text else{return}
            nextVC.vcTitle = "USER : " + userInput
        
        case SEGUE_ID.PHOTO_COLLECTION_VC:
            let nextVC = segue.destination as! PhotoCollectionVC
            guard let userInput = self.searchBar.text else{return}
            nextVC.vcTitle = "PHOTO : " + userInput
        
        default:
            print("default")
        }
    }
    //MARK: - IBAction Methods
    
    @IBAction func searchFilterChanged(_ sender: UISegmentedControl) {
        print("filterchange")
        var searchBarTitle = ""
        
        switch sender.selectedSegmentIndex {
        case 0:
            searchBarTitle = "사진 키워드"
        case 1:
            searchBarTitle = "사용자 키워드"
        default:
            searchBarTitle = "사진 키워드"
        }
        
        self.searchBar.becomeFirstResponder() // 포커싱을 줘서 키보드 올라옴
        //self.searchBar.resignFirstResponder() 포커싱 해제
        self.searchBar.placeholder = searchBarTitle + " 입력"
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        //서치버튼 클릭
        
//        let url = API.BASE_URL + "search/photos"
//        let queryParam = ["query" : userInput, "client_id" : API.CLIENT_ID]
//
//        AF.request(url, method: .get, parameters: queryParam).validate(statusCode: 200..<300).responseJSON { (response) in
//            debugPrint(response)
//        }
        
        guard let userInput = self.searchBar.text else{return}
        
        //var urlToCall : URLRequestConvertible?
        
        switch searchFilterSegment.selectedSegmentIndex {
        case 0:
            //urlToCall = SearchRouter.SearchPhotos(terms: userInput)
            AlamofireManager.shared.getPhotos(searchTerm: userInput, completion: { result in

                switch result{
                case .success(let fetchedPhotos):
                    print(fetchedPhotos.count)
                case .failure(let error):
                    print(error.rawValue)
                }
            })
        case 1 :
            //urlToCall = SearchRouter.SearchUsers(terms: userInput)
            print("users")
        default:
            print("default")
        }
        
//        if let urlConvertible = urlToCall{
//            AlamofireManager
//                .shared
//                .session
//                .request(urlConvertible)
//                .validate(statusCode: 200..<401)
//                .responseJSON { (response) in
//                    debugPrint(response)
//                }
//        }
    
        pushVC()
        searchBar.resignFirstResponder()
    }
    
    //MARK: - SearchBar Methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let userInput = searchBar.text else{return}
        
        if userInput.isEmpty{
            self.view.makeToast("검색어를 입력해주세요", duration: 3.0, position: .center)
        }
        else{
            //서치 클릭
            pushVC()
            searchBar.resignFirstResponder()
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            self.searchButton.isHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.01, execute: {
                //포커싱 해제
                self.searchBar.resignFirstResponder()
            })
        }
        else{
            self.searchButton.isHidden = false
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputTextCount = searchBar.text?.appending(text).count ?? 0
        
        //8자 이하 입력 경고주기
        if inputTextCount >= 8{
                self.view.makeToast("8자 이하로 입력해주세요", duration: 3.0, position: .center)
        }
        
        //8자 이하로만 입력받기
        return inputTextCount<=8
    }
    
    
    //MARK: - Keyboard Methods
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: searchFilterSegment) == true{
            return false
        }
        else if touch.view?.isDescendant(of: searchBar) == true{
            return false
        }
        else if touch.view?.isDescendant(of: searchButton) == true{
            return false
        }
        else{
            view.endEditing(true)
            return true
        }
    }
    
}

