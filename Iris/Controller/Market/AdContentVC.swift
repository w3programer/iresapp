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
    @IBOutlet weak var contentTxtView: UITextView!
    @IBOutlet weak var details: UIBarButtonItem!
    
    
    var recPage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          setDesgin()
         //     confgPickerView()
        //   configSliderShow()

          details.isEnabled = false
        
        
    
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        if recPage == "market" {
            performSegue(withIdentifier: "UnwindMarket", sender: self)
        } else if recPage == "search" {
            performSegue(withIdentifier: "UnwindSearch", sender: self)
        }
    }
    
    
    
    func configSliderShow() {
        
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
        
    }
    
//    func confgPickerView()  {
//        let pickerView = UIPickerView()
//        pickerView.tag=0
//        pickerView.delegate = self
//        packageTF.inputView = pickerView
//
//        let pickerViewBranch = UIPickerView()
//        pickerViewBranch.tag=1
//        pickerViewBranch.delegate = self
//
//        let pickerViewType = UIPickerView()
//        pickerViewType.tag=2
//        pickerViewType.delegate = self
//        
//    }
    

    

   
}


//extension AdContentVC: UIPickerViewDelegate, UIPickerViewDataSource {
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//        if (pickerView.tag == 0) {
//            return //Data.count
//        }else if (pickerView.tag == 1){
//            return
//        } else if (pickerView.tag == 2) {
//            return
//        }
//        return 1
//
//
//    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        if pickerView.tag == 0 {
//            return Data[row].title
//        }else if pickerView.tag == 1{
//            return
//        }  else if pickerView.tag == 2 {
//            return typeData[row]
//
//        }
//        return " "
//    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//
//        if pickerView.tag == 0 {
//
//        }else if pickerView.tag == 1 {
//
//        } else if pickerView.tag == 2 {
//
//        }
//
//
//     }
//}
