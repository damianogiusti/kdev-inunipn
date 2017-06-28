//
//  RestCapable.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Alamofire
import Alamofire_Synchronous
import SwiftyJSON

enum RestError: Error {
    case apiError
}

protocol RestCapable: class {

    func buildParameters(fromDictionary dict: [String: Any]?) -> Alamofire.Parameters?

    func getRestCall(toUrl url: String, withParams parameters: Alamofire.Parameters?, token: String?,
                     onSuccess: @escaping SuccessBlock<JSON>, onError: @escaping ErrorBlock)

    func getRestCall(toUrl url: String, withParams parameters: Alamofire.Parameters?, token: String?) -> DataResponse<JSON>

    func postRestCall(toUrl url: String, withParams parameters: Alamofire.Parameters?, token: String?,
                      onSuccess: @escaping SuccessBlock<JSON>, onError: @escaping ErrorBlock)

    func postRestCall(toUrl url: String, withParams parameters: Alamofire.Parameters?, token: String?) -> DataResponse<JSON>

}

extension RestCapable {

    func buildParameters(fromDictionary dict: [String: Any]?) -> Alamofire.Parameters? {
        var params: Alamofire.Parameters? = [:]
        dict?.keys.forEach({ key in
            params?[key] = dict?[key]
        })
        return params
    }

    private func buildHeaders(token: String?) -> [String: String]? {
        if let token = token {
            return ["Authorization": "Bearer \(token)"]
        }
        return nil
    }

    func getRestCall(toUrl url: String, withParams parameters: Alamofire.Parameters?, token: String? = nil,
                     onSuccess: @escaping SuccessBlock<JSON>, onError: @escaping ErrorBlock) {

        let headers = buildHeaders(token: token)

        Alamofire.request(url,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: headers)
            .validate()
            .responseJSON { (response) in
                if let error = response.error {
                    onError(error)
                } else if let data = response.data {
                    onSuccess(JSON(data: data))
                }
        }

    }


    func getRestCall(toUrl url: String, withParams parameters: Alamofire.Parameters?, token: String? = nil) -> DataResponse<JSON> {
        let headers = buildHeaders(token: token)
        let response = Alamofire
            .request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .responseJSON()
        if let error = response.error {
            return DataResponse(withError: error)
        } else if let data = response.data {
            return DataResponse(withData: JSON(data: data))
        }
        return DataResponse(withError: RestError.apiError)
    }


    func postRestCall(toUrl url: String, withParams parameters: Alamofire.Parameters?, token: String? = nil,
                      onSuccess: @escaping SuccessBlock<JSON>, onError: @escaping ErrorBlock) {

        let headers = buildHeaders(token: token)
        Alamofire.request(url,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: headers)
            .validate()
            .responseJSON { (response) in
                if let error = response.error {
                    onError(error)
                } else if let data = response.data {
                    onSuccess(JSON(data: data))
                }
        }
    }


    func postRestCall(toUrl url: String, withParams parameters: Alamofire.Parameters?, token: String? = nil) -> DataResponse<JSON> {
        let headers = buildHeaders(token: token)
        let response = Alamofire
            .request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .responseJSON()
        if let error = response.error {
            return DataResponse(withError: error)
        } else if let data = response.data {
            return DataResponse(withData: JSON(data: data))
        }
        return DataResponse(withError: RestError.apiError)
    }
}
