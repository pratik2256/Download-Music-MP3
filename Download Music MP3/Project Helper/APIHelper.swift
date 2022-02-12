//
//  APIHelper.swift
//  Download Music MP3
//
//  Created by iMac on 02/02/22.
//

import Foundation

struct API {
    
    let BASIC_URL = ""
    
    struct ADS {
        static let liveAds      = "https://text.iphoneapppanel.cyou/api/ads" // Test
        // static let liveAds     = "https://text.hirededicated.com/api/ads/appads" // Live
    }
    
    struct SONG {
        static let BASE_URL     = "http://api.nhac.vn/client/"
        static let search       = BASE_URL + "search"
        static let songDetail   = BASE_URL + "song/listen"
    }
    
}
