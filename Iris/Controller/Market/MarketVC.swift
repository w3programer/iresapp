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
    
    
    
   // var products = [Ads]()
    
    var products = ["vdcvd","cdc","cdc","cdc","cdc"]
    
    
    var selectedImgs = [String]()
    var selectedtitle = ""
    var selectedContent = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      //  configSliderShow()
         confrimProtocls()
          displayElementsDesgin()
        
        
        
    }


    @IBAction func searchBtn(_ sender: Any) {
        
        
       }
    
    @IBAction func myProBtn(_ sender: Any) {
        
        performSegue(withIdentifier: "CartSegue", sender: self)

        
    }
    
    
    @IBAction func recAddBtn(_ sender: Any) {
        
        
    }
    
    
    @IBAction func bestSellerBtn(_ sender: Any) {
        
        
    }
    
    
    @IBAction func unwindToMarket(segue: UIStoryboardSegue) {}

    
    func displayElementsDesgin() {
        
        transBtn.alignText()
        colorBtn.alignText()
        accBtn.alignText()
        recAdded.alignText()
        bestSeller.alignText()
        slider.roundView()
        
    }
    
    
    func confrimProtocls() {
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
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

        slider.addSubview(pageControl)

    }
    
    
    
    
    
    
    
    
    
}
extension MarketVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! marketCell
        
        cell.title.text = products[indexPath.row]
        cell.img.image = UIImage(named: "img.png")
        cell.fav.setImage(UIImage(named: "li.png"), for: .normal)
        cell.fav.setImage(UIImage(named: "lk.png"), for: .selected)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth-60)/2
        
        return CGSize.init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "ContentSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
    }
    
    
}

extension MarketVC: marketDelegate {
    
 func favTapped(_ sender: marketCell) {
    guard let tappedIndexPath = collectionView.indexPath(for: sender) else {return}
                         print(tappedIndexPath)
    
    let btn = collectionView(collectionView, cellForItemAt: tappedIndexPath) as! marketCell
        
    let sndr = (btn.fav)!
        
    UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
        sndr.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }) { (success) in
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
            sndr.isSelected = sender.isSelected
            sndr.transform = .identity
        }, completion: nil)
    }

    
    }
    
    
}
