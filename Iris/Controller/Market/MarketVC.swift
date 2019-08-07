//
//  ViewController.swift
//  Iris
//
//  Created by mahmoudhajar on 2/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ImageSlideshow
import BBBadgeBarButtonItem
import CoreData

class MarketVC: UIViewController {

    
   
    @IBOutlet weak var transp: CornerButtons!
     @IBOutlet weak var colorLen: CornerButtons!
      @IBOutlet weak var access: CornerButtons!
       @IBOutlet weak var sliderShow: ImageSlideshow!
    
    @IBOutlet weak var mostSoldLabel: UILabel!
     @IBOutlet weak var brandLabel: UILabel!
    
    @IBOutlet weak var bView: UIView!
     @IBOutlet weak var bViw: UIView!
      @IBOutlet weak var brView: UIView!
       @IBOutlet weak var brViw: UIView!
    
    
    @IBOutlet weak var frView: UIView!
     @IBOutlet weak var secView: UIView!
      @IBOutlet weak var thView: UIView!
    
    
    @IBOutlet weak var cartButon: UIBarButtonItem!
   // @IBOutlet weak var cartButon: BBBadgeBarButtonItem!
    
    @IBOutlet weak var headerlogo: UIBarButtonItem!
    
     // Containers Views
    @IBOutlet weak var transView: UIView!
     @IBOutlet weak var colorView: UIView!
      @IBOutlet weak var accessoryView: UIView!
       @IBOutlet weak var brandView: UIView!
    
    
    
    
    
    @IBOutlet weak var buViewHeightConstant: NSLayoutConstraint!
    
    @IBOutlet weak var brandHeightConstant: NSLayoutConstraint!
    
    
    
    // for Pagination
    var currentPage = 1
     var totalPages = 1
      var id = 2
       var transLoad = false
        var colorLoad = false
         var accessLoad = false
   
    
   
     var brandsIdSel = 0
    
       var frSelected = false
        var seSelected = false
         var thSelected = false
    
    
    var imgSource = [InputSource]()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var prod: [ItemsList] = []
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updatecaret()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let preferredLanguage = NSLocale.preferredLanguages[0]
        if preferredLanguage.starts(with: "en"){
            self.headerlogo.imageInsets.right = 140

        } else{
            self.headerlogo.imageInsets.left = 140

        }
        

        setLoca()
          displayElementsDesgin()
        
        slideShow()
         configSliderShow()
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        
        self.colorView.alpha = 1.0
          self.brandView.alpha = 1.0
            self.transView.alpha = 0 
             self.accessoryView.alpha = 0
        

        
        NotificationCenter.default.addObserver(self, selector: #selector(self.update), name: NSNotification.Name(rawValue: "deletedCell"), object: nil)
        
    }
    
    
    @ objc func update(notif: NSNotification) {
        getData()
       // print("cell deleted")
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if id == 1 {
            transCorner()
        } else if id == 2 {
            colCorner()
        } else {
            accCorner()
        }
        if prod.count > 0 {
            cartButon.setBadge(text: "\(prod.count)", withOffsetFromTopRight: .zero, andColor: .red, andFilled: true, andFontSize: 15)
        }else{
            cartButon.setBadge(text: "0", withOffsetFromTopRight: .zero, andColor: .red, andFilled: true, andFontSize: 15)

        }
    }
    
