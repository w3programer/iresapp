//
//  AdContentVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/4/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import ImageSlideshow

class AdContentVC: UIViewController {

    @IBOutlet weak var slider: ImageSlideshow!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UITextView!
    
   // @IBOutlet weak var de: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    

   
}
