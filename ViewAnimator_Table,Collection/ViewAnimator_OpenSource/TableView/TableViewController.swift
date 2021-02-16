//
//  TableViewController.swift
//  ViewAnimator_OpenSource
//
//  Created by 홍진석 on 2021/02/15.
//

import UIKit
import ViewAnimator

class TableViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var TableView: UITableView!
    
    let animations = [AnimationType.vector(CGVector(dx: 0, dy: 30))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        TableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tablecell")
        TableView.rowHeight = 50
        
        //헤더 설정
        TableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerView")
        
        //데이터 변경
        newArr = arr
        
        //갱신
        self.TableView.reloadData()
        
        //애니메이션 적용
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
           
            UIView.animate(views: self.TableView.visibleCells,
                           animations: self.animations)
       
        }
        
        //테이블 뷰에 리프레시 컨트롤 달기
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        let boldfont = UIFont.boldSystemFont(ofSize: 20)
        let attributes : [NSAttributedString.Key : Any] = [
            .font : boldfont,
            .foregroundColor : UIColor.init(cgColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        ]
        refreshControl.attributedTitle = NSAttributedString(string : "기다려요~", attributes: attributes)
        
        self.TableView.refreshControl = refreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if TableView.window != nil {
            TableView.superview?.layoutIfNeeded()
        }
    }
    @objc func handleRefresh(sender : AnyObject){
        
        self.newArr.removeAll()
        
        self.TableView.refreshControl?.endRefreshing()
        
        //API 땡겨서 데이터 가져오기
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            //데이터 변경
            self.newArr = self.arr
    
            //UI 갱신
            self.TableView.reloadData()
            //애니메이션 적용
            UIView.animate(views: self.TableView.visibleCells,
                           animations: self.animations,
                           reversed: false,
                           initialAlpha: 0.0, //안보이다
                           finalAlpha: 1.0, //보이게
                           //options: 추가 가능
                           completion: nil)
        }
    }
    // MARK: - IBAction
    
    @IBAction func EditButtonClicked(_ sender: UIBarButtonItem) {
        if self.TableView.isEditing{
            sender.title = "Edit"
            self.TableView.setEditing(false, animated: true)
        }
        else{
            sender.title = "Done"
            self.TableView.setEditing(true, animated: true)
        }
    }
    
    // MARK: - tableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell : TableViewCell = TableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as! TableViewCell
        
        if(newArr.count > 0){
            cell.label.text = self.newArr[indexPath.row]
        }
        
        return cell
    }
    
    // MARK: - tableView Delegate
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.newArr.remove(at: indexPath.row)
            self.arr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)

            completion(true)
        }

        deleteAction.backgroundColor = .red

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])

        configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.arr[sourceIndexPath.row]
           arr.remove(at: sourceIndexPath.row)
           arr.insert(movedObject, at: destinationIndexPath.row)
        //테이블뷰에서는 옮겨짐
        //셀로 이용하는 newArr의 배열은 안바뀜
        //newArr배열의 소스 배열인 arr배열은 바뀜
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView")

        headerView?.textLabel?.text = "Header"
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .red
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.init(50)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Footer"
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        CGFloat.init(30)
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            self.newArr.remove(at: indexPath.row)
//            self.arr.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade) }
//    }
}
