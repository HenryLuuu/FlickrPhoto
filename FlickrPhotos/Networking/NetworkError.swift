//
//  NetworkError.swift
//  FlickrPhotos
//
//  Created by Henry on 2021/3/31.
//

import Foundation

enum NetworkError:Error{
    case systemError
    case noResponse
    case noData
    case decodeError(struct: String)
    case responseError(error: ErrorData, statusCode: Int)
    case refreshToken
    case retry

    var description:String{
        switch self{
        case .systemError:  return "Something's wrong :\(self.localizedDescription)"
        case .noResponse:   return "No Response"
        case .noData:       return "No Data"
        case .decodeError(let structure):  return "Decode Error with \(structure)"
        case .responseError(error: _ , statusCode: let statusCode):
                            return "Response Error , Status Code:\(statusCode) "
        case .refreshToken: return "Refresh Token!"
        case .retry: return "Retry"
        }
    }
    var errMessage:String {
        switch self {
        case .responseError(error: let error, statusCode: _ ):
            return error.error
        default:
            return self.localizedDescription
        }
    }
}

struct ErrorData:Codable{
    let error : String
}
