//
//  ViewController.swift
//  UcuzaBiletSC
//
//  Created by Berkan Gezgin on 7.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextLabel: UITextField!
    @IBOutlet weak var sifreTextLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func girisYapButton(_ sender: Any) {
        performSegue(withIdentifier: "toMainPage", sender: nil)
    }
    
    @IBAction func sifremiUnuttumButton(_ sender: Any) {
    }
    
    @IBAction func kayitOlButton(_ sender: Any) {
        performSegue(withIdentifier: "toMainPage", sender: nil)
    }
}
