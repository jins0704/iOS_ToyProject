//
//  CollectionViewController.swift
//  ViewAnimator_OpenSource
//
//  Created by 홍진석 on 2021/02/15.
//

import UIKit

class CollectionViewController: CommonViewController, UICollectionViewDelegate,UICollectionViewDataSource, CellDelegate{

    @IBOutlet weak var CollectionView: UICollectionView!
    
    let flowLayout = UICollectionViewFlowLayout()
    let half : Double  = Double(UIScreen.main.bounds.width/2 - 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingFlowlayout()
        
        CollectionView.dataSource = self
        CollectionView.delegate = self
        CollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
    
        //갱신
        self.CollectionView.reloadData()
    
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        self.CollectionView.refreshControl = refreshControl
    }
    
    @objc func handleRefresh(sender : AnyObject){
        
        self.newArr.removeAll()
        
        self.CollectionView.refreshControl?.endRefreshing()
        
        //API 땡겨서 데이터 가져오기
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            //데이터 변경
            self.newArr = self.arr
    
            //UI 갱신
            self.CollectionView.reloadData()
      
        }
    }
    
    func settingFlowlayout(){
        
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        
        flowLayout.itemSize = CGSize(width: half, height: half)
        
        self.CollectionView.collectionViewLayout = flowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell : CollectionViewCell = CollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else{
            return UICollectionViewCell()
        }
        
        cell.label.text = self.arr[indexPath.row].num
        
        //cell.delegate = self
        return cell
    }
    
    func clickHeart(for index: Int, like: Bool) {
        //newArr[index].like = like
        //arr[index].like = like
    }

}
