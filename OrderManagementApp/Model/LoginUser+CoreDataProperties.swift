//
//  LoginUser+CoreDataProperties.swift
//  OrderManagementApp
//
//  Created by Santosh Kumar on 31/03/21.
//
//

import Foundation
import CoreData


extension LoginUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginUser> {
        return NSFetchRequest<LoginUser>(entityName: "LoginUser")
    }

    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var order: NSSet?

}

// MARK: Generated accessors for order
extension LoginUser {

    @objc(addOrderObject:)
    @NSManaged public func addToOrder(_ value: Order)

    @objc(removeOrderObject:)
    @NSManaged public func removeFromOrder(_ value: Order)

    @objc(addOrder:)
    @NSManaged public func addToOrder(_ values: NSSet)

    @objc(removeOrder:)
    @NSManaged public func removeFromOrder(_ values: NSSet)

}

extension LoginUser : Identifiable {

}
