//
//  SongTVC.swift
//  Download Music MP3
//
//  Created by iMac on 03/02/22.
//

import UIKit

class SongTVC: UITableViewCell {

    class var identifier: String { return self.className }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    // OUTLET
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var artistTitleLbl: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    
    // VARIABLE
    var songDataModel: SongDataModel? {
        didSet {
            setImageFromUrl(songDataModel!.imageURL, img: img, placeHolder: PLACE_HOLDER_IMAGE.SONG)
            titleLbl.text = songDataModel?.title
            artistTitleLbl.text = songDataModel?.artistTitle
        }
    }
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
