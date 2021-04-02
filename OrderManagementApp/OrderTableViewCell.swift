//
//  OrderTableViewCell.swift
//  OrderManagementApp
//
//  Created by Santosh Kumar on 31/03/21.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var lblOrder: UILabel!
    @IBOutlet weak var lblOrderDueDate: UILabel!
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblCustomerPhone: UILabel!
    @IBOutlet weak var lblCustomerAddress: UILabel!
    @IBOutlet weak var lblOrderTotal: UILabel!
    @IBOutlet weak var txtOrderNumber: UITextField!
    @IBOutlet weak var txtOrderDueDate: UITextField!
    @IBOutlet weak var txtCustomerName: UITextField!
    @IBOutlet weak var txtCustomerPhone: UITextField!
    @IBOutlet weak var txtCustomerAddress: UITextView!
    @IBOutlet weak var txtOrderTotal: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vwMain.backgroundColor = UIColor.white
        vwMain.isUserInteractionEnabled = true
        vwMain.layer.cornerRadius = 5.0
        vwMain.layer.shadowOpacity = 0.5
        vwMain.layer.shadowRadius = 5.0
        vwMain.layer.shadowOffset = CGSize(width: 0, height: 0)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