    func updatecaret(){
        if prod.count > 0 {
            cartButon.setBadge(text: "\(prod.count)", withOffsetFromTopRight: .zero, andColor: .red, andFilled: true, andFontSize: 15)
        }else{
            cartButon.setBadge(text: "0", withOffsetFromTopRight: .zero, andColor: .red, andFilled: true, andFontSize: 15)
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData()
        }
    
    @IBAction func searchBtn(_ sender: Any) {
        performSegue(withIdentifier:"SearchSegue", sender: self)
       }
    
    @IBAction func myProBtn(_ sender: Any) {
        performSegue(withIdentifier: "CartSegue", sender: self)
    }
    
    @IBAction func transparentBtn(_ sender: Any) {
        self.transView.alpha = 1.0
        self.colorView.alpha = 0
         self.brandView.alpha = 0
          self.accessoryView.alpha = 0
        self.id = 1
        transCorner()
    }
    
    @IBAction func colorBtn(_ sender: Any) {
        self.colorView.alpha = 1.0
         self.brandView.alpha = 1.0
           self.transView.alpha = 0
            self.accessoryView.alpha = 0
      
        self.id = 2

        colCorner()
    }
    
    @IBAction func accessBtn(_ sender: Any) {
        self.colorView.alpha = 0
         self.brandView.alpha = 0
          self.transView.alpha = 0
            self.accessoryView.alpha = 1.0
        self.id = 3
        accCorner()
    }
    
    
    
    
    @IBAction func unwindToMarket(segue: UIStoryboardSegue) {}
    
    func displayElementsDesgin() {
        
            transp.alignText()
          colorLen.alignText()
         access.alignText()
        bView.cornerView()
         bViw.cornerView()
          brViw.cornerView()
           brView.cornerView()
    }

    func transCorner() {
        self.frView.backgroundColor = UIColor.white
         self.transp.setTitleColor( .black , for: .normal)
        self.secView.backgroundColor = #colorLiteral(red: 0.115710564, green: 0.5438727736, blue: 0.5560589433, alpha: 0.8584150257)
         self.thView.backgroundColor = #colorLiteral(red: 0.115710564, green: 0.5438727736, blue: 0.5560589433, alpha: 0.8584150257)
           self.colorLen.setTitleColor(.white, for: .normal)
            self.access.setTitleColor(.white, for: .normal)
        self.frView.roundSingleConrner([.topLeft, .topRight], [.layerMaxXMinYCorner , .layerMinXMinYCorner], radius: 20.0)
       self.secView.roundSingleConrner([.bottomRight], [.layerMaxXMinYCorner], radius: 20.0)
        self.thView.roundSingleConrner(.bottomRight, .layerMaxXMaxYCorner, radius: 0)
        self.transp.tintColor = UIColor.black
    }
    
    func colCorner() {
        self.secView.backgroundColor = UIColor.white
         self.colorLen.setTitleColor(.black, for: .normal)
        self.frView.backgroundColor = #colorLiteral(red: 0.115710564, green: 0.5438727736, blue: 0.5560589433, alpha: 0.8584150257)
         self.thView.backgroundColor = #colorLiteral(red: 0.115710564, green: 0.5438727736, blue: 0.5560589433, alpha: 0.8584150257)
        
        self.transp.setTitleColor(.white, for: .normal)
         self.access.setTitleColor(.white, for: .normal)
        
        self.secView.roundSingleConrner([.topLeft, .topRight], [.layerMaxXMinYCorner , .layerMinXMinYCorner], radius: 20.0)
                                          // layerMinXMinYCorner
        self.frView.roundSingleConrner(.bottomLeft, .layerMaxXMaxYCorner , radius: 20.0)
                                           // layerMaxXMaxYCorner
        self.thView.roundSingleConrner(.bottomRight, [ .layerMinXMinYCorner ], radius: 20.0)
        
    }
    
    func accCorner() {
        self.thView.backgroundColor = UIColor.white
         self.access.setTitleColor(.black, for: .normal)
        self.frView.backgroundColor = #colorLiteral(red: 0.115710564, green: 0.5438727736, blue: 0.5560589433, alpha: 0.8584150257)
         self.secView.backgroundColor = #colorLiteral(red: 0.115710564, green: 0.5438727736, blue: 0.5560589433, alpha: 0.8584150257)
        self.colorLen.setTitleColor(.white, for: .normal)
        self.transp.setTitleColor(.white, for: .normal)
        self.thView.roundSingleConrner([.topLeft, .topRight], [.layerMaxXMinYCorner , .layerMinXMinYCorner], radius: 20.0)
        self.secView.roundSingleConrner([.bottomLeft], [.layerMinXMaxYCorner], radius: 20.0)
        self.frView.roundSingleConrner([.bottomRight], [.layerMaxXMaxYCorner], radius: 20.0)
    }
    fileprivate func setLoca() {
       // navigationItem.title = General.stringForKey(key: "iris")
        transp.setTitle(General.stringForKey(key: "Pellucid lenses"), for: .normal)
        colorLen.setTitle(General.stringForKey(key: "colorLenses"), for: .normal)
        access.setTitle(General.stringForKey(key: "accessories"), for: .normal)
         brandLabel.text = General.stringForKey(key: "brand")
          mostSoldLabel.text = General.stringForKey(key: "best")
        
        
    }
    func configSliderShow() {
        sliderShow.slideshowInterval = 5.0
        sliderShow.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        sliderShow.contentScaleMode = UIView.ContentMode.scaleAspectFill
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.white
        sliderShow.pageIndicator = pageControl
        sliderShow.activityIndicator = DefaultActivityIndicator()
        sliderShow.activityIndicator = DefaultActivityIndicator(style: .gray , color: nil )
        sliderShow.currentPageChanged = { page in
           // print("current page:", page)
        }
        sliderShow.addSubview(pageControl)
    }

    func slideShow() {
        API.sliderData { (error: Error?, data:[Slider]?) in
            if data != nil {
                for da in data! {
                    self.imgSource.append(KingfisherSource(urlString: da.image)!)
                }
                self.sliderShow.setImageInputs(self.imgSource)
            } else {
              //  print("Slider have no data")
            }
        }
    }
    
    func getData() { //5
        do {
            prod = try context.fetch(ItemsList.fetchRequest())
        }
        catch {
          //  print("Fetching Failed")
        }
    }
   
//    private func setBadge() {
//
//        let lblBadge = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: 15, height: 15))
//        self.lblBadge.backgroundColor = UIColor.red.cgColor
//         self.lblBadge.clipsToBounds = true
//          self.lblBadge.layer.cornerRadius = 7
//           self.lblBadge.textColor = UIColor.white
//            self.lblBadge.font = UIFont.labelFontSize
//             self.lblBadge.textAlignment = .center
//
//
//        }

//        func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            if scrollView.contentOffset.y >= 70 {
//                UIView.animate(withDuration: 2.5) {
//           // self.navigationController?.setNavigationBarHidden(true, animated: true)
//                    self.buViewHeightConstant.constant = 0
//                    self.brandHeightConstant.constant = UIScreen.main.bounds.height
//                    self.view.layoutIfNeeded()
//                }
//            } else  {
//                UIView.animate(withDuration: 2.5) {
//                   // self.navigationController?.setNavigationBarHidden(false, animated: true)
//            self.buViewHeightConstant.constant = 90
//                self.brandHeightConstant.constant =  200
//                    self.view.layoutIfNeeded()
//                }
//            }
//        }
    
    
    
}


