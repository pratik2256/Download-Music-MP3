//
//  PlaySongVC.swift
//  Download Music MP3
//
//  Created by iMac on 03/02/22.
//

import UIKit
import AVFoundation

class PlaySongVC: UIViewController {

    // OUTLET
    @IBOutlet weak var img: ImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var songSlider: UISlider!
    @IBOutlet weak var playTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
    // PASSED
    var songDetailDataModel: SongDetailDataModel!
    var isComeFromSongList: Bool = false
    var isComeFromDownload: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isComeFromDownload {
            initPlayer(url: URL(fileURLWithPath: songDetailDataModel.streamingURL))
        }
        
        if isComeFromSongList {
            downloadSong()
        } else {
            MusicPlayer.share.player?.timeControlStatus == .playing ? (playBtn.isSelected = true) : (playBtn.isSelected = false)
            MusicPlayer.share.setUIComponent(songNameLbl: titleLbl, slider: songSlider, currentTimeLbl: playTime, totalTimeLbl: totalTime)
        }
        
        setVolumeSlider()
    }
    
    // MARK: Methods
    func downloadSong() {
        if let songUrl = URL(string: songDetailDataModel.streamingURL) {
            let songDesctinationUrl = URL(fileURLWithPath: getDirectoryPath().documentDirectory).appendingPathComponent(songUrl.lastPathComponent)
            if FileManager.default.fileExists(atPath: songDesctinationUrl.path) { // Song alredy downloaded so play now
                initPlayer(url: songDesctinationUrl)
            } else { // If song not downloaded so download and play
                APIManager().DOWNLOAD_ANY_FILE(api: songDetailDataModel.streamingURL, isShowLoader: true) { [self] data in
                    let sourcePath = URL(fileURLWithPath: data)
                    let destinationPath = URL(fileURLWithPath: getDirectoryPath().documentDirectory).appendingPathComponent("\(songDetailDataModel.title).mp3")
                    renameFileInDirectory(sourcePath: sourcePath, destinationPath: destinationPath) { success in
                        if success {
                            initPlayer(url: destinationPath)
                        } else {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
    
    func designUI() {
        MusicPlayer.share.player?.timeControlStatus == .playing ? (playBtn.isSelected = false) : (playBtn.isSelected = true)
    }
    
    func setVolumeSlider() {
        let getValume = AVAudioSession.sharedInstance().outputVolume
        volumeSlider.minimumValue = 0
        volumeSlider.maximumValue = 1
        volumeSlider.value = getValume
    }
    
    // MARK: Methods
    func initPlayer(url: URL) {
        MusicPlayer.share.setUIComponent(songNameLbl: titleLbl, slider: songSlider, currentTimeLbl: playTime, totalTimeLbl: totalTime)
        MusicPlayer.share.initPlayer(songName: songDetailDataModel.title, url: url)
        
        designUI()
    }
    
    // MARK: Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickToShare(_ sender: Any) {
        shareText(self, ITUNE_URL)
    }
    
    @IBAction func clickToGoBackword(_ sender: Any) {
        MusicPlayer.share.backwordJump(sec: 10.0)
    }
    
    @IBAction func clickToPlay(_ sender: Any) {
        MusicPlayer.share.player?.timeControlStatus == .playing ? (playBtn.isSelected = false) : (playBtn.isSelected = true)
        MusicPlayer.share.player?.timeControlStatus == .playing ? (MusicPlayer.share.pause()) : (MusicPlayer.share.play())
    }
    
    @IBAction func clickToForword(_ sender: Any) {
        MusicPlayer.share.forwordJump(sec: 10.0)
    }
    
    // MARK: Slider Click
    @IBAction func clickToPlaySlider(_ sender: UISlider) {
        MusicPlayer.share.speedUpSong(sec: sender.value)
    }
    
    @IBAction func clickToVolumeSlider(_ sender: UISlider) {
        setSystemVolume(sender.value)
    }
}
