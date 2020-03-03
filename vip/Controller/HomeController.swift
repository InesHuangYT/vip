//
//  HomeController.swift
//  vip
//
//  Created by Ines on 2020/2/19.
//  Copyright © 2020 Ines. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class CellClass : UITableViewCell{
    
}
class HomeController: UIViewController {
    @IBOutlet weak var selectShow: UIButton!
    
    @IBOutlet weak var currentUserlabel: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    
    let deliverWays = ["home","seven","family"]
    let transparentView = UIView()
    let tableViews = UITableView()
//    var selectedButton = UIButton()
    var uid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViews.delegate = self
        tableViews.dataSource = self
        tableViews.register(CellClass.self, forCellReuseIdentifier: "Cell")
        print("current user uidd : " , currentUserName())
     }
    
    @IBAction func signOutButtonWasPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        navigationController?.popViewController(animated: true)
    }
    
    func currentUserName()->(String){
        if let user = Auth.auth().currentUser{
            uid = user.uid
            print("uid : ",uid)
            currentUserlabel.text = " login uid is : " + (uid)
        }
        return(uid)

    }
    
    
    func addTransparent(frames:CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)  
        self.view.addSubview(tableViews)
        tableViews.layer.cornerRadius = 8
        tableViews.frame = CGRect(x: frames.origin.x, y: frames.origin.y, width: frames.width, height: 0)
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        let tapGesture = UITapGestureRecognizer(target: self
            , action: #selector(removeTransparent))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: { 
            self.transparentView.alpha = 0.5
            self.tableViews.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.deliverWays.count * 50) )
        }, completion: nil)
        
    }
    
    @objc func removeTransparent(){
        let frames = selectShow.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: { 
                        self.transparentView.alpha = 0
                        self.tableViews.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: 0)
        }, completion: nil)
    }
    
       
    
    @IBAction func deliverWaysWasPressed(_ sender: Any) {
        addTransparent(frames: selectShow.frame)
    }
    
}



extension HomeController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return deliverWays.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViews.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = deliverWays[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableViews.cellForRow(at: indexPath)
        selectShow.setTitle(cell?.textLabel?.text, for: .normal)
        self.tableViews.isHidden = false
        removeTransparent()
    }
}

