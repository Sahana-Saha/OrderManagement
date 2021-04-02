//
//  DisplayOrdersViewController.swift
//  OrderManagementApp
//
//  Created by Santosh Kumar on 31/03/21.
//

import UIKit

class DisplayOrdersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{

    @IBOutlet weak var orderTblVw: UITableView!
    @IBOutlet weak var txtOrderNumber1: UITextField!
    @IBOutlet weak var txtOrderDueDate1: UITextField!
    @IBOutlet weak var txtCustomerName: UITextField!
    @IBOutlet weak var txtCustomerPhone: UITextField!
    @IBOutlet weak var txtAdress: UITextView!
    @IBOutlet weak var txtOrderTotal1: UITextField!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var popUpSubVw: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    var dateSelected = String()
    
    var isEditClicked : Bool = false
    var arrUsers : [LoginUser] = []
    var orders : [Order] = []
    var rowIndex : Int = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpSubVw.layer.cornerRadius = 8
        
        btnEdit.backgroundColor = UIColor.white
        btnEdit.layer.cornerRadius = 5.0
        btnEdit.layer.shadowOpacity = 0.2
        btnEdit.layer.shadowRadius = 3.0
        btnEdit.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        btnCancel.backgroundColor = UIColor.white
        btnCancel.layer.cornerRadius = 5.0
        btnCancel.layer.shadowOpacity = 0.2
        btnCancel.layer.shadowRadius = 3.0
        btnCancel.layer.shadowOffset = CGSize(width: 0, height: 0)
        let nib = UINib(nibName: "OrderTableViewCell", bundle: nil)
        orderTblVw.register(nib, forCellReuseIdentifier: "VwCell")
        showDatePicker()
        popUpView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    @objc func dismissMyKeyboard()
    {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchRequest()
    }
    
    
    func fetchRequest(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        do{
            arrUsers = try context.fetch(LoginUser.fetchRequest())
            if(arrUsers.count > 0){
                for user in arrUsers{
                    if(user.name == appDelegate.userName){
                        let arrList = user.order?.allObjects
                            if let orderList = arrList as? [Order]{
                                self.orders = orderList
                                DispatchQueue.main.async {
                                self.orderTblVw.reloadData()
                            }
                        }
                    }
                }
            }else{
//
            }
        }
        catch{
            
        }
        }
    
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
//        datePicker.frame = CGRect(x: 10, y: 50, width: self.view.frame.width, height: 200)
       //ToolBar
       let toolbar = UIToolbar();
       toolbar.sizeToFit()
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

     toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

