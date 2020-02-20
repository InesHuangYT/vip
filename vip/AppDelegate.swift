//
//  AppDelegate.swift
//  vip
//
//  Created by Ines on 2020/2/13.
//  Copyright © 2020 Ines. All rights reserved.
//  在 iOS 12 安裝 Xcode 11 開發的App
//https:medium.com/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84-swift-ios-app-%E9%96%8B%E7%99%BC%E5%95%8F%E9%A1%8C%E8%A7%A3%E7%AD%94%E9%9B%86/%E5%9C%A8-ios-12-%E5%AE%89%E8%A3%9D-xcode-11-%E9%96%8B%E7%99%BC%E7%9A%84-app-1c9f3c30986e
import Firebase
import UIKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    
    var window : UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        let navigationBarBackColor = UINavigationBar.appearance()
        navigationBarBackColor.tintColor = UIColor(red: 137/255, green: 136/255, blue: 128/255, alpha: 1)
        
        GIDSignIn.sharedInstance().clientID = "170838114822-7ulfotevovsmh9ntemqvorlm6e1v1leu.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {        
        
        return GIDSignIn.sharedInstance().handle(url)
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error  = error {
            print("\(error.localizedDescription)")
        }else{
            let userId = user.userID;                  // For client-side use only!
            let fullName = user.profile.name;
            let email = user.profile.email;
            let idToken = user.authentication.idToken; // Safe to send to the server

            print("userId: ",userId!)
            print("fullName: ",fullName!)
            print("email: ",email!)
            print("idToken: ",idToken!)

        }
        
        
//        
//        guard let authentication = user.authentication else {return}
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
//        Auth.auth().signIn(with: credential) { (result, error) in
//            if let error = error{
//                print ("faled to signIn and retrieve data with error ", error)
//                return
//        }
//            guard let uid = result?.user.uid else {return}
//            guard let email = result?.user.email else {return}
//            guard let name = result?.user.displayName else {return}
//            let values = ["account":email,"name":name]
////            let values = ["account":email,"name":name,"password":0, "phone" :nil, "uid":uid] as [String : Any?]
//            Database.database().reference().child("users").setValue(values,withCompletionBlock: {(error,ref) in
//
//            
//            })
//            
//        
//        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!){
       
        // Perform any operations when the user disconnects from app here.
        print("User has diconected!")
        
    }
    
 

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

