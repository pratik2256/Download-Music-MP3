//
//  SongDetailService.swift
//  Download Music MP3
//
//  Created by iMac on 03/02/22.
//

import Foundation

protocol SongDetailProtocol {
    func getSongDetail(_ param: SongDetailRequest, completion: @escaping (_ request: SongDetailDataModel) -> Void)
}

struct SongDetailService: SongDetailProtocol {
    func getSongDetail(_ param: SongDetailRequest, completion: @escaping (SongDetailDataModel) -> Void) {
        APIManager().POST_MULTIPART_API(api: API.SONG.songDetail, param: param.toJSON(), isShowLoader: true) { data in
            if data != nil {
                do {
                    let success = try JSONDecoder().decode(SongDetailResponce.self, from: data!)
                    switch success.errorCode {
                    case 0:
                        completion(success.data ?? SongDetailDataModel.init())
                        break
                    default :
                        displayToast(success.errorMsg)
                        break
                    }
                    
                } catch let error {
                    displayToast(error.localizedDescription)
                }
            }
        }
    }
}
