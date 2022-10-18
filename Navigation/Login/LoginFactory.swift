//
//  LoginFactory.swift
//  Navigation
//
//  Created by Vladislav Green on 10/17/22.
//

protocol LoginFactory {
    
    func makeLoginInspector() -> LoginInspector
    
}


struct MyLoginFactory: LoginFactory {
    
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
    
}
