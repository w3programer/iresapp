//
//  Login.swift
//  Iris
//
//  Created by mahmoudhajar on 2/18/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import Foundation
/*
 {
 "id": 1,
 "name": "m7md",
 "email": "admin@admin.com",
 "email_verified_at": null,
 "avatar": "avatars/user.png",
 "phone": "01111111111",
 "fire_base_token": null,
 "created_at": null,
 "updated_at": null,
 "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xMjcuMC4wLjE6ODAwMFwvYXBpXC9sb2dpbiIsImlhdCI6MTU1MDQwODk5NiwibmJmIjoxNTUwNDA4OTk2LCJqdGkiOiJ1ZGpOU3doOEx6U28wN3BSIiwic3ViIjoxLCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.LHNa-stPA10388kBqGVYN_63hqVd9s2PkfALxGp6ii8"
 }
 */


import UIKit
import SwiftyJSON


class Login: NSObject {
    
    
    var id:Int!
    var name:String = ""
    var email:String = ""
    var avatar:String = ""
    var phone:String = ""
    var token: String = ""
    
    
    init?(dic:[String:JSON]) {
        
        self.id = (dic["id"]?.int)!
        self.name = (dic["name"]?.string)!
        self.email = (dic["mail"]?.string)!
        guard let img = dic["avatar"]?.imagePath, !img.isEmpty else {return nil}
        self.avatar = img
        self.phone = (dic["phone"]?.string)!
        self.token = (dic["token"]?.string)!
        
        
        
    }
    
    
    
}
