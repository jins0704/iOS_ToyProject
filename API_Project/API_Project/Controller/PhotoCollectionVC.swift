//
//  PhotoCollectionVC.swift
//  API_Project
//
//  Created by 홍진석 on 2021/02/09.
//

import UIKit
import Toast_Swift

class PhotoCollectionVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let flowLayout = UICollectionViewFlowLayout()
    let half : Double  = Double(UIScreen.main.bounds.width/2 - 10)
    
    var getPhotos : Array<Photo> = []
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingFlowlayout()
        
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
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let photo : Photo = self.getPhotos[indexPath.item]
               
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
    
        cell.photoUser.text = photo.username
        
        if let url = URL(string: photo.thumbnial){
                    do{
                        let urldata = try Data(contentsOf: url)
                         cell.photoImg.image = UIImage(data: urldata)
                    }catch{
                        print("data error")
                        print(error)
                    }
                }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

          return CGSize(width: self.view.bounds.width , height: self.view.bounds.height)

      }
    
    func settingFlowlayout(){

               flowLayout.sectionInset = UIEdgeInsets.zero
               flowLayout.minimumLineSpacing = 20
               flowLayout.minimumInteritemSpacing = 10
               flowLayout.itemSize = CGSize(width: half, height: half+70)
               
               self.myCollectionView.collectionViewLayout = flowLayout
        }

/*
    // MARK: - Navigation
     

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
