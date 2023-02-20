//
//  RealmManager.swift
//  Navigation
//
//  Created by Vladislav Green on 12/13/22.
//

import RealmSwift


class RealmManager {
    
    var usersRealm: [UserRealm] = []
    
    
    func saveUserRealm(login: String, password: String, realm: Realm) {

        do {
            try realm.write {
                let userRealm = UserRealm(userRealmName: login, userRealmPassword: password)
                realm.add(userRealm)
            }
        } catch {
            print("Error writing to Realm database")
        }
        loadUserRealm(realm: realm)
    }
    
    
    func loadUserRealm(realm: Realm) {
        usersRealm = Array(realm.objects(UserRealm.self))
    }
    
    
    func clearUsersRealm() {
        print("The feature was depricated")
//        try! realm.write {
//            realm.deleteAll()
//        }
    }
}
