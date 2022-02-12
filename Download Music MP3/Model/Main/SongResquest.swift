//
//  SongResquest.swift
//  Download Music MP3
//
//  Created by iMac on 03/02/22.
//

import Foundation

struct SongRequest: Encodable {
    var offset, limit: String
    var keyword, type: String
}

struct SongDetailRequest: Encodable {
    var profile_id, id: String
}
