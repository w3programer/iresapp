//
//  URLs.swift
//  Iris
//
//  Created by mahmoudhajar on 2/17/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import Foundation

class URLs {
    
    // main links
    static let main = "http://iris.creativeshare.co/"
    
    static let image = "http://iris.creativeshare.co/storage/"
    
    // Auth
    static let login = main + "api/login"
    
    static let sginUp = main + "api/sgin-up"
    
    static let sginOut = main + "api/logout"
    
    static let updateProfile = main + "api/edit-profile"
    
    
    // products
    
    static let sliderURL = main + "api/ads"
    
    static let allCategories = main + "api/products"
    
    static let categories = main + "api/categories"
    
    static let favorites = main + "api/favorites?token="
    
    static let search = main + "api/search-products?q="
    
    static let offers = main + "api/offers"
    
    static let selectFav = main + "api/favorites"
    
    static let disSelect = main + "api/favorites/"
    
    static let sendOrder = main + "api/orders"
    
    // other
    
    static let terms = main + "api/get-terms-condition"
    
    static let package = main + "api/packages"
    
}

