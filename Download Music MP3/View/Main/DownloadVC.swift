//
//  DownloadVC.swift
//  Download Music MP3
//
//  Created by iMac on 04/02/22.
//

import UIKit

class DownloadVC: UIViewController {

    // OUTLET
    @IBOutlet weak var tblView: UITableView! {
        didSet {
            tblView.delegate = self
            tblView.dataSource = self
            tblView.register(SongTVC.nib, forCellReuseIdentifier: SongTVC.identifier)
        }
    }
    @IBOutlet weak var errorLbl: UILabel!
    
    // Player OUTLETS
    @IBOutlet weak var songPlayerView: UIView!
    @IBOutlet weak var songImg: ImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var playTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    
    var songList: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyGusterToPlayerView()
        getDownloadedSongList()
    }
    
    // MARK: View Life Cycler
    override func viewWillAppear(_ animated: Bool) {
        MusicPlayer.share.player != nil ? (songPlayerView.isHidden = false) : (songPlayerView.isHidden = true)
        MusicPlayer.share.player?.timeControlStatus == .playing ? (playBtn.isSelected = true) : (playBtn.isSelected = false)
        MusicPlayer.share.setUIComponent(songNameLbl: titleLbl, slider: UISlider(), currentTimeLbl: playTime, totalTimeLbl: totalTime)
    }
    
    // MARK: Methods
    func getDownloadedSongList() {
        songList = getListOfFilesFromDirectory(pathWithDirectoryName: getDirectoryPath().documentDirectory + "/")
        tblView.reloadData()
    }
    
    // MARK: Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToShare(_ sender: Any) {
        shareText(self, ITUNE_URL)
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

}

extension DownloadVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songList.count == 0 ? (errorLbl.isHidden = false) : (errorLbl.isHidden = true)
        return songList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: SongTVC.identifier, for: indexPath) as! SongTVC
        
        let temp = songList[indexPath.row]
        cell.titleLbl.numberOfLines = 2
        cell.titleLbl.text = URL(fileURLWithPath: temp).lastPathComponent
        cell.artistTitleLbl.isHidden = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let songUrl = songList[indexPath.row]
        let title = URL(fileURLWithPath: songList[indexPath.row]).lastPathComponent
        
        var songDetailDataModel = SongDetailDataModel.init()
        songDetailDataModel.streamingURL = songUrl
        songDetailDataModel.title = title
        
        
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: PlaySongVC.className) as! PlaySongVC
        vc.modalPresentationStyle = .fullScreen
        vc.isComeFromDownload = true
        vc.songDetailDataModel = songDetailDataModel
        self.present(vc, animated: true, completion: nil)
    }
}
