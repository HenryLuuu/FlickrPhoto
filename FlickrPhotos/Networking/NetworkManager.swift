//
//  NetworkManager.swift
//  FlickrPhotos
//
//  Created by Henry on 2021/3/31.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    
    func fetchPicture(theType: String, theNumber: Int, completionHandler: @escaping (_ flickrDatas: [FlickrData]) -> Void) {
        let urlString = String(format: base_url, theType, theNumber)
        
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(SearchData.self, from: safeData)
                        print(decodedData.photos.photo)
                        completionHandler(decodedData.photos.photo)
                    } catch {
                        print(error)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    public func sendRequest<T: Codable>(_ request: Request, completion: @escaping (Result<T,NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    completion(.failure(.systemError))
                }
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.noResponse))
                        return
                }
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                self.responseHandler(data: data, response: response, completion: completion)
            }
        }.resume()
    }
    
    private func responseHandler<T: Codable> (data:Data, response:HTTPURLResponse, completion:@escaping (Result<T,NetworkError>) -> Void) {
        switch response.statusCode {
        case 200 ... 299:
            do{
                let decotedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decotedData))
                print("====== \(T.self) success =======")
            }catch{
                print(error,"statuscode:\(response.statusCode)")
                completion(.failure(.decodeError(struct: "\(T.self)")))
            }
        default:
            do{
                let decodedError = try JSONDecoder().decode(ErrorData.self, from: data)
                completion(.failure(.responseError(error: decodedError, statusCode: response.statusCode)))
            }catch{
                print("錯誤訊息decode失敗,status code:\(response.statusCode)")
                completion(.failure(.decodeError(struct: "\(ErrorData.self)")))
            }
        }
    }
}
