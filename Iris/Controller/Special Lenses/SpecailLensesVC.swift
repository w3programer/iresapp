import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
class SpecailLensesVC: UIViewController {
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var com: CornerButtons!
        var ph = ""
    @IBOutlet weak var headerlogo: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
          self.getData()
        let preferredLanguage = NSLocale.preferredLanguages[0]
        if preferredLanguage.starts(with: "en"){
            self.headerlogo.imageInsets.right = 120
        } else{
            self.headerlogo.imageInsets.left = 220
            
        }

//        DispatchQueue.main.async {
//            self.getData()
//        }
        
        com.setTitle(General.stringForKey(key: "com"), for: .normal)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
         self.getData()
    }
    @IBAction func completeBtn(_ sender: Any) {
        
        
        let appURL = NSURL(string: "https://api.whatsapp.com/send?phone=\(self.ph)")!
        if UIApplication.shared.canOpenURL(appURL as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
               }
            else {
                UIApplication.shared.openURL(appURL as URL)
            }
        }
        else {
           // AlertPopUP(title: General.stringForKey(key: "err"), message: General.stringForKey(key: "installwts"))
            // Whatsapp is not installed
        }
        
    }
    
    func getData() {
        var url = ""
        
        if General.CurrentLanguage() == "ar" {
            url = URLs.sp+"?lang=ar"
        } else {
            url = URLs.sp+"?lang=en"
        }
        Alamofire.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                print("errr",error)
            case.success(let value):
                 let jsn = JSON(value)
                  let s = jsn["special_lenses"]
                   let p = s["phone"].string
                   let pho = p!
                   let new = pho.dropFirst()
                   let ww = "966"+new
                   self.ph = ww
                   let arr = s["description"]
                   let ar =  arr["ar"].string
                   self.txtView.text = ar!
             
            }
        }
    }
   
    
    
    
}
