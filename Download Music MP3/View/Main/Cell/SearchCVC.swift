//
//  SearchCVC.swift
//  Download Music MP3
//
//  Created by iMac on 02/02/22.
//

import UIKit

class SearchCVC: UICollectionViewCell {
    
    class var identifier: String { return self.className }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    // OUTLET
    @IBOutlet weak var searchLbl: UILabel!
    
    // VARIABLE
    var searchString: String? {
        didSet {
            searchLbl.text = searchString
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
