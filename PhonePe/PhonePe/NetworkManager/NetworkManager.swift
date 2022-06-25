//
//  NetworkManager.swift
//  PhonePe
//
//  Created by Shubham JAIn on 25/06/22.
//

import Foundation

enum RequestMethodType : String {
    case get = "GET"
    case post = "POST"
}

struct NetworkKeys {
    static let basePath = "https://api.themoviedb.org/3/movie/"
    static let apiKey = "api_key"
    static let apiKeyValue = "38a73d59546aa378980a88b645f487fc"
    static let imageBasePath = "https://image.tmdb.org/t/p/w500"

}

class NetworkManager {
    
    static func makeRequest(endPoint: String,
                            requestMethod: String = RequestMethodType.get.rawValue,
                            queryParams: [URLQueryItem]?,
                            isQueryParms: Bool = false) -> URLRequest? {
        
        let getBaseURL = NetworkKeys.basePath + endPoint
        guard var customURL = URLComponents(string: getBaseURL) else { return nil }
        if isQueryParms {
            if let params = queryParams {
                customURL.queryItems = params
            }
        }
        guard let customURL = customURL.url else { return nil }
        var request = URLRequest(url: customURL)
        request.httpMethod = requestMethod
        return request
    }
    
    
    static func processRequestForResponse<T: Decodable>(_ modelType: T.Type,
                                                        request: URLRequest,
                                                        completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(modelType, from: data) {
                    completion(.success(model))
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
