//
//  RestCapable.swift
//  InUniPn
//
//  Created by Damiano Giusti on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Alamofire
import SwiftyJSON

protocol RestCapable: class {

    func buildParameters(fromDictionary dict: [String: Any]?) -> Alamofire.Parameters?

    func getRestCall(toUrl url: String, withParams parameters: Alamofire.Parameters?,
                     onSuccess: @escaping SuccessBlock<JSON>, onError: @escaping ErrorBlock)

    func postRestCall(toUrl url: String, withParams parameters: Alamofire.Parameters?,
                      onSuccess: @escaping SuccessBlock<JSON>, onError: @escaping ErrorBlock)

}

extension RestCapable {

    func buildParameters(fromDictionary dict: [String: Any]?) -> Alamofire.Parameters? {
        var params: Alamofire.Parameters? = [:]
        dict?.keys.forEach({ key in
            params?[key] = dict?[key]
        })
        return params
    }


    func getRestCall(toUrl url: String, withParams parameters: Alamofire.Parameters?,
                     onSuccess: @escaping SuccessBlock<JSON>, onError: @escaping ErrorBlock) {

        Alamofire.request(url,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default)
            .validate()
            .responseJSON { (response) in
                if let error = response.error {
                    onError(error)
                } else if let data = response.data {
                    onSuccess(JSON(data: data))
                }
        }

    }


    func postRestCall(toUrl url: String, withParams parameters: Alamofire.Parameters?,
                      onSuccess: @escaping SuccessBlock<JSON>, onError: @escaping ErrorBlock) {

        Alamofire.request(url,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default)
            .validate()
            .responseJSON { (response) in
                if let error = response.error {
                    onError(error)
                } else if let data = response.data {
                    onSuccess(JSON(data: data))
                }
        }
    }
}
