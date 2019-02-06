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
    
    var data = [["vvvvv","wwww","dddd"],["dwdwd","dwdw","dwd"]]

    
    fileprivate let menuTitls = ["Ended","Current"]
    var selectedArray = [String]()
    var selectedIndex = 0
    var selectedIndexPath =  IndexPath(item: 0, section: 0)
    
    let indicatorView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmProtocls()
         indicatorUIView()
          createSwipGestures()
        
        colectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredVertically)
        selectedArray = data[selectedIndex]
        
        tableView.tableFooterView = UIView()
        
    }
    

    func confirmProtocls() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.colectionView.delegate = self
        self.colectionView.dataSource = self
        
    }
    
    
    func indicatorUIView() {
        
        indicatorView.backgroundColor = .white
        indicatorView.frame = CGRect(x: colectionView.bounds.minX, y: colectionView.bounds.minY, width: colectionView.bounds.width / CGFloat(menuTitls.count), height: 3 )
        colectionView.addSubview(indicatorView)
        
    }
    
    func refreshContent() {
        
        selectedArray = data[selectedIndex]
        let x = colectionView.bounds.width / CGFloat(menuTitls.count) * CGFloat(selectedIndex)
        UIView.animate(withDuration: 0.3) {
            self.indicatorView.frame = CGRect(x: x, y: self.colectionView.bounds.minY, width: self.colectionView.bounds.width / CGFloat(self.menuTitls.count), height: 3 )
        }
        
        tableView.reloadData()

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
        
        cell.title.text = selectedArray[indexPath.row]
        
        return cell
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
        
        return CGSize(width: colectionView.bounds.width / CGFloat(menuTitls.count), height: colectionView.bounds.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.item
        refreshContent()
    }
    
    
}
