//
//  SearchVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/7/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    
    @IBOutlet weak var searchTxt: ImageInsideTextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var searchTx = ""
    
    var data = ["cidcioc","cnkcks","scnknk"]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmPrortcols()
        
        
    }
    
    
    
    @IBAction func unwindToSearchVC(segue: UIStoryboardSegue) {}


    func confirmPrortcols() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    
    
    
    
    
    

}
extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCell
        
        cell.titleLab.text = data[indexPath.row]
        cell.img.image = UIImage(named: "img.png")
        
        
        cell.favBtn.addTarget(self, action: #selector(favTapped(sender:)), for: .touchUpInside)
        cell.favBtn.setImage(UIImage(named: "li.png"), for: .normal)
        cell.favBtn.setImage(UIImage(named: "lk.png"), for: .selected)
        cell.favBtn.isSelected = false
        
        
        return cell
    }
    
    @objc func favTapped(sender: UIButton) {
        
        if (sender.isSelected) {
            sender.isSelected = false
            
        } else {
            sender.isSelected = true
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth-30)/2
        
        return CGSize.init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SearchContent", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SearchContent" {
          let contnt = segue.destination as? AdContentVC
            contnt?.recPage = "search"
        }
        
    }
    
}
extension SearchVC: UITextFieldDelegate {
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.searchTxt.resignFirstResponder()
       
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTx = self.searchTxt.text!
        print("good,\(searchTx)")
        self.searchTxt.resignFirstResponder()
        
        return true
     }
}
