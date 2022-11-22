//
//  NetworkManager.swift
//  Navigation
//
//  Created by Vladislav Green on 11/22/22.
//

import Foundation

struct NetworkManager {
    
    static func request(for configuration: AppConfiguration) {
        let currentConfiguration = configuration
        
//        switch currentConfiguration {
//        case .URL01:
//            address = currentConfiguration.rawValue
//        case .URL02:
//            address = currentConfiguration.rawValue
//        case .URL03:
//            address = currentConfiguration.rawValue
//        }
        // Очевидно, switch не нужен при данном решении задачи
        
        let link = currentConfiguration.rawValue

        let configuration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: configuration)
        
        if let url = URL(string: link) {
            
            let request = URLRequest(url: url)
            let task = urlSession.dataTask(with: request, completionHandler: { data, response, error in
                
                if let unwrappedData = data {
                    let parsedData = String(data: unwrappedData, encoding: .utf8)
                    print("Data: \(String(describing: parsedData))")
                }
                
                if let castedResponse = response as? HTTPURLResponse {
                    print("Response .allHeaderFields: \(castedResponse.allHeaderFields)")
                    print("Response .statusCode: \(castedResponse.statusCode)")
                }
                
                print("Error: \(String(describing: error))")
                // Код ошибки если отключить интернет: -1009:
            })
            task.resume()
        }
    }
}

enum AppConfiguration: String, CaseIterable {
    case link01 = "https://swapi.dev/api/people/8"
    case link02 = "https://swapi.dev/api/starships/3"
    case link03 = "https://swapi.dev/api/planets/5"
}


