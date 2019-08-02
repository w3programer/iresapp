//
//  AccessoriesContentVC.swift
//  Iris
//
//  Created by mahmoudhajar on 3/7/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import ImageSlideshow
import CoreData


class AccessoriesContentVC: UIViewController {

    
    @IBOutlet weak var sliderShow: ImageSlideshow!
    @IBOutlet weak var save: CornerButtons!
    @IBOutlet weak var titl: UILabel!
    @IBOutlet weak var contentTv: UITextView!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rs: UILabel!
    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var cardViw: UIView!
    
    
    
    var recImgs = [String]()
     var recTitle = ""
      var recTitle_en = ""
       var recContent = ""
       var recContent_en = ""
      var recContent_ar = ""
     var recBrand_ar = ""
    var recBarnd_en = ""
     var recProdId = 0
    var recPrice:Double = 0.0
        var recImaage = ""

    
    var quantity = 1
    var itemTotalprice = 1
    
    
    var imageSource = [InputSource]()
    
    // Save to coreData
    // 1
    var context:NSManagedObjectContext?
    let appDelegate  = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 2 
        context = appDelegate.persistentContainer.viewContext

        
        if API.isConnectedToInternet() {
            self.configSliderShow()
        }
        
        setData()
        sliderShow.roundView()
   
        loca()
        
        
    }
    
    
    
    @IBAction func plusBtn(_ sender: Any) {
         quantity += 1
        print(quantity)
        num.text = "\(quantity)"
        recPrice = recPrice * 2
    }
    @IBAction func minBtn(_ sender: Any) {
        
        if quantity > 1 {
            quantity -= 1
            print(quantity)
            num.text = "\(quantity)"
            recPrice = recPrice / 2

        }
        
    }
    
    @IBAction func saveToCartBtn(_ sender: Any) {
      

        itemTotalprice = quantity*Int(recPrice)
        
        
         print(itemTotalprice)
        let items = ItemsList(context: context!)
       
        items.orPrice = Double(recPrice)
        
        items.product_id = Int32(recProdId)
           items.total = Double(itemTotalprice)
            items.type = Int32(1)
             items.quantity = Int32(quantity)
              items.product_id = Int32(recProdId)
               items.total = Double(recPrice)
                items.type = Int32(1)
        
            items.name_ar = recTitle
             items.name_en = recTitle_en
              items.img = recImaage
               items.orPrice = recPrice
                items.hasSize = 0
                 items.sameSize = true
        
        do {
            appDelegate.saveContext()
            print("data saved")
            save.isUserInteractionEnabled = false
            ActionSheet()
           // Helper.showSuccess(title: General.stringForKey(key:"sa"))
           }
        
        
        
    }
    
    
    func configSliderShow() {
        
        for da in recImgs {
            self.imageSource.append(KingfisherSource(urlString: da)!)
        }
        
        self.sliderShow.setImageInputs(imageSource)
        
        sliderShow.slideshowInterval = 5.0
        sliderShow.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        sliderShow.contentScaleMode = UIView.ContentMode.scaleAspectFit
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.white
        sliderShow.pageIndicator = pageControl
        
        sliderShow.activityIndicator = DefaultActivityIndicator()
        sliderShow.activityIndicator = DefaultActivityIndicator(style: .gray , color: nil )
        
        sliderShow.currentPageChanged = { page in
            print("current page:", page)
            
            self.sliderShow.addSubview(pageControl)
            
        }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(AdContentVC.didTap))
        sliderShow.addGestureRecognizer(recognizer)
        
        
        sliderShow.addSubview(pageControl)
        
    }
    
    @objc func didTap() {
        let fullScreenController = sliderShow.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    
    func setData() {
        self.price.text = "\(recPrice)"
        
        if General.CurrentLanguage() == "en" {
            self.contentTv.text = recContent_en
            self.brand.text = recBarnd_en
            self.titl.text = recTitle_en
            
            self.contentTv.textAlignment = .left
            self.titl.textAlignment = .left


        } else {
            self.brand.text = recBrand_ar
            self.contentTv.text = recContent_ar
            self.titl.text = recTitle
            self.contentTv.textAlignment = .right
            self.titl.textAlignment = .right
        }
        
        
    }
    
    fileprivate func loca() {
        
        save.setTitle(General.stringForKey(key: "carBu"), for: .normal)
        rs.text = General.stringForKey(key: "rs")
        
        
        
    }
    
    private func ActionSheet() {
        
        let actionSheet = UIAlertController(title: General.stringForKey(key: "su"), message: General.stringForKey(key: "choose"), preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: General.stringForKey(key: "Cancel"), style: .cancel , handler: nil)
        
        let con = UIAlertAction(title: General.stringForKey(key: "ccon"), style: .default) { (action) in
            self.performSegue(withIdentifier: "ccc", sender: self)
        }
        
        
        let pay = UIAlertAction(title: General.stringForKey(key: "buy"), style: .default) { (action) in
            actionSheet.dismiss(animated: true, completion: nil)
        }
        
        
        actionSheet.addAction(con)
        actionSheet.addAction(pay)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }

}
