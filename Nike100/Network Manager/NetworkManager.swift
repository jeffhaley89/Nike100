//
//  NetworkManager.swift
//  Nike100
//
//  Created by Jeffrey Haley on 9/19/19.
//  Copyright © 2019 Jeffrey Haley. All rights reserved.
//

import Foundation

class NetworkManager {

    enum NetworkManagerError {
        case deserializationError(Error)
        case unexpectedResponse
        case unknown(Error)
    }
    
    enum Result<T> {
        case success(T)
        case failure(NetworkManagerError)
    }
    
    static func get<T: Decodable>(_ url: URL, objectType: T.Type, completionHandler: @escaping (Result<T>) -> ()) {
        let session = URLSession.shared
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            if let err = error {
                completionHandler(Result.failure(NetworkManagerError.unknown(err)))
                return
            }
            guard let data = data else {
                completionHandler(Result.failure(NetworkManagerError.unexpectedResponse))
                return
            }
            do {
                let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                completionHandler(Result.success(decodedObject))
            } catch let error {
                completionHandler(Result.failure(NetworkManagerError.deserializationError(error)))
            }
        })
        task.resume()
    }
}
