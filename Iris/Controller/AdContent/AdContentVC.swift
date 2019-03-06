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
    @IBOutlet weak var mainDegreeTF: ImageInsideTextField!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var checkB: CornerButtons!
    @IBOutlet weak var mainNumLabel: UILabel!
    @IBOutlet weak var packageTF: ImageInsideTextField!
    @IBOutlet weak var rightNumLabel: UILabel!
    @IBOutlet weak var leftNumLab: UILabel!
    @IBOutlet weak var secView: RoundedUIView!
    @IBOutlet weak var rightTF: ImageInsideTextField!
    @IBOutlet weak var leftTF: ImageInsideTextField!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    var recPage = ""
    var newHieght:CGFloat = 0.0
    var imgSource = [InputSource]()
    
    // recieve product data
    var recImgs = [String]()
    var recTitle = ""
    var recContent = ""
    var recProdId = 0
    var left_degree:Double = 0.0
    var right_degree:Double = 0.0
    var left_amount  = 1
    var right_amount  = 1
    var similar = 0 // not the same size
    var package = 0
    var quantity = 1
    var recHasSize = 0
    var recPrice = 0
    var itemTotalprice = 1
    var totalPro = 1
    var sizes:[Int] = []
    var eyeSize:[Double] = [+6.0,+5.75,+5.5,+5.25,+5.0,+4.0,+4.75,+4.5,+4.25,+4.0,+3.75,+3.5,+3.25,+3.0,2.75,+2.50,+2.25,+2.0,+1.75,+1.5,+1.25,+1.0,+0.75,-1.0,-1.25,-1.5,-1.75,-2.0,-2.25,-2.5,-2.75,-3.0]
    
    
    var mainNumb = 1.0

    
    var buttonSwitched : Bool = false

    var context:NSManagedObjectContext?
    let appDelegate  = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if recHasSize == 0 {
            secView.alpha = 0
        }
        
        
        self.right_amount = Int(rightNumLabel.text!)!
        self.left_amount = Int(leftNumLab.text!)!
        
        
        print(right_amount)
        print(left_amount)
        
        
        context = appDelegate.persistentContainer.viewContext
        navigationItem.title = General.stringForKey(key: "details")
        
          setDesgin()
           displayData()
            confgPickerView()
           configSliderShow()
              setPrortcols()
        dynamicViewControllerHieght()
           displayPackage()
        
        self.mainView.setLayer()
        self.mainDegreeTF.setTxtLayer()
    
        secView.alpha = 0
        mainNumLabel.text = "\(mainNumb)"
        
        // set data
        
        
        
       
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        if recPage == "market" {
            performSegue(withIdentifier: "UnwindMarket", sender: self)
        } else if recPage == "search" {
            performSegue(withIdentifier: "UnwindSearch", sender: self)
        } else if recPage == "offer" {
            performSegue(withIdentifier: "OfferUnwind", sender: self)
        } else if recPage == "fav" {
            performSegue(withIdentifier: "favvUnwind", sender: self)
        }
    }
  
    
    @IBAction func checkBtn(_ sender: UIButton) {
        self.buttonSwitched = !self.buttonSwitched
        
        if self.buttonSwitched
        {
            self.secView.alpha = 1.0
        self.checkB.setImage(UIImage(named: "chk"), for: .normal)
            self.similar = 1

        }
        else
        {
             self.secView.alpha = 0.0
        self.checkB.setImage(UIImage(named: "ch"), for: .normal)
             self.similar = 0
        }
        
//        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
//            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//        }) { (success) in
//            UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
//                sender.isSelected = !sender.isSelected
//                sender.transform = .identity
//                self.secView.alpha = 1.0
//            }, completion: nil)
//        }
        
        
    }
    
    
    @IBAction func mainPlusBtn(_ sender: Any) {
        if mainNumb >= 1 {
            self.mainNumb += 1
            print(mainNumb)
            mainNumLabel.text = "\(mainNumb)"
            quantity = +1
            print(quantity)
        }
       
    }
    
    @IBAction func mainMinBtn(_ sender: Any) {
        if mainNumb > 1 {

        self.mainNumb -= 1
            self.quantity = -1

        print(mainNumb)
            print(quantity)
        mainNumLabel.text = "\(mainNumb)"

        }
    }
    
    @IBAction func addBtn(_ sender: Any) {
         // save to core data
        
        itemTotalprice = recPrice*quantity
        
        let prod = Product(context: context!)
        let items = ItemsList(context: context!)
        let toItems = [items.total].count
        prod.name = (UserDefaults.standard.object(forKey: "name") as! String)
        prod.email = (UserDefaults.standard.object(forKey: "email") as! String)
        prod.token = Helper.getUserToken()
        prod.phone = (UserDefaults.standard.object(forKey: "phone") as! String)
        prod.total = items.total*Int16(toItems)

        items.product_id = Int16(recProdId)
        items.similar = Int16(similar)
        items.left_amount = Int16(left_amount)
        items.left_degree = Int16(left_degree)
        items.right_degree = Int16(right_degree)
        items.right_amount = Int16(right_amount)
        items.package = Int16(package)
        //items.quantity = Int32(quantity)
        items.total = Int16(itemTotalprice)
        
        
        do {
            appDelegate.saveContext()
            print("data saved")
            Helper.showSuccess(title: General.stringForKey(key:"sa"))
        }
    }
    
    
    @IBAction func rightPlusBtn(_ sender: Any) {
        if mainNumb >= 1 {
         self.mainNumb += 1
        print(mainNumb)
        rightNumLabel.text = "\(mainNumb)"
        }
    }
    
    @IBAction func rightMinBtn(_ sender: Any) {
        if  mainNumb > 1 {

        self.mainNumb -= 1
        print(mainNumb)
        rightNumLabel.text = "\(mainNumb)"
        }
    }
    
    @IBAction func leftPlusBtn(_ sender: Any) {
        if mainNumb >= 1 {
        self.mainNumb += 1
        print(mainNumb)
        leftNumLab.text = "\(mainNumb)"
      }
    }
    
    @IBAction func leftMinBtn(_ sender: Any) {
        if mainNumb > 1 {
            self.mainNumb -= 1
            print(mainNumb)
            leftNumLab.text = "\(mainNumb)"
        }
        

    }
    
    
    
    
    func configSliderShow() {
        
        for da in self.recImgs {
            self.imgSource.append(KingfisherSource(urlString: da)!)
        }
        
        self.slider.setImageInputs(imgSource)
        
        slider.slideshowInterval = 5.0
        slider.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        slider.contentScaleMode = UIView.ContentMode.scaleAspectFill
        
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
        
    }
    
    @objc func didTap() {
        let fullScreenController = slider.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    
    func setDesgin() {
        slider.roundView()
        contentTxtView.layer.cornerRadius = 10.0
        mainDegreeTF.layer.cornerRadius = 10.0
    }
    
    func confgPickerView()  {
        let pickerView = UIPickerView()
        pickerView.tag=0
        pickerView.delegate = self
        packageTF.inputView = pickerView
        
        let pickrView = UIPickerView()
        pickrView.tag = 1
        pickrView.delegate = self
        mainDegreeTF.inputView = pickrView

        let pikrView = UIPickerView()
        pikrView.tag = 2
        pikrView.delegate = self
        rightTF.inputView = pikrView

        let pikrViw = UIPickerView()
        pikrViw.tag = 3
        pikrViw.delegate = self
        leftTF.inputView = pikrViw

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
        self.titleLabel.text = recTitle
        self.contentTxtView.text = recContent
    }
    
    func displayPackage() {
        Alamofire.request(URLs.main+"api/packages", method: .get).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                print(error)
            case.success(let value):
                let json = JSON(value)
                guard let arr = json["sizes"].array else {
                    return
                }
                print(arr)
                for siz in arr {
                    if let num = siz.int  {
                        self.sizes.append(num)
                        print(num)
                    }
                }
            }
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
        
        if (pickerView.tag == 0) {
            return sizes.count
        }else if (pickerView.tag == 1){
            return eyeSize.count
        } else if (pickerView.tag == 2){
            return eyeSize.count
        } else if (pickerView.tag == 3){
            return eyeSize.count
        }
        return 1

    }
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView.tag == 0 {
        return "\(sizes[row])"
    }else if pickerView.tag == 1{
        return "\(eyeSize[row])"
    }else if pickerView.tag == 2{
        return "\(eyeSize[row])"
    }else if pickerView.tag == 3{
        return "\(eyeSize[row])"
    }
    return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            packageTF.text = "\(sizes[row])"
            package = sizes[row]
        } else if pickerView.tag == 1 {
            mainDegreeTF.text = "\(eyeSize[row])"
           // rightTF.text = "\(eyeSize[row])"
            //???????????????????????
            right_degree = eyeSize[row]
            left_degree = eyeSize[row]
        } else if pickerView.tag == 2 {
            rightTF.text = "\(eyeSize[row])"
            right_degree = eyeSize[row]
        } else if pickerView.tag == 3 {
            leftTF.text = "\(eyeSize[row])"
            left_degree = eyeSize[row]
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
