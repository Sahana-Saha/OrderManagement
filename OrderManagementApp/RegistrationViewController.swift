//
//  RegistrationViewController.swift
//  OrderManagementApp
//
//  Created by Santosh Kumar on 31/03/21.
//

import UIKit

class RegistrationViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var titleRegister: UILabel!
    @IBOutlet weak var vwMainRegist: UIView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    @IBOutlet weak var txtConfirmPasswd: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    var arrUsers : [LoginUser] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        vwMainRegist.backgroundColor = UIColor.white
//        vwMainLogin.layer.borderWidth = 1
        vwMainRegist.layer.cornerRadius = 8.0
        vwMainRegist.layer.shadowOpacity = 0.2
        vwMainRegist.layer.shadowRadius = 3.0
        vwMainRegist.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        btnRegister.layer.cornerRadius = 8
        // Do any additional setup after loading the view.
    }
    
    func isValidPassword(_ passwordString: String?) -> Bool {
        let stricterFilterString = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{6,12}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", stricterFilterString)
        return passwordTest.evaluate(with: passwordString)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == txtUserName){
            textField.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        }
        else if(textField == txtPassword){
            textField.resignFirstResponder()
            txtConfirmPasswd.becomeFirstResponder()
        }
        else{
            self.view.endEditing(true)
        }
        return true
    }

    
    @IBAction func btnLoginPageClicked(_ sender: Any) {
        let rvc:LoginViewController = LoginViewController()
        self.navigationController?.pushViewController(rvc, animated: true)
    }
    
    
    func fetchRequest(){
        do{
            arrUsers = try context.fetch(LoginUser.fetchRequest())
           // if(arrUsers.count > 0){
                if (arrUsers.count > 0 && arrUsers.contains(where: { $0.name == txtUserName.text })) {
                    let alert = UIAlertController(title: "Alert", message: "User Already exists", preferredStyle: UIAlertController.Style.alert)
                               let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                                 alert.addAction(ok)
                                self.present(alert, animated:true, completion: nil)
                     // found
                }else{
                    let userLogin = LoginUser(context: self.context)
                    userLogin.name = txtUserName.text
                    userLogin.password = txtPassword.text
                    do{
                        try self.context.save()
                        DispatchQueue.main.async {
                            let rvc : LoginViewController = LoginViewController()
                            self.navigationController?.pushViewController(rvc, animated: true)
                        }
                        
                    }
                    catch{
                        
                    }
                }
        }
        catch{
            
        }

        }
    
    @IBAction func btnRegisterClicked(_ sender: Any) {
        if(isValidPassword(txtPassword.text)){
            if(txtPassword.text == txtConfirmPasswd.text){
                self.fetchRequest()
            }else{
                let alert = UIAlertController(title: "Alert", message: "password & Confirm Password Not Matched", preferredStyle: UIAlertController.Style.alert)
                           let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                             alert.addAction(ok)
                            self.present(alert, animated:true, completion: nil)
            }
            
        }else{
            let alert = UIAlertController(title: "Invalid Password", message: "Enter Valid Password", preferredStyle: UIAlertController.Style.alert)
                       let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                         alert.addAction(ok)
                        self.present(alert, animated:true, completion: nil)
        }
        
        
    }
    
}
