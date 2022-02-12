//
//  ViewController.swift
//  Download Music MP3
//
//  Created by iMac on 02/02/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchCV: UICollectionView! {
        didSet {
            searchCV.delegate = self
            searchCV.dataSource = self
            searchCV.register(SearchCVC.nib, forCellWithReuseIdentifier: SearchCVC.identifier)
        }
    }
    @IBOutlet weak var searchTxt: UITextField!
    
    // Player OUTLETS
    @IBOutlet weak var songPlayerView: UIView!
    @IBOutlet weak var songImg: ImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var playTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyGusterToPlayerView()
    }
    
    // MARK: View Life Cycler
    override func viewWillAppear(_ animated: Bool) {
        MusicPlayer.share.player != nil ? (songPlayerView.isHidden = false) : (songPlayerView.isHidden = true)
        MusicPlayer.share.player?.timeControlStatus == .playing ? (playBtn.isSelected = true) : (playBtn.isSelected = false)
        MusicPlayer.share.setUIComponent(songNameLbl: titleLbl, slider: UISlider(), currentTimeLbl: playTime, totalTimeLbl: totalTime)
    }
    
    // MARK: Methods
    func getAds() {
        let param: [String: Any] = ["package_name": "com.sportsfan.footballfan.FootballPredictionTips"]
        AdsService().getAds(param) { data in
            print(data)
        }
    }
    
    @IBAction func clickToPlayBtn(_ sender: Any) {
        MusicPlayer.share.player?.timeControlStatus == .playing ? (playBtn.isSelected = false) : (playBtn.isSelected = true)
        MusicPlayer.share.player?.timeControlStatus == .playing ? (MusicPlayer.share.pause()) : (MusicPlayer.share.play())
    }
    
    // MARK: Touch Gusters
    func applyGusterToPlayerView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(navigateToPlaySongVC))
        songPlayerView.addGestureRecognizer(tap)
    }
    
    @objc func navigateToPlaySongVC() {
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: PlaySongVC.className) as! PlaySongVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: Button Click
    @IBAction func clickToMenu(_ sender: Any) {
        sideMenuController?.showLeftView(animated: true, completion: nil)
    }
    
    @IBAction func clickToShare(_ sender: Any) {
        shareText(self, ITUNE_URL)
    }
    
    @IBAction func clickToSearch(_ sender: Any) {
        if searchTxt.text?.trimmed.count == 0 {
            displayToast("Please enter searching text")
        } else {
            let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: SearchListVC.className) as! SearchListVC
            vc.searchString = searchTxt.text!.trimmed
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TOP_SEARCH_LIST.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCV.dequeueReusableCell(withReuseIdentifier: SearchCVC.identifier, for: indexPath) as! SearchCVC
        cell.searchString = TOP_SEARCH_LIST[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = TOP_SEARCH_LIST[indexPath.row]
        let font = UIFont(name: "Helvetica", size: 16)!
        let size = tag.size(withAttributes: [NSAttributedString.Key.font: font])
        let dynamicCellWidth = size.width
        return CGSize(width: dynamicCellWidth + 20, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: SearchListVC.className) as! SearchListVC
        vc.searchString = TOP_SEARCH_LIST[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
