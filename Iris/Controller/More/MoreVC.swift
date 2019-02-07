//
//  MoreVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/6/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class MoreVC: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var titles = ["login","profile","contact us","about us","FAQ","ruls & condtions"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmProtocls()
         tableViewDesgin()
        
        
    }
    
    func confirmProtocls() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    func tableViewDesgin() {
        
        self.tableView.separatorColor = UIColor.white
        tableView.tableFooterView =  UIView()

        
    }

}
extension MoreVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MoreCell
        
        cell.titleLab.text = titles[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let animation = AnimationFactory.makeFade(duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
        } else if indexPath.row == 1 {
            performSegue(withIdentifier: "ProfileSegue", sender: self)
        } else if indexPath.row == 2 {
            
            performSegue(withIdentifier: "ContactSegue", sender: self)
            
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
}
