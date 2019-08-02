//
//  PolicyVC.swift
//  Iris
//
//  Created by Ghoost on 5/21/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PolicyVC: UIViewController {

    
    @IBOutlet private weak var text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        if API.isConnectedToInternet() {
            terms()
        }
        
    }
    
    
    private func terms(){
        
        let url = URLs.terms+"\(3)"
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
                let en = json["en"].string
                print(en!)
                if General.CurrentLanguage() == "ar" {
                    self.text.text = ar!
                } else {
                    self.text.text = en!
                }
            }
        }
    }
    

    
}
