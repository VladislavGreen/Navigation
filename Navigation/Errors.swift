//
//  Errors.swift
//  Navigation
//
//  Created by Vladislav Green on 11/9/22.
//

enum ImageProcessingTimeOut: Error {
    case tooSlow
}

extension ImageProcessingTimeOut: CustomStringConvertible {
    public var description: String {
        switch self {
        case .tooSlow:
            return "It's still too slow. Try to adjust QOS"
        }
    }
}

enum AuthorizationError: Error {
    case invalidLogin
    case invalidPassword
}

extension AuthorizationError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidLogin:
            return "Invalid Login"
        case .invalidPassword:
            return "Invalid Password"
        }
    }
}
