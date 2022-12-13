//
//  RealmManager.swift
//  Navigation
//
//  Created by Vladislav Green on 12/13/22.
//

import Foundation
import RealmSwift

class RealmManager {
    
    var realm = try! Realm()
    var usersRealm: [UserRealm] = []
    
    func saveUserRealm(login: String, password: String) {
        try! realm.write {
            let userRealm = UserRealm(userRealmName: login, userRealmPassword: password)
            realm.add(userRealm)
        }
        loadUserRealm()
    }
    
    func loadUserRealm() {
        usersRealm = Array(realm.objects(UserRealm.self))
    }
    
    func clearUsersRealm() {
        try! realm.write {
            realm.deleteAll()
        }
    }

    
}
