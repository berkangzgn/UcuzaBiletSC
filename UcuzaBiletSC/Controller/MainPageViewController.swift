//
//  MainPageViewController.swift
//  UcuzaBiletSC
//
//  Created by Berkan Gezgin on 8.06.2022.
//

import UIKit
import Firebase

class MainPageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cikisButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "logout", sender: nil)
        } catch {
            print("Error!")
        }
    }
}
