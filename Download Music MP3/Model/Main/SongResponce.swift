//
//  SongResponce.swift
//  Download Music MP3
//
//  Created by iMac on 03/02/22.
//

import Foundation

struct SongResponce: Codable {
    let errorCode: Int
    let errorMsg: String
    let data: [SongDataModel]?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode) ?? 0
        errorMsg = try values.decodeIfPresent(String.self, forKey: .errorMsg) ?? ""
        data = try values.decodeIfPresent([SongDataModel].self, forKey: .data) ?? nil
    }
}

struct SongDataModel: Codable {
    let type: String
    let id: Int
    let title, artistID: String
    let imageURL, imageURLLarge: String
    let artistTitle: String
    let videoID: Int
    let activeMessage: String
    let shareMessage: String
    let blockDownload, blockView: Int
    let rbtSMS: String
    let rbtHost: Int
    let messageBlock: String
    let youtubeStatusRaw, youtubeStatusEmbed: Int

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case id, title
        case artistID = "artist_id"
        case imageURL = "image_url"
        case imageURLLarge = "image_url_large"
        case artistTitle = "artist_title"
        case videoID = "video_id"
        case activeMessage = "active_message"
        case shareMessage = "share_message"
        case blockDownload = "block_download"
        case blockView = "block_view"
        case rbtSMS = "rbt_sms"
        case rbtHost = "rbt_host"
        case messageBlock = "message_block"
        case youtubeStatusRaw = "youtube_status_raw"
        case youtubeStatusEmbed = "youtube_status_embed"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        artistID = try values.decodeIfPresent(String.self, forKey: .artistID) ?? ""
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
        imageURLLarge = try values.decodeIfPresent(String.self, forKey: .imageURLLarge) ?? ""
        artistTitle = try values.decodeIfPresent(String.self, forKey: .artistTitle) ?? ""
        videoID = try values.decodeIfPresent(Int.self, forKey: .videoID) ?? 0
        activeMessage = try values.decodeIfPresent(String.self, forKey: .activeMessage) ?? ""
        shareMessage = try values.decodeIfPresent(String.self, forKey: .shareMessage) ?? ""
        blockDownload = try values.decodeIfPresent(Int.self, forKey: .blockDownload) ?? 0
        blockView = try values.decodeIfPresent(Int.self, forKey: .blockView) ?? 0
        rbtSMS = try values.decodeIfPresent(String.self, forKey: .rbtSMS) ?? ""
        rbtHost = try values.decodeIfPresent(Int.self, forKey: .rbtHost) ?? 0
        messageBlock = try values.decodeIfPresent(String.self, forKey: .messageBlock) ?? ""
        youtubeStatusRaw = try values.decodeIfPresent(Int.self, forKey: .youtubeStatusRaw) ?? 0
        youtubeStatusEmbed = try values.decodeIfPresent(Int.self, forKey: .youtubeStatusEmbed) ?? 0
    }
}
