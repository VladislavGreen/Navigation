//
//  UserTestModel.swift
//  Navigation
//
//  Created by Vladislav Green on 10/12/22.
//

import UIKit


 // Временное решение для хранения данных пользователей

public var userDefault: User = {
    let user = User(
    userLogin: "123",
    userFullName: "no user",
    userAvatar: UIImage(systemName: "person.fill")!,
    userStatus: "no data")
    return user
}()

//private var userCat: User = {
//    let cat = User(
//    userLogin: "cat",
//    userFullName: "Waiter Cat",
//    userAvatar: UIImage(named: "cat")!,
//    userStatus: "Waiting and waiting")
//    return cat
//}()

private var userAdmin: User = {
    let cat = User(
    userLogin: "",
    userFullName: "Admin Cat",
    userAvatar: UIImage(named: "cat")!,
    userStatus: "Admin is waiting")
    return cat
}()

public var usersBase: [User] = [userAdmin]
    

