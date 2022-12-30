//
//  RealmModel.swift
//  Navigation
//
//  Created by Vladislav Green on 12/13/22.
//

import Foundation
import RealmSwift

class UserRealm: Object {
    
//    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var userRealmName: String
    @Persisted var userRealmPassword: String
    
    convenience init(userRealmName: String, userRealmPassword: String) {
        self.init()
        self.userRealmName = userRealmName
        self.userRealmPassword = userRealmPassword
    }
}
