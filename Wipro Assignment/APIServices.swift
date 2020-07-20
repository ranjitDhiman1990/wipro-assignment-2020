//
//  APIServices.swift
//  Wipro Assignment
//
//  Created by Dhiman Ranjit on 20/07/20.
//  Copyright © 2020 Dhiman Ranjit. All rights reserved.
//

import Foundation

typealias GetFactsDetailsCompletion = (Result<FactDetails>) -> Void

protocol APIServicesProtocol: class {
    func getFactDetails(completion: @escaping GetFactsDetailsCompletion)
}

final class APIServices: APIServicesProtocol {
    static let shared = APIServices()
    
    func getFactDetails(completion: @escaping GetFactsDetailsCompletion) {
        let session = URLSession.shared
        guard let url = URL(string: apiURL) else {
            completion(.failure(.wrongURLFormatError))
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                completion(.failure(.responseMissingError))
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                completion(.failure(.serverError))
                return
            }

            let str = String(decoding: data!, as: UTF8.self)
            print(str)
            let jsonData = Data(str.utf8)
            do {
                let factDetails = try JSONDecoder().decode(FactDetails.self, from: jsonData)
                completion(.success(factDetails))
            } catch {
                print("JSON error: \(error.localizedDescription)")
                completion(.failure(.jsonParsingError))
            }
        }

        task.resume()
    }
}


enum Result<Value> {
    case success(Value)
    case failure(APIError)

    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
}


struct APIError: Error {
    // Error status code
    let code: Int
    // Error Message
    let message: String

    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
    
    
    static var wrongURLFormatError: APIError {
        return APIError(code: -1, message: "Wrong url format")
    }
    
    static var jsonParsingError: APIError {
        return APIError(code: -2, message: "JSON parsing error")
    }
    
    static var responseMissingError: APIError {
        return APIError(code: -3, message: "Response data missing error")
    }
    
    static var serverError: APIError {
        return APIError(code: -4, message: "Response data missing error")
    }
}
