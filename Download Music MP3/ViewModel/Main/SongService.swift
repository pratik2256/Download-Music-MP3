//
//  SongService.swift
//  Download Music MP3
//
//  Created by iMac on 03/02/22.
//

import Foundation

protocol SongServiceProtocol {
    func getSongList(_ isShowLoader: Bool, _ param: SongRequest, completion: @escaping (_ request: [SongDataModel]) -> Void)
}

struct SongService: SongServiceProtocol {
    func getSongList(_ isShowLoader: Bool, _ param: SongRequest, completion: @escaping ([SongDataModel]) -> Void) {
        APIManager().POST_MULTIPART_API(api: API.SONG.search, param: param.toJSON(), isShowLoader: isShowLoader) { data in
            if data != nil {
                do {
                    let success = try JSONDecoder().decode(SongResponce.self, from: data!)
                    switch success.errorCode {
                    case 0:
                        completion(success.data ?? [SongDataModel]())
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
