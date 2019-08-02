//
//  AdContentVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/4/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import ImageSlideshow
import Alamofire
import SwiftyJSON
import CoreData

class AdContentVC: UIViewController {

    @IBOutlet weak var slider: ImageSlideshow!
     @IBOutlet weak var titleLabel: UILabel!
      @IBOutlet weak var contentTxtView: UITextView!
       @IBOutlet weak var mainView: UIView!
        @IBOutlet weak var checkB: CornerButtons!
        @IBOutlet weak var mainNumLabel: UILabel!
       @IBOutlet weak var rightNumLabel: UILabel!
      @IBOutlet weak var leftNumLab: UILabel!
     @IBOutlet weak var secView: SpringView!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var myopiaLab: UILabel!
     @IBOutlet weak var devitaionLab: UILabel!
      @IBOutlet weak var axisLab: UILabel!
       @IBOutlet weak var numberLab: UILabel!
        @IBOutlet weak var myopiaLabel: UILabel!
        @IBOutlet weak var devitainLabel: UILabel!
       @IBOutlet weak var axisLabel: UILabel!
      @IBOutlet weak var numberLabel: UILabel!
     @IBOutlet weak var rightEyeLab: UILabel!
    @IBOutlet weak var leftEyeLab: UILabel!
     @IBOutlet weak var medicalLab: UILabel!
      @IBOutlet weak var cartBut: CornerButtons!
       @IBOutlet weak var brandNameLabel: UILabel!
       @IBOutlet weak var priceLab: UILabel!
      @IBOutlet weak var amountLabel: UILabel!
     @IBOutlet weak var rsLabel: UILabel!
    
    
    
   // same sizes for eyes
    @IBOutlet weak var myoTF: ImageInsideTextField!
     @IBOutlet weak var devTF: ImageInsideTextField!
      @IBOutlet weak var axTF: ImageInsideTextField!
    
    
    @IBOutlet weak var sameView: SpringView!
    // not same size
    // Right
    @IBOutlet weak var righMyotTF: ImageInsideTextField!
     @IBOutlet weak var rightDevTF: ImageInsideTextField!
      @IBOutlet weak var rightAxTF: ImageInsideTextField!
    // Left
     @IBOutlet weak var leftMyoTF: ImageInsideTextField!
      @IBOutlet weak var leftDevTF: ImageInsideTextField!
        @IBOutlet weak var leftAxTF: ImageInsideTextField!
    @IBOutlet weak var nmViw: CardView!
     @IBOutlet weak var numViiw: CardView!
    // ThirdView in case same selection size
    @IBOutlet weak var thirdView: CardView!
     @IBOutlet weak var thNumLabel: UILabel!
      @IBOutlet weak var thNumLab: UILabel!
    var axData:[String] = []
      var devData:[String] = []
       var myoData:[String] = []
    var recPage = ""
     var newHieght:CGFloat = 0.0
      var imgSource = [InputSource]()
    
    // recieve product data
    var recImgs = [String]()
     var recTitle = ""
      var recTitle_en = ""
       var recContent = ""
        var recContentEn = ""
         var recProdId = 0
          var recBrandAr = ""
           var recBrandEn = ""
            var recPrice:Double = 0.0
             var recHasSize = 0
              var recImaage = ""
             var recAx:[String] = []
            var recDev:[String] = []
           var recMyop:[String] = []
         var left_degree:Double = 0.0
        var right_degree:Double = 0.0
       var left_amount  = 1
      var right_amount  = 1
     var similar = 0 // not the same size
    var package = 0
     var quantity = 1
      var itemTotalprice = 1
       var totalPro = 1
        var sizes:[Int] = []
    
    
    // MARK:- value for non medical care
        var mainMyoDegree = ""
         var mainDevDegree = ""
          var mainAxDegree = ""
           var mainBoxNum = "1"
    
    // Mark:- value for medical care
         var rightMyoDegree = ""
          var leftMyoDegree = ""
    
