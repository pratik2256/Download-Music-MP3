//
//  AdsService.swift
//  Download Music MP3
//
//  Created by iMac on 02/02/22.
//

import Foundation

protocol AdsServiceProtocol {
    func getAds(_ param: [String: Any], completion: @escaping (_ request: AdsDataModel) -> Void)
}

struct AdsService: AdsServiceProtocol {
    func getAds(_ param: [String : Any], completion: @escaping (AdsDataModel) -> Void) {
        APIManager().POST_MULTIPART_API(api: API.ADS.liveAds, param: param, isShowLoader: true) { data in
            if data != nil {
                do {
                    let success = try JSONDecoder().decode(AdsResponce.self, from: data!)
                    switch success.status {
                    case "success":
                        completion(success.data ?? AdsDataModel.init())
                        break
                    default :
                        displayToast("Error")
                        break
                    }
                    
                } catch let error {
                    displayToast(error.localizedDescription)
                }
            }
        }
    }
}
