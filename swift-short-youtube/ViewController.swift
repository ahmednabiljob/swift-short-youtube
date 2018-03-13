//
//  ViewController.swift
//  swift-short-youtube
//
//  Created by Ahmed on 3/9/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate,GIDSignInDelegate {
    let descriptionLabel : UILabel = UILabel()
    let signInButton: GIDSignInButton = GIDSignInButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().signIn()
        
        descriptionLabel.frame = CGRect(x: 10, y: 180, width: self.view.frame.width-20, height: 64)
        descriptionLabel.text = "Sign in"
        signInButton.frame = CGRect(x: 10, y: 264, width: self.view.frame.width-20, height: 64)
        
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(signInButton)
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: [:])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            print("Google signin error \(error)")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        print("this is the credentials of this user- \(credential)")
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print("Firebase signin error \(error)")
                return
            }
            // User is signed in
            // ...
            print("User signed in \(user?.displayName ?? "John Doe")")
            if let name=user?.displayName {
                self.descriptionLabel.text = "Signed in as \(name)"
                self.signInButton.isHidden = true
            }
        }
        performSegue(withIdentifier: "SearchViewController", sender: self)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        print("User signed out \(user.userID)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