           var rightDevDegree = ""
            var leftDevDegree = ""
    
             var rightAxDegree = ""
              var leftAxDegree = ""
    
              var rightBoxNum = "1"
               var leftBoxNum = "1"
    
    
    ///Mark Selected same size
    
             var thirdBoxNum = 1
    
    
                var mainNumb = 1
    
    
   static var selNotSameSize = true
    
    
//       var dd =  AccessoriesContentVC.arr
//    let defaults = UserDefaults.standard

    
    var selectedSameSize:Bool?

    var buttonSwitched : Bool = false

    var context:NSManagedObjectContext?
    let appDelegate  = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            secView.alpha = 0
             thirdView.alpha = 0
        
        context = appDelegate.persistentContainer.viewContext
        navigationItem.title = General.stringForKey(key: "details")
        
          setDesgin()
           displayData()
            confgPickerView()
           configSliderShow()
              setPrortcols()
        dynamicViewControllerHieght()
        
       
        setLoca()
        
    checkArrayData()
      
         NotificationCenter.default.addObserver(self, selector: #selector(self.sam), name: NSNotification.Name(rawValue: "sam"), object: nil)
        
    }
    @ objc func sam(notif: NSNotification) {
//        if recAx.isEmpty && recDev.isEmpty && recMyop.isEmpty == false {
//
//        guard let axR = rightAxTF.text, !axR.isEmpty,
//               let axL = leftAxTF.text, !axL.isEmpty,
//                let devR = rightDevTF.text, !devR.isEmpty,
//                 let devL = leftDevTF.text, !devL.isEmpty,
//                   let ri = righMyotTF.text, !ri.isEmpty,
//                     let le = leftMyoTF.text, !le.isEmpty else {return}
//
//
//            if axR == axL && devR == devL && ri == le {
//                self.selectedSameSize = true
//                                self.numViiw.alpha = 0
//                                 self.numViiw.alpha = 0
//                                  self.numberLabel.alpha = 0
//                                   self.thirdView.alpha = 1.0
//            } else {
//                self.selectedSameSize = false
//                                 self.thirdView.alpha = 0
//                                  self.numberLab.alpha = 1.0
//                                   self.numViiw.alpha = 1.0
//            }
//
//
//        }
        
        
        
//        if recAx.isEmpty == false {
//            guard let axR = rightAxTF.text, !axR.isEmpty,
//               let axL = leftAxTF.text, !axL.isEmpty else {return}
//            if axR == axL {
//                if recDev.isEmpty == false {
//                guard let devR = rightDevTF.text, !devR.isEmpty,
//                  let devL = leftDevTF.text, !devL.isEmpty else {return}
//                    if devR == devL {
//                        if recMyop.isEmpty {
//               guard let ri = righMyotTF.text, !ri.isEmpty,
//                let le = leftMyoTF.text, !le.isEmpty else  {return}
//                            if ri == le {
//                                self.numViiw.alpha = 0
//                                  self.numViiw.alpha = 0
//                                    self.numberLabel.alpha = 0
//                                      self.thirdView.alpha = 1.0
//                            } else {
//                                self.selectedSameSize = false
//                                    self.thirdView.alpha = 0
//                                     self.numberLab.alpha = 1.0
//                                      self.numViiw.alpha = 1.0
//                            }
//                        }
//                    }
//                }
//            }
//
//
//        }
//
       
        

//        if recDev.isEmpty == false {
//           guard let devR = rightDevTF.text, !devR.isEmpty,
//            let devL = leftDevTF.text, !devL.isEmpty else {return}
//             if rightDevTF.text! ==  leftDevTF.text!{
//                self.selectedSameSize = true
//                  self.numViiw.alpha = 0
//                    self.numViiw.alpha = 0
//                     self.numberLabel.alpha = 0
//                      self.thirdView.alpha = 1.0
//                       print("cooo 3")
//            } else {
//                self.selectedSameSize = false
//                 self.thirdView.alpha = 0
//                  self.numberLab.alpha = 1.0
//                   self.numViiw.alpha = 1.0
//                    print("cooo 33")
//                }
//             }
//
//        if recMyop.isEmpty == false {
//           guard let ri = righMyotTF.text, !ri.isEmpty,
//            let le = leftMyoTF.text, !le.isEmpty else { return}
//
//             if righMyotTF.text! == leftMyoTF.text!  {
//                 self.selectedSameSize = true
//                    self.numViiw.alpha = 0
//                     self.numViiw.alpha = 0
//                      self.numberLabel.alpha = 0
//                       self.thirdView.alpha = 1.0
//                         print("cooo 2")
//            } else {
//              self.selectedSameSize = false
//               self.thirdView.alpha = 0
//                self.numberLab.alpha = 1.0
//                 self.numViiw.alpha = 1.0
//                print("cooo 22")
//            }
//
//        }
//
//        if recAx.isEmpty == false {
//
//           guard let axR = rightAxTF.text, !axR.isEmpty,
//                   let axL = leftAxTF.text, !axL.isEmpty else { return }
//
//            if rightAxTF.text! == leftAxTF.text!  {
//                self.selectedSameSize = true
//                self.numViiw.alpha = 0
//                self.numViiw.alpha = 0
//                self.numberLabel.alpha = 0
//                self.thirdView.alpha = 1.0
//                print("cooo 1")
//            } else {
//                self.selectedSameSize = false
//                self.thirdView.alpha = 0
//                self.numberLab.alpha = 1.0
//                self.numViiw.alpha = 1.0
//                print("cooo 11")
//            }
//
//
//        }
//
        
        
        
        if righMyotTF.text == leftMyoTF.text {
            if rightDevTF.text == leftDevTF.text {
                if rightAxTF.text ==  leftAxTF.text {
                    self.selectedSameSize = true
                                    self.numViiw.alpha = 0.0
                                    self.numViiw.alpha = 0.0
                                    self.numberLabel.alpha = 0
                                    self.thirdView.alpha = 1.0
                                    print("cooo 1")
            }
            }
             } else {
            self.selectedSameSize = false
                            self.thirdView.alpha = 0.0
                            self.numberLab.alpha = 1.0
                            self.numViiw.alpha = 1.0
                            print("cooo 11")
        }
            
        
        
        
        print("3",righMyotTF.text ?? "")
        print("33",leftMyoTF.text ?? "")
        print("1",rightDevTF.text ?? "")
        print("11",leftDevTF.text ?? "")
        print("2",rightAxTF.text ?? "")
        print("22",leftAxTF.text ?? "")
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
//
//        guard let ri = righMyotTF.text, !ri.isEmpty,
//                let le = leftMyoTF.text, !le.isEmpty,
//                 let devR = rightDevTF.text, !devR.isEmpty,
//                  let devL = leftDevTF.text, !devL.isEmpty,
//                   let axR = rightAxTF.text, !axR.isEmpty,
//                    let axL = leftAxTF.text, !axL.isEmpty
//                          else { return }
//        if rightAxTF.text! == leftAxTF.text! {
//            //devR == devL {
////            self.selectedSameSize = true
////            self.numViiw.alpha = 0
////            self.numViiw.alpha = 0
////            self.numberLabel.alpha = 0
////            self.thirdView.alpha = 1.0
//            print("cooo3")
//
//        }  else if   rightDevTF.text! ==  leftDevTF.text! {
//            //ri == le {
//
////            self.selectedSameSize = true
////            self.numViiw.alpha = 0
////            self.numViiw.alpha = 0
////            self.numberLabel.alpha = 0
////            self.thirdView.alpha = 1.0
//               print("cooo 2")
//        } else if righMyotTF.text! == leftMyoTF.text! {
//            //rightAxTF.text == leftAxTF.text {
//            //axR == axL  {
//
//                self.selectedSameSize = true
//                self.numViiw.alpha = 0
//                self.numViiw.alpha = 0
//                self.numberLabel.alpha = 0
//                self.thirdView.alpha = 1.0
//                     print("cooo 1")
//
//           } else {
//            self.selectedSameSize = false
//            self.thirdView.alpha = 0
//            self.numberLab.alpha = 1.0
//            self.numViiw.alpha = 1.0
//        }
//
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        if recPage == "color" {
            performSegue(withIdentifier: "UnwindColor", sender: self)
        } else if recPage == "tran" {
            performSegue(withIdentifier: "UnwinTran", sender: self)
        } else if recPage == "search" {
            performSegue(withIdentifier: "UnwindSearch", sender: self)
        } else if recPage == "offer" {
            performSegue(withIdentifier: "OfferUnwind", sender: self)
        } else if recPage == "fav" {
            performSegue(withIdentifier: "favvUnwind", sender: self)
        } else if recPage == "mod" {
            performSegue(withIdentifier: "modUnwind", sender: self)
        }
    }
  
    
    @IBAction func checkBtn(_ sender: UIButton) {
        self.buttonSwitched = !self.buttonSwitched
        
        if self.buttonSwitched
        {
            self.secView.animation = "fadeIn"
            self.secView.duration = 1.5
            self.secView.alpha = 1.0
            self.secView.animate()
            
            self.sameView.animation = "fadeOut"
            self.sameView.duration = 1.5
            self.sameView.alpha = 0.0
            self.sameView.animate()
            
        self.checkB.setImage(UIImage(named: "chk"), for: .normal)
            self.similar = 1

        }
        else
        {
            self.secView.animation = "fadeOut"
            self.secView.duration = 1.5
            self.secView.alpha = 0.0
            self.secView.animate()
            
            self.sameView.animation = "fadeIn"
            self.sameView.duration = 1.5
            self.sameView.alpha = 1.0
            self.sameView.animate()
            self.thirdView.alpha = 0
            
        self.checkB.setImage(UIImage(named: "ch"), for: .normal)
             self.similar = 0
        }
        
          //self.thirdView.alpha = 0
        
    }
    
    
    @IBAction func mainPlusBtn(_ sender: Any) {
        if mainNumb >= 1 {
            self.mainNumb += 1
            print(mainNumb)
            mainNumLabel.text = "\(mainNumb)"
            self.mainBoxNum = mainNumLabel.text!
          //  quantity = +1
            print(quantity)
        }
       
    }
    
