//
//  RegistrationViewController.swift
//  OrderManagementApp
//
//  Created by Santosh Kumar on 31/03/21.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    
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
    
    /*-(BOOL)isValidPassword:(NSString *)passwordString
     {
         NSString *stricterFilterString = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{10,}";
         NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
         return [passwordTest evaluateWithObject:passwordString];
     }
     */
    
//    func designToolBar(_ isPrev : ){
//        let bar = UIToolbar()
//        let next = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(btnNextClicked))
//        let prev = UIBarButtonItem(title: "Prev", style: .plain, target: self, action: #selector(btnPrevClicked))
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissMyKeyboard))
//        bar.items = [next,prev,flexSpace, doneBtn]
//        bar.sizeToFit()
//        txtConfirmPasswd.inputAccessoryView = bar
//    }
    
//    @objc func dismissMyKeyboard()
//    {
//        view.endEditing(true)
//    }
//
//    @objc func btnNextClicked()
//    {
//        view.endEditing(true)
//    }

    
    @IBAction func btnLoginPageClicked(_ sender: Any) {
        let rvc:LoginViewController = LoginViewController()
        self.navigationController?.pushViewController(rvc, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == txtConfirmPasswd){
            textField.resignFirstResponder()
        }
        return true
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
            if(txtPassword == txtConfirmPasswd){
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
