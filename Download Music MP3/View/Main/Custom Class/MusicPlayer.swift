//
//  MusicPlayer.swift
//  Download Music MP3
//
//  Created by iMac on 04/02/22.
//

import UIKit
import AVFoundation

class MusicPlayer: NSObject {
    
    public static var share = MusicPlayer()
    
    var player: AVPlayer?
    var songName: String = ""
    
    /// Init Player and Play music
    func initPlayer(songName: String, url: URL) {
        self.songName = songName
        songNameLbl.text = self.songName
        
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        play()
        
        playAudioBackground()
        startProgressTimer()
    }
    
    /// Play music background when app state change as background
    func playAudioBackground() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [.mixWithOthers, .allowAirPlay])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            // displayToast(error.localizedDescription)
        }
    }
    
    // MARK: Set UI component
    var songNameLbl: UILabel!
    var slider: UISlider!
    var currentTimeLbl: UILabel!
    var totalTimeLbl: UILabel!
    
    func setUIComponent(songNameLbl: UILabel, slider: UISlider, currentTimeLbl: UILabel, totalTimeLbl: UILabel) {
        self.songNameLbl = songNameLbl
        self.slider = slider
        self.currentTimeLbl = currentTimeLbl
        self.totalTimeLbl = totalTimeLbl
        
        songName != "" ? (songNameLbl.text = songName) : ()
    }
    
    // MARK: Methods
    public func play() {
        player?.play()
    }
    
    public func pause() {
        player?.pause()
    }
    
    public func forwordJump(sec: Float) {
        if let playerItem = player {
            let currentTime = Float(CMTimeGetSeconds(playerItem.currentTime()))
            let totalTime = Float(CMTimeGetSeconds(playerItem.currentItem!.duration))
                
            if (currentTime + sec) < totalTime {
                let totalSec = currentTime + sec
                player?.seek(to: CMTimeMake(value: Int64(totalSec), timescale: 1))
            }
        }
    }
    
    public func backwordJump(sec: Float) {
        if let playerItem = player {
            let currentTime = Float(CMTimeGetSeconds(playerItem.currentTime()))
                
            if (currentTime - sec) > 0 {
                let totalSec = currentTime - sec
                player?.seek(to: CMTimeMake(value: Int64(totalSec), timescale: 1))
            }
        }
    }
    
    public func speedUpSong(sec: Float) {
        player?.seek(to: CMTimeMake(value: Int64(sec), timescale: 1))
    }
    
    // MARK: Set progress
    var progressTimer: Timer?
    
    func startProgressTimer() {
        progressTimer != nil ? (progressTimer?.invalidate()) : (nil)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.updateProgressTimer), userInfo: nil, repeats: true)
    }

    @objc func updateProgressTimer() {
        if let playerItem = player {
            let currentTime = Float(CMTimeGetSeconds(playerItem.currentTime()))
            let totalTime = Float(CMTimeGetSeconds(playerItem.currentItem!.duration))
            
            slider.minimumValue = 0
            slider.maximumValue = totalTime
            slider.value = currentTime
            
            currentTimeLbl.text = "\(secondsToHoursMinutesSeconds(Int(currentTime)).min):\(secondsToHoursMinutesSeconds(Int(currentTime)).sec)"
            totalTimeLbl.text = "\(secondsToHoursMinutesSeconds(Int(totalTime)).min):\(secondsToHoursMinutesSeconds(Int(totalTime)).sec)"
        }
    }
}
