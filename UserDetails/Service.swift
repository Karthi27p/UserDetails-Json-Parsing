//
//  Service.swift
//  UserDetails
//
//  Created by TRINGAPPS on 02/02/19.
//  Copyright © 2019 TRINGAPPS. All rights reserved.
//

import UIKit
import Foundation

enum BackEndError : Error {
    case ulrError(reason: String)
    case serializationError(reason: String)
}

struct Service {
    static func apiServiceRequest<T> (requestUrl: URLRequest?, resultStruct: T.Type, completion: @escaping((Any?, Error?) -> ())) where T : Decodable {
        guard let apiRequestUrl = requestUrl, let _ = apiRequestUrl.url else {
           completion(nil, BackEndError.ulrError(reason: "Url Error"))
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: apiRequestUrl) { (data, response, error) in
            guard let responseData = data else {
                completion(nil, BackEndError.serializationError(reason: "SerailaizationError"))
                return
            }
            let decoder = JSONDecoder()
            do {
               let decodedJson = try decoder.decode(resultStruct, from: responseData)
                DispatchQueue.main.async {
                    completion(decodedJson, nil)
                }
            }
            catch {
                completion(nil, error)
            }
        }
        task.resume()
        }
}
