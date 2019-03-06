//
//  OffersVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/4/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ImageSlideshow


class OffersVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var slider: ImageSlideshow!
    
    
    fileprivate var rowHeight: CGFloat = 130.0
    
    var offers = [Ads]()
    var pagi = [pagination]()
    
    var curentPage = 1
    var totalPages = 1
    
    
    // sendData
    var selectedImgs = [String]()
    var selectedTitle = ""
    var selectedContent = ""
    
    var imgSource = [InputSource]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideShow()
        slider.roundView()
        configSliderShow()
        confirmTableViewProtocls()
        tableView.tableFooterView = UIView()
        callData(pageNo: curentPage)
        self.tabBarController?.tabBar.items?[1].title = General.stringForKey(key: "offers")

        
        
        
    }
    

    
    
    func confirmTableViewProtocls() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

    
    func callData(pageNo:Int) {
        checkPagination()
        API.offers(pageNo: pageNo) { (error:Error?, data:[Ads]?) in
            if data != nil {
                self.offers.append(contentsOf: data!)
                self.tableView.reloadData()
            } else {
                print("no offers found")
             }
           }
        }
    
    @IBAction func unwindToFav(segue: UIStoryboardSegue) {}



    
    func checkPagination(){
        let url = URLs.offers
        Alamofire.request( url , method: .get ).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print("terms",error)
                
            case .success(let value):
                let jsonData = JSON(value)
                print(jsonData)
                let json = jsonData["meta"]
                print(json)
                let last = json["last_page"].int
                print(last!)
                self.totalPages = last!
            }
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
        
        slider.addSubview(pageControl)
        
    }
    
    
    func slideShow() {
        
        API.sliderData { (error: Error?, data:[Slider]?) in
            if data != nil {
                for da in data! {
                    self.imgSource.append(KingfisherSource(urlString: da.image)!)
                }
                self.slider.setImageInputs(self.imgSource)
            } else {
                print("Slider have no data")
            }
        }
    }
    
    
}
extension OffersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OffersCell
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        
        if General.CurrentLanguage() == "ar"
        {
            cell.title.text = offers[indexPath.row].name_ar
        }else
        {
            cell.title.text = offers[indexPath.row].name_en
        }
            cell.pics = offers[indexPath.item]
            cell.price.text = "\(offers[indexPath.row].price)"
            cell.offerLab.text = "\(offers[indexPath.row].price_after_discount)"
            
        
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == offers.count - 1 {
              if curentPage < totalPages {
                    curentPage += 1
                  print("nuuum",curentPage)
                self.callData(pageNo: curentPage)
              }
           }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedImgs = offers[indexPath.row].images
        selectedTitle = offers[indexPath.row].name_ar
        selectedContent = offers[indexPath.row].description_ar
        
        performSegue(withIdentifier: "OfferContent", sender: self)

        print(offers[indexPath.row].lastPage)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OfferContent" {
            let seg = segue.destination as? AdContentVC
            seg?.recPage = "offer"
            seg?.recImgs = selectedImgs
            seg?.recTitle = selectedTitle
            seg?.recContent = selectedContent
            
        }
    }
    
}
