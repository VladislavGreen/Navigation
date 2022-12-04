//
//  User.swift
//  Navigation
//
//  Created by Vladislav Green on 10/11/22.
//

import UIKit

public class User {
    
    public var userLogin: String
    public var userFullName: String
    public var userAvatar: UIImage
    public var userStatus: String
    
    public init(
        userLogin: String,
        userFullName: String,
        userAvatar: UIImage,
        userStatus: String
    ) {
        self.userLogin = userLogin
        self.userFullName = userFullName
        self.userAvatar = userAvatar
        self.userStatus = userStatus
    }
}


