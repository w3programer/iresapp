//
//  QuestionsVC.swift
//  Iris
//
//  Created by mahmoudhajar on 3/24/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class QuestionsVC: UIViewController {

    
    @IBOutlet weak var tablView: UITableView!
    
    var que = [Question]()
    
    var currentPage = 1
    var lastPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
          setUpTableView()
        if API.isConnectedToInternet() {
            DispatchQueue.main.async {
                self.getQuestions(no: self.currentPage)
            }
        }
        
    }
    

    func setUpTableView() {
        
        tablView.dataSource = self
         tablView.delegate = self
          tablView.rowHeight = UITableView.automaticDimension
    }
    
   fileprivate func getQuestions(no:Int) {
          pagi(num:no)
        API.getQuestions(pageNo: no) { (error:Error?, data:[Question]?) in
            if data != nil {
                self.que.append(contentsOf: data!)
                 self.tablView.reloadData()
                SVProgressHUD.dismiss()
            } else {
                print("question not found ")
            }
        }
    }
    
    
    fileprivate func pagi(num:Int) {
        let url = URLs.ques+"\(num)"
        Alamofire.request( url , method: .get ).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print("pagi",error)
                
            case .success(let value):
                let jsonData = JSON(value)
                print(jsonData)
                let json = jsonData["meta"]
                print(json)
                let last = json["last_page"].int
                print(last!)
                self.lastPage = last!
            }
        }
    }
    
    
    
    

}
extension QuestionsVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return que.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tablView.dequeueReusableCell(withIdentifier: "quesCell", for: indexPath) as! QuestionCell
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        if General.CurrentLanguage() == "ar" {
            
            cell.quesLablel.text = que[indexPath.row].q_ar
             cell.ansLabel.text = que[indexPath.row].a_ar
        } else {
            cell.quesLablel.text = que[indexPath.row].q_en
             cell.ansLabel.text = que[indexPath.row].a_en
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == que.count - 1 {
            if currentPage < lastPage {
               self.currentPage += 1
                getQuestions(no: currentPage)
            }
        }
    }
    
    
    
    
}
