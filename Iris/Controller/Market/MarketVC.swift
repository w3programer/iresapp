//
//  ViewController.swift
//  Iris
//
//  Created by mahmoudhajar on 2/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import ImageSlideshow



class MarketVC: UIViewController {

    
    @IBOutlet weak var transBtn: CornerButtons!
    @IBOutlet weak var colorBtn: CornerButtons!
    @IBOutlet weak var accBtn: CornerButtons!
    @IBOutlet weak var slider: ImageSlideshow!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var recAdded: CornerButtons!
    @IBOutlet weak var bestSeller: CornerButtons!
    
    
    
    var products = [Ads]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confrimProtocls()
            displayDesgin()

    }


    @IBAction func searchBtn(_ sender: Any) {
        
        
        
    }
    
    @IBAction func myProBtn(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func recAddBtn(_ sender: Any) {
        
        
    }
    
    
    @IBAction func bestSellerBtn(_ sender: Any) {
        
        
    }
    
    
    func displayDesgin() {
        
        transBtn.alignText()
        colorBtn.alignText()
        accBtn.alignText()
        recAdded.alignText()
        bestSeller.alignText()
        
        
    }
    
    
    func confrimProtocls() {
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
    }
    
    
    
//    func configSliderShow() {
//
//        slideshow.slideshowInterval = 5.0
//        slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
//        slideshow.contentScaleMode = UIView.ContentMode.scaleAspectFill
//
//        let pageControl = UIPageControl()
//        pageControl.currentPageIndicatorTintColor = UIColor.black
//        pageControl.pageIndicatorTintColor = UIColor.white
//        slideshow.pageIndicator = pageControl
//
//        slideshow.activityIndicator = DefaultActivityIndicator()
//        slideshow.activityIndicator = DefaultActivityIndicator(style: .gray , color: nil )
//
//        slideshow.currentPageChanged = { page in
//            print("current page:", page)
//        }
//
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(AdContentVC.didTap))
//        slideshow.addGestureRecognizer(recognizer)
//
//
//        slideshow.addSubview(pageControl)
//
//    }
    
    
    
    
    
    
}
extension MarketVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! marketCell
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth-30)/2
        
        return CGSize.init(width: width, height: width)
    }
    
    
    
    
    
}
extension UIButton {
    
    func alignText(spacing: CGFloat = 12.0) {
        if let image = self.imageView?.image {
            let imageSize: CGSize = image.size
            self.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -imageSize.width, bottom: -(imageSize.height), right: 0.0)
            let labelString = NSString(string: self.titleLabel!.text!)
            let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font])
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        }
    }
}

