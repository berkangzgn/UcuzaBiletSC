//
//  ViewController.swift
//  UcuzaBiletSC
//
//  Created by Berkan Gezgin on 7.06.2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextLabel: UITextField!
    @IBOutlet weak var sifreTextLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func girisYapButton(_ sender: Any) {
        if emailTextLabel.text != "" && sifreTextLabel.text != "" {
            Auth.auth().signIn(withEmail: emailTextLabel.text!, password: sifreTextLabel.text!) { authResult, error in
                if error != nil {
                    self.errorMessage(titleInput: "Hata", messageInput: error!.localizedDescription)
                }  else {
                    self.performSegue(withIdentifier: "toMainPage", sender: nil)
                }
            }
        } else {
            errorMessage(titleInput: "Boş alan!", messageInput: "Lütfen boş alan bırakmayın")
        }
    }
    
    @IBAction func kayitOlButton(_ sender: Any) {
        if emailTextLabel.text != "" && sifreTextLabel.text != "" {
            Auth.auth().createUser(withEmail: emailTextLabel.text!, password: sifreTextLabel.text!) { authDataResult, error in
                if self.validateEmail(emailTextLabel: self.emailTextLabel.text!) == true {
                    if error != nil {
                        self.errorMessage(titleInput: "Hata", messageInput: error!.localizedDescription)
                    }  else {
                        self.performSegue(withIdentifier: "toMainPage", sender: nil)
                    }
                } else {
                    self.errorMessage(titleInput: "Yanlış format!! ", messageInput: "Lütfen emailinizi kontrol edin.. Yanlış formatta girdiniz.")
                }
            }
        } else {
            errorMessage(titleInput: "Boş alan!", messageInput: "Lütfen boş alan bırakmayın")
        }
    }
    
    // TODO: Sifremi unuttum eklenecek
    @IBAction func sifremiUnuttumButton(_ sender: Any) {
    }
    /*
    @IBAction func cikisButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "logout", sender: nil)
        } catch {
            print("Error!")
        }
    }*/
    
    func errorMessage(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func validateEmail(emailTextLabel: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: emailTextLabel)
    }
}
