//
//  AdsResponce.swift
//  Download Music MP3
//
//  Created by iMac on 02/02/22.
//

import Foundation

struct AdsResponce: Codable {
    let status: String
    let data: AdsDataModel?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status) ?? ""
        data = try values.decodeIfPresent(AdsDataModel.self, forKey: .data) ?? nil
    }
}

struct AdsDataModel: Codable {
    let fbBanner, fbInterstitial, fbNative, fbSource: String
    let googleSource, googleBanner, googleInterstitial, googleNative: String
    let startappID, startappSource, appStatus, fbInterstitialTwo: String
    let fbInterstitialThree, fbNativeTwo, fbNativeThree, iphoneAds: String
    let iphoneRating, iphoneExtra: String

    enum CodingKeys: String, CodingKey {
        case fbBanner = "fb_banner"
        case fbInterstitial = "fb_interstitial"
        case fbNative = "fb_native"
        case fbSource = "fb_source"
        case googleSource = "google_source"
        case googleBanner = "google_banner"
        case googleInterstitial = "google_interstitial"
        case googleNative = "google_native"
        case startappID = "startapp_id"
        case startappSource = "startapp_source"
        case appStatus = "app_status"
        case fbInterstitialTwo = "fb_interstitial_two"
        case fbInterstitialThree = "fb_interstitial_three"
        case fbNativeTwo = "fb_native_two"
        case fbNativeThree = "fb_native_three"
        case iphoneAds = "iphone_ads"
        case iphoneRating = "iphone_rating"
        case iphoneExtra = "iphone_extra"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fbBanner = try values.decodeIfPresent(String.self, forKey: .fbBanner) ?? ""
        fbInterstitial = try values.decodeIfPresent(String.self, forKey: .fbInterstitial) ?? ""
        fbNative = try values.decodeIfPresent(String.self, forKey: .fbNative) ?? ""
        fbSource = try values.decodeIfPresent(String.self, forKey: .fbSource) ?? ""
        googleSource = try values.decodeIfPresent(String.self, forKey: .googleSource) ?? ""
        googleBanner = try values.decodeIfPresent(String.self, forKey: .googleBanner) ?? ""
        googleInterstitial = try values.decodeIfPresent(String.self, forKey: .googleInterstitial) ?? ""
        googleNative = try values.decodeIfPresent(String.self, forKey: .googleNative) ?? ""
        startappID = try values.decodeIfPresent(String.self, forKey: .startappID) ?? ""
        startappSource = try values.decodeIfPresent(String.self, forKey: .startappSource) ?? ""
        appStatus = try values.decodeIfPresent(String.self, forKey: .appStatus) ?? ""
        fbInterstitialTwo = try values.decodeIfPresent(String.self, forKey: .fbInterstitialTwo) ?? ""
        fbInterstitialThree = try values.decodeIfPresent(String.self, forKey: .fbInterstitialThree) ?? ""
        fbNativeTwo = try values.decodeIfPresent(String.self, forKey: .fbNativeTwo) ?? ""
        fbNativeThree = try values.decodeIfPresent(String.self, forKey: .fbNativeThree) ?? ""
        iphoneAds = try values.decodeIfPresent(String.self, forKey: .iphoneAds) ?? ""
        iphoneRating = try values.decodeIfPresent(String.self, forKey: .iphoneRating) ?? ""
        iphoneExtra = try values.decodeIfPresent(String.self, forKey: .iphoneExtra) ?? ""
    }
    
    init() {
        fbBanner = ""
        fbInterstitial = ""
        fbNative = ""
        fbSource = ""
        googleSource = ""
        googleBanner = ""
        googleInterstitial = ""
        googleNative = ""
        startappID = ""
        startappSource = ""
        appStatus = ""
        fbInterstitialTwo = ""
        fbInterstitialThree = ""
        fbNativeTwo = ""
        fbNativeThree = ""
        iphoneAds = ""
        iphoneRating = ""
        iphoneExtra = ""
    }
}
