//
//  Order+CoreDataProperties.swift
//  OrderManagementApp
//
//  Created by Santosh Kumar on 31/03/21.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var orderTotal: Double
    @NSManaged public var customerPhone: String?
    @NSManaged public var customerAddress: String?
    @NSManaged public var customerName: String?
    @NSManaged public var orderDueDate: String?
    @NSManaged public var orderNumber: String?
    @NSManaged public var user: LoginUser?

}

extension Order : Identifiable {

}