    @IBAction func mainMinBtn(_ sender: Any) {
        if mainNumb > 1 {

        self.mainNumb -= 1
            self.quantity = -1
            
          mainNumLabel.text = "\(mainNumb)"
            self.mainBoxNum = mainNumLabel.text!

        }
    }
    

    
    @IBAction func thPlusBtn(_ sender: Any) {
        
        if thirdBoxNum >= 1 {
            self.thirdBoxNum += 1
            print(thirdBoxNum)
            thNumLab.text = "\(thirdBoxNum)"
            self.thirdBoxNum = Int(thNumLab.text!)!
            print("third  = \(thirdBoxNum)")
        }
        
        
    }
    
    
    @IBAction func thMinBtn(_ sender: Any) {
        
        if thirdBoxNum > 1 {
            
            self.thirdBoxNum -= 1
            self.quantity = -1
            
            thNumLab.text = "\(thirdBoxNum)"
            self.thirdBoxNum = Int(thNumLab.text!)!
            print("third  == \(thirdBoxNum)")

        }
        
        
    }
    
    
    
    
    
    @IBAction func addBtn(_ sender: Any) {
        
        

        

        self.right_amount = Int(rightNumLabel.text!)!
         self.left_amount = Int(leftNumLab.text!)!
        
        
        let items = ItemsList(context: context!)
         items.hasSize = 1

         items.orPrice = Double(recPrice)
          items.product_id = Int32(recProdId)
           items.type = Int32(0)
            items.similar = Int32(similar)
             
       

        if similar == 0 {
            if recDev.isEmpty == false {
              guard  let de = devTF.text, !de.isEmpty else {
                    Alert.alertPopUp(title: General.stringForKey(key: "emf"), msg: General.stringForKey(key: "al"), vc: self)
                    return
                }
                items.right_deviation = Double(mainDevDegree)!
            }
            
            if recAx.isEmpty == false {
               guard let ax = axTF.text, !ax.isEmpty else {
                    Alert.alertPopUp(title: General.stringForKey(key: "emf"), msg: General.stringForKey(key: "al"), vc: self)
                    return
                }
                items.right_axis = Double(mainAxDegree)!
            }
            
            if recMyop.isEmpty == false  {
                guard let my = myoTF.text, !my.isEmpty else {
                    Alert.alertPopUp(title: General.stringForKey(key: "emf"), msg: General.stringForKey(key: "al"), vc: self)
                    return
                }
                items.right_degree = Double(mainMyoDegree)!
            }
            
            
            
            items.left_amount = Int32(0)
            // same size
            items.right_amount = Int32(0)
            
            items.quantity = Int32(mainBoxNum)!
            
            itemTotalprice = Int(recPrice) * Int(mainBoxNum)!
                     
            
            items.total = Double(itemTotalprice)
            
            
            items.name_ar = recTitle
            items.name_en = recTitle_en
            items.img = recImaage
            items.orPrice = Double(recPrice)
            items.similar = 0
            items.sameSize = true
            
            do {
                appDelegate.saveContext()
               // print("data saved")
                ActionSheet()
               // Helper.showSuccess(title: General.stringForKey(key:"sa"))
                cartBut.isUserInteractionEnabled = false

            }
            
        } else {
            
              
            if recDev.isEmpty == false {
                  guard let de = rightDevTF.text, !de.isEmpty,
                          let d = leftDevTF.text, !d.isEmpty
                    else  {
                    Alert.alertPopUp(title: General.stringForKey(key: "emf"), msg: General.stringForKey(key: "al"), vc: self)
                    return
                }
                items.right_deviation = Double(rightDevDegree)!
                items.left_deviation = Double(leftDevDegree)!
            }

            if recAx.isEmpty == false {

                guard let a = rightAxTF.text, !a.isEmpty,
                    let ax = leftAxTF.text, !ax.isEmpty
                else {
                    Alert.alertPopUp(title: General.stringForKey(key: "emf"), msg: General.stringForKey(key: "al"), vc: self)
                    return
                }
                items.left_axis = Double(leftAxDegree)!
                items.right_axis = Double(rightAxDegree)!
                
            }

            if recMyop.isEmpty == false  {
                guard let my = leftMyoTF.text, !my.isEmpty,
                    let m = righMyotTF.text, !m.isEmpty else {
                    Alert.alertPopUp(title: General.stringForKey(key: "emf"), msg: General.stringForKey(key: "al"), vc: self)
                    return
                }
                items.right_degree = Double(rightMyoDegree)!
                items.left_degree = Double(leftMyoDegree)!

            }
//
//            if selectedSameSize == true {
//                items.quantity = Int32(rightBoxNum)!
//            }
            
            // Selected same size for both eyes
            if selectedSameSize  == true {
                
                if rightAxTF.text == leftAxTF.text {
                    
                }
                
                
                if rightDevTF.text == leftDevTF.text {
                    
                }
                
                
                
               items.right_amount = Int32(0)
                items.left_amount = Int32(0)
                
                
                
                items.sameSize = true
                items.quantity = Int32(self.thNumLab.text!)!
                      let dddd = Int(self.thNumLab.text!)!
                     print("third label ===== \(Int(self.thNumLab.text!)!)")
                   items.total = Double(dddd*Int(recPrice))
                     print("totaaaaaaaaaal ===\(dddd*Int(recPrice))")
            } else {
                items.right_amount = Int32(rightBoxNum)!
                 items.left_amount = Int32(leftBoxNum)!
                
                items.orRightAmout = Int32(rightBoxNum)!
                   items.orLeftAmount = Int32(leftBoxNum)!
                    items.sameSize = false
               // self.quantity = Int(rightBoxNum)!+Int(leftBoxNum)!
                print("quantity", self.quantity)
                //items.quantity = Int32(quantity)
                items.quantity = Int32(1)
                let plu = Int32(rightBoxNum)! + Int32(leftBoxNum)!
                //itemTotalprice = quantity*Int(recPrice)
                itemTotalprice = Int(plu)*Int(recPrice)
                items.total = Double(itemTotalprice)

            }
          
           
               items.img = recImaage
                items.name_ar = recTitle
                 items.name_en = recTitle_en
                  items.orPrice = Double(recPrice)
                   items.similar = 1

            do {
                appDelegate.saveContext()
                ActionSheet()
                cartBut.isUserInteractionEnabled = false
            }
        }
        
       
    }
    
    
    @IBAction func rightPlusBtn(_ sender: Any) {
        if right_amount >= 1 {
         self.right_amount += 1
        print(mainNumb)
        rightNumLabel.text = "\(right_amount)"
            rightBoxNum = rightNumLabel.text!
            
        }
    }
    
