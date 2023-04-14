//
//  MDBService.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import Foundation
class MDBService {
    
    /**
    This is a service class for making network requests to the The Movie DB API. It contains an execute method that sends a request to the API and handles the response in a completion handler.

    The execute method takes in a MDBRequest object and a type that is expected to be returned in the response. The result of the request is returned in a completion handler that takes in a Result object that contains either the decoded response or an error.

    The request method is a private helper method that takes in a MDBRequest object and creates a URL request from it. If the URL is not valid, it returns nil.

    The MDBServiceError is an enum that defines the possible errors that can occur when making a request, including failing to create a request and failing to get data from the response.
    */
    
    enum MDBServiceError : Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    static let shared = MDBService()
    
    //MARK: Execute
    public func execute<T : Codable>(_ request : MDBRequest, expecting type : T.Type, completion : @escaping (Result<T , Error>) -> Void) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(MDBServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? MDBServiceError.failedToGetData))
                
                return
            }
            
            //Decode Response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }catch{
                completion(.failure(error))
                
            }
        }
        task.resume()
    }
    
    private func request(from rmRequest: MDBRequest) -> URLRequest?{
        guard let url = rmRequest.url else {
            return nil
        }
        var request = URLRequest(url: url)
        print(url.absoluteString)
        return request
    }
    
}

