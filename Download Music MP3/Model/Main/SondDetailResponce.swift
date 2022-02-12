//
//  SondDetailResponce.swift
//  Download Music MP3
//
//  Created by iMac on 03/02/22.
//

import Foundation

struct SongDetailResponce: Codable {
    let errorCode: Int
    let errorMsg: String
    let data: SongDetailDataModel?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode) ?? 0
        errorMsg = try values.decodeIfPresent(String.self, forKey: .errorMsg) ?? ""
        data = try values.decodeIfPresent(SongDetailDataModel.self, forKey: .data) ?? nil
    }
}

struct SongDetailDataModel: Codable {
    let type: String
    let id: Int
    var title: String
    var streamingURL: String
    let currentProfile: String

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case id, title
        case streamingURL = "streaming_url"
        case currentProfile = "current_profile"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        streamingURL = try values.decodeIfPresent(String.self, forKey: .streamingURL) ?? ""
        currentProfile = try values.decodeIfPresent(String.self, forKey: .currentProfile) ?? ""
    }
    
    init() {
        type = ""
        id = 0
        title = ""
        streamingURL = ""
        currentProfile = ""
    }
}
