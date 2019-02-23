//
//  MyOrders.swift
//  Iris
//
//  Created by mahmoudhajar on 2/5/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class MyOrders: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var colectionView: UICollectionView!
    
   // var data = [["vvvvv","wwww","dddd","dddd","dddd","dddd","dddd","dddd"],["dwdwd","dwdw","dwd","dddd","dddd","dddd","dddd","dddd","dddd","dddd"],["dwdwd","dwdw","dwd","dddd","dddd","dddd","dddd","dddd","dddd","dddd"]]

    var data = [[MyOrder](),[MyOrder](),[MyOrder]()]
    fileprivate let menuTitls = [ "old" ,"Current","New"]
    var selectedArray = [MyOrder]()
    var selectedIndex = 0
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    var indicatorView = UIView()
    let indicatorHeight : CGFloat = 3
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmProtocls()
         indicatorUIView()
          createSwipGestures()
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")

        colectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredVertically)
        selectedArray = data[selectedIndex]
        //selectedArray[selectedIndex]
        //tableView.tableFooterView = UIView()
        
        self.tabBarController?.tabBar.items?[2].title = General.stringForKey(key: "myor")

        if Helper.checkToken() == true {
            allOrders(type:"old")
        } else {
            
        }
    }
    

    func confirmProtocls() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.colectionView.delegate = self
        self.colectionView.dataSource = self
        
    }
    
    
    func indicatorUIView() {
        
        indicatorView.backgroundColor = .white
        indicatorView.frame = CGRect(x: colectionView.bounds.minX, y: colectionView.bounds.maxY - indicatorHeight, width: colectionView.bounds.width / CGFloat(menuTitls.count), height: indicatorHeight)
        colectionView.addSubview(indicatorView)
        
    }
    
    func refreshContent() {
        if selectedIndex == 0 {
            allOrders(type: "old")
        } else if selectedIndex == 1 {
            allOrders(type: "current")
        } else {
            allOrders(type: "new")
        }
//        selectedArray = data[selectedIndex]
//        tableView.reloadData()
        let x = (colectionView.bounds.width / CGFloat(menuTitls.count)) * CGFloat(selectedIndex)
        UIView.animate(withDuration: 0.3) {
            self.indicatorView.frame = CGRect(x: x, y: self.colectionView.bounds.maxY - self.indicatorHeight, width: self.colectionView.bounds.width / CGFloat(self.menuTitls.count), height: self.indicatorHeight)
        }
        

    }
    
    func createSwipGestures() {
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipAction))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipAction))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func swipAction(sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            if selectedIndex < menuTitls.count - 1 {
                selectedIndex += 1
            }
        } else {
            if selectedIndex > 0 {
                selectedIndex -= 1
            }
        }
        selectedIndexPath = IndexPath(item: selectedIndex, section: 0)
        colectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredVertically)
        refreshContent()
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 100 {
            UIView.animate(withDuration: 2.5) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
            }
        } else {
            UIView.animate(withDuration: 2.5) {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
    }
    
    
    
    
    func allOrders(type:String) {
        API.getMyOrders(type:type) { (error:Error?, data:[MyOrder]?) in
            if data != nil {
                print("my order data",data!)
            } else {
                print("empty data")
            }
        }
    }
    
    
}
extension MyOrders: UITableViewDataSource , UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyOrderTableViewCell
        
        if selectedIndex == 0 {
            cell.img.image = UIImage(named: "dont.png")
        } else {
            cell.img.image = UIImage(named: "do.png")
        }
        
        //cell.title.text = "\(selectedArray[indexPath.row].total)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
extension MyOrders: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = colectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyOrderCollectionViewCell
        
        cell.setupCell(text: menuTitls[indexPath.item])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 3 , height: colectionView.bounds.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.item
        refreshContent()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
}