      txtOrderDueDate1.inputAccessoryView = toolbar
        txtOrderDueDate1.inputView = datePicker

     }
    

      @objc func donedatePicker(){

       let formatter = DateFormatter()
       formatter.dateFormat = "dd/MM/yyyy"
        txtOrderDueDate1.text = formatter.string(from: datePicker.date)
       self.view.endEditing(true)
     }

     @objc func cancelDatePicker(){
        self.view.endEditing(true)
      }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if(textField.tag == 501){
            self.view.endEditing(true)
           
            self.view.addSubview(datePicker)
            self.view.addSubview(toolBar)
        }
        
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.tag == 500){
            textField.resignFirstResponder()
            let txtFld = self.view.viewWithTag(501) as! UITextField
            txtFld.becomeFirstResponder()
        }
        else if(textField.tag == 501){
            textField.resignFirstResponder()
            let txtFld = self.view.viewWithTag(502) as! UITextField
            txtFld.becomeFirstResponder()
        }
        else if(textField.tag == 502){
            textField.resignFirstResponder()
            let txtFld = self.view.viewWithTag(503) as! UITextField
            txtFld.becomeFirstResponder()
        }
        else if(textField.tag == 503){
            textField.resignFirstResponder()
            let txtFld = self.view.viewWithTag(504) as! UITextView
            txtFld.becomeFirstResponder()
        }
        
        return true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderTableViewCell = orderTblVw.dequeueReusableCell(withIdentifier: "VwCell") as! OrderTableViewCell
        if(cell != nil){
            let vwOrder = orders[indexPath.row]
            cell.txtOrderNumber.text = vwOrder.orderNumber
            cell.txtOrderDueDate.text = vwOrder.orderDueDate
            cell.txtCustomerName.text = vwOrder.customerName
            cell.txtCustomerPhone.text = vwOrder.customerPhone
            cell.txtCustomerAddress.text = vwOrder.customerAddress
            cell.txtOrderTotal.text = "\(vwOrder.orderTotal)"
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (editingStyle == .delete) {
            do{
                arrUsers = try context.fetch(LoginUser.fetchRequest())
                if(arrUsers.count > 0){
                    for user in arrUsers{
                        if user.name == appDelegate.userName{
                            let arrList = user.order?.allObjects
                                if let orderList = arrList as? [Order]{
                                    let orderSelect = orderList[indexPath.row]
                                    self.context.delete(orderSelect)
                                    do{
                                        try self.context.save()
                                        
                                    }catch{
                                        
                                    }
                            }
                        }
                        
                    }
                    popUpView.isHidden = true
                fetchRequest()
                    
                }else{
    //
                }
            }
            catch{
                
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        popUpView.isHidden = false
        isEditClicked = true
        
        btnEdit.setTitle("Edit", for: .normal)
        rowIndex = indexPath.row
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        do{
            arrUsers = try context.fetch(LoginUser.fetchRequest())
            if(arrUsers.count > 0){
                for user in arrUsers{
                    if user.name == appDelegate.userName{
                        let arrList = user.order?.allObjects
                        DispatchQueue.main.async {
                            
                            if let orderList = arrList as? [Order]{
                                self.orders = orderList
                                self.txtOrderNumber1.text = self.orders[indexPath.row].orderNumber
                                self.txtOrderDueDate1.text = self.orders[indexPath.row].orderDueDate
                                self.txtCustomerName.text = self.orders[indexPath.row].customerName
                                self.txtAdress.text = self.orders[indexPath.row].customerAddress
                                self.txtCustomerPhone.text = self.orders[indexPath.row].customerPhone
                                self.txtOrderTotal1.text = "\(self.orders[indexPath.row].orderTotal)"
                            }
                        }
                    }
                    
                }
                
            }else{
//
            }
        }
        catch{
            
        }
    }
    
    
    @IBAction func btnEditClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(isEditClicked){
            do{
                arrUsers = try context.fetch(LoginUser.fetchRequest())
                if(arrUsers.count > 0){
                    for user in arrUsers{
                        if user.name == appDelegate.userName{
                            let arrList = user.order?.allObjects
                                if let orderList = arrList as? [Order]{
                                    orderList[rowIndex].orderNumber = txtOrderNumber1.text
                                    orderList[rowIndex].orderDueDate = txtOrderDueDate1.text
                                    orderList[rowIndex].customerName = txtCustomerName.text
                                    orderList[rowIndex].customerAddress = txtAdress.text
                                    orderList[rowIndex].customerPhone = txtCustomerPhone.text
                                    let totalOrder = txtOrderTotal1.text! as NSString
                                    orderList[rowIndex].orderTotal = totalOrder.doubleValue
                                    
                                    do{
                                        try self.context.save()
                                        
                                        
                                    }catch{
                                        
                                    }
                            }
                        }
                        
                    }
                    popUpView.isHidden = true
                fetchRequest()
                    
                }else{
    //
                }
            }
            catch{
                
            }
        
        }else{
            
            let order = Order(context: self.context)
            order.orderNumber = txtOrderNumber1.text
            order.orderDueDate = txtOrderDueDate1.text
            order.customerName = txtCustomerName.text
            order.customerAddress = txtAdress.text
            order.customerPhone = txtCustomerPhone.text
            let totalOrder = txtOrderTotal1.text! as NSString
            order.orderTotal = totalOrder.doubleValue
            for user in arrUsers{
                if(user.name == appDelegate.userName){
                    user.addToOrder(order)
                    do{
                        try self.context.save()
                    }
                    catch{
                        print("error")
                    }
                }
            }
            popUpView.isHidden = true
            fetchRequest()
        }
    }
    

    @IBAction func btnCancelClicked(_ sender: Any) {
        isEditClicked = false
        popUpView.isHidden = true
    }
    
    
    @IBAction func btnBGClicked(_ sender: Any) {
        popUpView.isHidden = true
        
    }
    
    
    @IBAction func btnNewClicked(_ sender: Any) {
        popUpView.isHidden = false
        isEditClicked = false
        btnEdit.setTitle("Add", for: .normal)
        txtOrderNumber1.placeholder = "Enter Order Number"
        txtOrderDueDate1.placeholder = "Enter Order Due Date"
        txtCustomerName.placeholder = "Enter CustomerName"
        txtAdress.text = "Enter Adress"
        txtCustomerPhone.placeholder = "Enter Phone"
                
    }
    
    
    
    
    
}
