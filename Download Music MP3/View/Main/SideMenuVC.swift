//
//  SideMenuVC.swift
//  Download Music MP3
//
//  Created by iMac on 04/02/22.
//

import UIKit

class SideMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Button Click
    @IBAction func clickToHome(_ sender: Any) {
        sideMenuController?.hideLeftViewAnimated(sender: self)
    }
    
    @IBAction func clickToDownload(_ sender: Any) {
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: DownloadVC.className) as! DownloadVC
        sideMenuController?.rootViewController?.show(vc, sender: nil)
        sideMenuController?.hideLeftViewAnimated(sender: self)
    }
    
    @IBAction func clickToShare(_ sender: Any) {
        shareText(self, ITUNE_URL)
        sideMenuController?.hideLeftViewAnimated(sender: self)
    }
    
    @IBAction func clickToRateApp(_ sender: Any) {
        openUrlInSafari(strUrl: ITUNE_URL)
        sideMenuController?.hideLeftViewAnimated(sender: self)
    }
    
    @IBAction func clickToSupport(_ sender: Any) {
        openUrlInSafari(strUrl: CONTTACT_US)
        sideMenuController?.hideLeftViewAnimated(sender: self)
    }
    
    @IBAction func clickToPrivacy(_ sender: Any) {
        openUrlInSafari(strUrl: PRIVACY_POLICY)
        sideMenuController?.hideLeftViewAnimated(sender: self)
    }
}