    @IBAction func rightMinBtn(_ sender: Any) {
        if  right_amount > 1 {

        self.right_amount -= 1
        print(mainNumb)
        rightNumLabel.text = "\(right_amount)"
            rightBoxNum = rightNumLabel.text!
        }
    }
    
    @IBAction func leftPlusBtn(_ sender: Any) {
        if left_amount >= 1 {
        self.left_amount += 1
        print(mainNumb)
        leftNumLab.text = "\(left_amount)"
            leftBoxNum = leftNumLab.text!
        }
    }
    
    @IBAction func leftMinBtn(_ sender: Any) {
        if left_amount > 1 {
            self.left_amount -= 1
            print(left_amount)
            leftNumLab.text = "\(left_amount)"
              leftBoxNum = leftNumLab.text!
        }
        

    }
    
    
    
    
    func configSliderShow() {
        
        for da in self.recImgs {
            self.imgSource.append(KingfisherSource(urlString: da)!)
        }
        
        self.slider.setImageInputs(imgSource)
        
        slider.slideshowInterval = 5.0
        slider.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        slider.contentScaleMode = UIView.ContentMode.scaleAspectFit
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.white
        slider.pageIndicator = pageControl
        
        slider.activityIndicator = DefaultActivityIndicator()
        slider.activityIndicator = DefaultActivityIndicator(style: .gray , color: nil )
        
        slider.currentPageChanged = { page in
            print("current page:", page)
            
        self.slider.addSubview(pageControl)
            
        }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(AdContentVC.didTap))
                slider.addGestureRecognizer(recognizer)
        
        
        slider.addSubview(pageControl)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sameSize), name: NSNotification.Name(rawValue: "send"), object: nil)
    }
    
    @objc func didTap() {
        let fullScreenController = slider.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    
    @ objc func sameSize(notif: NSNotification) {
//        Helper.deleteAllData("ItemsList")
//        performSegue(withIdentifier: "sos", sender: self)
        
    }
    
    func setDesgin() {
       // slider.roundView()
        contentTxtView.layer.cornerRadius = 10.0
        //mainDegreeTF.layer.cornerRadius = 10.0
    }
    
    
    
    func confgPickerView()  {
        
       // Same eye degrees
        let pickrView = UIPickerView()
         pickrView.tag = 1
          pickrView.delegate = self
            myoTF.inputView = pickrView
        

        let pikrView = UIPickerView()
         pikrView.tag = 2
          pikrView.delegate = self
            devTF.inputView = pikrView
        
        
        let pikrViw = UIPickerView()
         pikrViw.tag = 3
          pikrViw.delegate = self
            axTF.inputView = pikrViw
        
        
        // not same eye degrees
        // Right
        let pikViw = UIPickerView()
        pikViw.tag = 4
        pikViw.delegate = self
            righMyotTF.inputView = pikViw
        
        let pirViw = UIPickerView()
        pirViw.tag = 5
        pirViw.delegate = self
            rightDevTF.inputView = pirViw
    
       let pViw = UIPickerView()
        pViw.tag = 6
        pViw.delegate = self
            rightAxTF.inputView = pViw
        
        
        // Left
        let pk = UIPickerView()
        pk.tag = 7
        pk.delegate = self
            leftMyoTF.inputView = pk
        
        
         let pkrView = UIPickerView()
        pkrView.tag = 8
        pkrView.delegate = self
             leftDevTF.inputView = pkrView
        
        let pikrVw = UIPickerView()
        pikrVw.tag = 9
        pikrVw.delegate = self
            leftAxTF.inputView = pikrVw
        

    }
    
    
    

    func dynamicViewControllerHieght() {
        var hieght = self.view.bounds.height
            print(hieght)
        hieght = self.newHieght
    }
    

    func setPrortcols() {
        self.contentTxtView.delegate = self
    }
   
    
    func displayData() {
        
         self.amountLabel.text = "\(recPrice)"
        
        if General.CurrentLanguage() == "en" {
            self.contentTxtView.text = recContentEn
            self.contentTxtView.textAlignment = .left
            self.titleLabel.textAlignment = .left
             self.brandNameLabel.text = recBrandEn
              self.titleLabel.text = recTitle_en

        } else {
            self.contentTxtView.text = recContent
            self.contentTxtView.textAlignment = .right
            self.titleLabel.textAlignment = .right
             self.brandNameLabel.text = recBrandAr
              self.titleLabel.text = recTitle
        }
        
    }
    
    fileprivate func setLoca() {
    
     rightEyeLab.text = General.stringForKey(key: "rightEye")
        leftEyeLab.text = General.stringForKey(key: "leftEye")
    
      myopiaLab.text = General.stringForKey(key: "myopia")
       myopiaLabel.text = General.stringForKey(key: "myopia")
        
        devitaionLab.text = General.stringForKey(key: "devitaion")
         devitainLabel.text = General.stringForKey(key: "devitaion")
        
        axisLab.text = General.stringForKey(key: "axis")
         axisLabel.text = General.stringForKey(key: "axis")
        
        numberLab.text = General.stringForKey(key: "boxs")
         numberLabel.text = General.stringForKey(key: "boxs")
        
        medicalLab.text = General.stringForKey(key: "defri")
        
        cartBut.setTitle(General.stringForKey(key: "carBu"), for: .normal )
        
        
        priceLab.text = General.stringForKey(key: "price")
         rsLabel.text = General.stringForKey(key: "rs")
        
        
        
    }
    
    
    private func ActionSheet() {
      
        let actionSheet = UIAlertController(title: General.stringForKey(key: "su"), message: General.stringForKey(key: "choose"), preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: General.stringForKey(key: "Cancel"), style: .cancel , handler: nil)
        
        let con = UIAlertAction(title: General.stringForKey(key: "ccon"), style: .default) { (action) in
            self.performSegue(withIdentifier: "ppp", sender: self)
        }
        
        
        let pay = UIAlertAction(title: General.stringForKey(key: "buy"), style: .default) { (action) in
            actionSheet.dismiss(animated: true, completion: nil)
        }
        
        
        actionSheet.addAction(con)
         actionSheet.addAction(pay)
          actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    private func checkArrayData() {
        
        if recDev.isEmpty == true {
            
            self.devTF.alpha = 0
            self.rightDevTF.alpha = 0
             self.leftDevTF.alpha = 0
             self.devitaionLab.alpha = 0
              self.devitainLabel.alpha = 0
            
        }
        
        if recAx.isEmpty == true {
            self.axTF.alpha = 0
            self.axisLab.alpha = 0
            self.axisLabel.alpha = 0
            self.leftAxTF.alpha = 0
            self.rightAxTF.alpha = 0
        }
        
        if recMyop.isEmpty == true {
            self.myoTF.alpha = 0
            self.righMyotTF.alpha = 0
            self.leftMyoTF.alpha = 0
            self.myopiaLab.alpha = 0
            self.myopiaLabel.alpha = 0
        }
    }
    
    
    
}
extension AdContentVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
      //  let sizeToFitIn = CGSizeMake(self.contentTxtView.bounds.size.width, CGFloat(MAXFLOAT))
        let wid = CGFloat(self.contentTxtView.bounds.size.width)
        print("width",wid)
        let sizeToFitIn = CGSize(width: wid, height: CGFloat(MAXFLOAT))
        print("size",sizeToFitIn)
        let newSize = self.contentTxtView.sizeThatFits(sizeToFitIn)
        self.textViewHeight.constant = newSize.height
        self.newHieght = newSize.height
        print("newSize",newSize.height)
    }
    
   
    
}

