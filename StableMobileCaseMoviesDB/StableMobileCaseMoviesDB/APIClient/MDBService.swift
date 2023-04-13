//
//  MDBService.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import Foundation

class MDBService {
    
    enum MDBServiceError : Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    static let shared = MDBService()
    
    
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
    
    
    
    
//    func requestPopularTvShows(completion : @escaping (MDBPopularShowResponse? , Error?) -> ()) {
//        let request = NSMutableURLRequest(url: NSURL(string: MDBRequest.popularTvShows(page: 34).url.absoluteString)! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error?.localizedDescription as Any)
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse?.statusCode as Any)
//                let decoder = JSONDecoder()
//                if let data = data {
//                    do {
//                        let models  = try decoder.decode(MDBPopularShowResponse.self, from: data)
//                        completion(models,nil)
//                    }catch{
//                        print(error.localizedDescription)
//                        completion(nil, MDBServiceError.noData)
//
//
//                    }
//                }
//            }
//        })
//        dataTask.resume()
//    }
    

//
//    func requestTvShowDetails(for showID: Int?, completion: @escaping (MDBTvShowDetail?, Error?) -> ()) {
//        let request = NSMutableURLRequest(url: NSURL(string: MDBRequest.tvShowDetails(showID: showID!).url.absoluteString)! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error?.localizedDescription as Any)
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse?.statusCode as Any)
//                let decoder = JSONDecoder()
//
//
//
//                if let data = data {
//                    do {
//                        let decodeObject = try MDBRequest.decode(MDBTvShowDetail.self, data: data)
//
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//        })
//        dataTask.resume()
//    }
    
    
//    func decode<T : Codable>(_ type : T.Type, data : Data)  -> T? {
//        do{
//            let response = try JSONDecoder().decode(type, from: data)
//            return response
//        }catch let error{
//            print(error.localizedDescription)
//        }
//        return nil
//    }
    
}

