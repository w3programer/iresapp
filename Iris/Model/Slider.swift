//
//  Slider.swift
//  Iris
//
//  Created by mahmoudhajar on 2/18/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//


/*
"title_ar": "جديد",
"title_en": "new",
"image": "avatars/user.png"
*/


import UIKit
import SwiftyJSON

class Slider: NSObject {

    var  title_ar:String = ""
    var  title_en:String = ""
    var  image: String = ""
    
    
    init?(dict:[String:JSON]) {
    
        guard let photo = dict["image"]?.imagePath, !photo.isEmpty else {return nil}
        self.image = photo
    
        self.title_ar = (dict["title_ar"]?.string)!
        self.title_en = (dict["title_en"]?.string)!
    }
    
    
    
    
    
    
    
}
