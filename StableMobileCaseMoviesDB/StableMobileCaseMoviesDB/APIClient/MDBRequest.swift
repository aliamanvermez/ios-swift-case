//
//  MDBRequest.swift
//  StableMobileCaseMoviesDB
//
//  Created by Ali Amanvermez on 10.04.2023.
//

import Foundation
class MDBRequest {
    
    func requestPopularTvShows(completion : @escaping (MDBPopularShowResponse? , Error?) -> ()) {
        let request = NSMutableURLRequest(url: NSURL(string: MDBEndpoint.popularTvShows(page: 1).url.absoluteString)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error?.localizedDescription as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse?.statusCode as Any)
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let models  = try decoder.decode(MDBPopularShowResponse.self, from: data)
                        completion(models,nil)
                        print(models.results)
                        
                    }catch{
                        print(error.localizedDescription)
                        completion(nil, MDBServiceError.noData)
                        print(request.url?.absoluteString)

                    }
                }
            }
        })
        dataTask.resume()
    }
}

