//
//  NetworkManager.swift
//  Navigation
//
//  Created by Vladislav Green on 11/22/22.
//

import Foundation


protocol URLSessionProtocol {
    
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}


protocol URLSessionDataTaskProtocol {
    
    func resume()
}



class NetworkManager {
    
    typealias completeClosure = ( _ data: Data?, _ error: Error?) -> Void
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    
    func get( url: URL, callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
}


extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}







//struct NetworkManager {
//
//    static func request(for configuration: AppConfiguration) {
//
//        let link = configuration.rawValue
//
//        let sessionConfiguration = URLSessionConfiguration.default
//        let urlSession = URLSession(configuration: sessionConfiguration)
//
//        if let url = URL(string: link) {
//
//            let request = URLRequest(url: url)
//            let task = urlSession.dataTask(with: request, completionHandler: { data, response, error in
//
//                if let unwrappedData = data {
//                    let parsedData = String(data: unwrappedData, encoding: .utf8)
////                    print("Data: \(String(describing: parsedData))")
//                }
//
//                if let castedResponse = response as? HTTPURLResponse {
////                    print("Response .allHeaderFields: \(castedResponse.allHeaderFields)")
////                    print("Response .statusCode: \(castedResponse.statusCode)")
//                }
//
////                print("Error: \(String(describing: error))")
//                // Код ошибки если отключить интернет: -1009:
//            })
//            task.resume()
//        }
//    }
//}
//
//enum AppConfiguration: String, CaseIterable {
//    case link01 = "https://swapi.dev/api/people/8"
//    case link02 = "https://swapi.dev/api/starships/3"
//    case link03 = "https://swapi.dev/api/planets/5"
//}
//
//