extension AdContentVC: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
       
         if (pickerView.tag == 1){
            return recMyop.count
        } else if (pickerView.tag == 2){
            return recDev.count
        } else if (pickerView.tag == 3){
            return recAx.count
         } else if (pickerView.tag == 4) {
            return recMyop.count
         } else if (pickerView.tag == 5){
            return recDev.count
         }else if (pickerView.tag == 6){
            return recAx.count
         }else if (pickerView.tag == 7){
            return recMyop.count
         }else if (pickerView.tag == 8){
            return recDev.count
         }else if (pickerView.tag == 9){
            return recAx.count
        }
        return 1

    }
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    if pickerView.tag == 1{
        
        return recMyop[row]
        
    }else if pickerView.tag == 2{
        
        return recDev[row]
        
    }else if pickerView.tag == 3{
        
        return recAx[row]
        
    } else if pickerView.tag == 4{
        
        return recMyop[row]
        
    }else if pickerView.tag == 5{
        
        return recDev[row]
        
    }else if pickerView.tag == 6{
        
        return recAx[row]
        
    } else if pickerView.tag == 7{
        
        return recMyop[row]
        
    }else if pickerView.tag == 8{
        
        return recDev[row]
        
    }else if pickerView.tag == 9{
        
        return recAx[row]
        
    }
    return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
         if pickerView.tag == 1 {
                myoTF.text = recMyop[row]
                self.mainMyoDegree = recMyop[row]
           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sam"), object: nil)
        } else if pickerView.tag == 2 {
                devTF.text = recDev[row]
                self.mainDevDegree = recDev[row]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sam"), object: nil)
        } else if pickerView.tag == 3 {
                axTF.text = recAx[row]
                self.mainAxDegree = recAx[row]
           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sam"), object: nil)
         }else if pickerView.tag == 4 {
            
                righMyotTF.text = recMyop[row]
                self.rightMyoDegree = recMyop[row]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sam"), object: nil)
           
         }else if pickerView.tag == 5 {
            
            
                rightDevTF.text = recDev[row]
                self.rightDevDegree = recDev[row]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sam"), object: nil)
            
         }else if pickerView.tag == 6 {
            
                rightAxTF.text = recAx[row]
                self.rightAxDegree = recAx[row]
            // new
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sam"), object: nil)
         }else if pickerView.tag == 7 {
            
                leftMyoTF.text = recMyop[row]
                self.leftMyoDegree = recMyop[row]
            // old update
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sam"), object: nil)

            
         }else if pickerView.tag == 8{
                leftDevTF.text = recDev[row]
                self.leftDevDegree = recDev[row]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sam"), object: nil)
         }else if pickerView.tag == 9 {
            
                leftAxTF.text = recAx[row]
                self.leftAxDegree = recAx[row]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sam"), object: nil)
            
        }
      }
    
}
extension UIView {
    func setLayer() {
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2.0
        
    }
}
extension UITextField {
    func setTxtLayer() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2.0
    }
}
