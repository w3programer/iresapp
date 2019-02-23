//
//  TermsVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/19/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TermsVC: UIViewController {

    
    @IBOutlet weak var txtView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        DispatchQueue.main.async {
            self.terms()
        }
        self.txtView.layer.cornerRadius = 10.0
        self.txtView.clipsToBounds = true
    }
    
    func terms(){
        let url = URLs.terms
        Alamofire.request( url , method: .get ).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print("terms",error)
                
            case .success(let value):
                let jsonData = JSON(value)
                print(jsonData)
                let json = jsonData["site_terms_conditions"]
                print(json)
                let ar = json["ar"].string
                print(ar!)
                self.txtView.text = ar!
               }
            }
          }
  

}
