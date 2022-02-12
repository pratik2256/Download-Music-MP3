import Foundation
import UIKit

let APP_VERSION         = "1.0"
let BUILD_VERSION       = "1"
let ITUNE_URL           = "https://apps.apple.com/us/app/id1554038047"
let PRIVACY_POLICY      = "https://app200779112.wordpress.com/"
let CONTTACT_US         = "https://app200779112.wordpress.com/support/"
let TERMS_AND_CONDITION = "https://app200779112.wordpress.com/terms-condition/"
let MORE_APPS           = "https://apps.apple.com/us/developer/vishal-vora/id1544695575"
let DeviceId            = UIDevice.current.identifierForVendor?.uuidString

// MARK: Top search list
let TOP_SEARCH_LIST     = ["head above water", "Bad Guy", "Thruth Hurts", "London Boy", "Old Town Road", "Give Me Love", "Girls Like You", "I Don't Care", "Goodbyes", "Someone You Loved", "The Git Up", "Lover", "Boyfriend", "Sucker", "See You Again", "Afterglow"]

struct STORYBOARD {
    static var MAIN     = UIStoryboard(name: "Main", bundle: nil)
}

// MARK: Image Placeholder
struct PLACE_HOLDER_IMAGE {
    static var SONG     = "song_placeholder"
}
