//
//  APIMethod.swift
//  FlickrPhotos
//
//  Created by Henry on 2021/3/31.
//

import UIKit

extension NetworkManager {
    public func searchFlicker(text searchText: String, perPage: Int, page: Int, completion: @escaping (Result<SearchData,NetworkError>) -> Void) {
        guard let request = Request(requestMethod: .get, urlString: String(format: base_url, searchText, perPage, page)) else {return}
        
        sendRequest(request) { (result:Result<SearchData,NetworkError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
