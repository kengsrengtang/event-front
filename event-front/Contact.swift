//
//  Contact.swift
//  event-front
//
//  Created by kengsrengtang on 8/3/15.
//  Copyright (c) 2015 event. All rights reserved.
//

import Foundation
class Contac: NSObject {
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
    var age: Int
    
    init(firstName:String, lastName:String, phoneNumber:String, email:String, age:Int){
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
        self.age = age
        
        super.init()
        
    }
}
