//
//  SearchListVC.swift
//  Download Music MP3
//
//  Created by iMac on 03/02/22.
//

import UIKit

class SearchListVC: UIViewController {
    
    // OUTLET
    @IBOutlet weak var tblView: UITableView! {
        didSet {
            tblView.delegate = self
            tblView.dataSource = self
            tblView.register(SongTVC.nib, forCellReuseIdentifier: SongTVC.identifier)
        }
    }
    @IBOutlet weak var headerTxt: UILabel!
    @IBOutlet weak var errorLbl: UILabel!
    
    // Player OUTLETS
    @IBOutlet weak var songPlayerView: UIView!
    @IBOutlet weak var songImg: ImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var playTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    
    // PASSED
    var searchString: String = ""
    
    // VARIABLE
    var songList: [SongDataModel] = [SongDataModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        headerTxt.text = "Search: \(searchString)"
        applyGusterToPlayerView()
        getSearchSongList()
    }
    
    // MARK: View Life Cycler
    override func viewWillAppear(_ animated: Bool) {
        MusicPlayer.share.player != nil ? (songPlayerView.isHidden = false) : (songPlayerView.isHidden = true)
        MusicPlayer.share.player?.timeControlStatus == .playing ? (playBtn.isSelected = true) : (playBtn.isSelected = false)
        MusicPlayer.share.setUIComponent(songNameLbl: titleLbl, slider: UISlider(), currentTimeLbl: playTime, totalTimeLbl: totalTime)
    }
    
    // MARK: Methods
    func getSearchSongList() {
        let request = SongRequest(offset: "1", limit: "1000", keyword: searchString, type: "Song")
        SongService().getSongList(true, request) { [self] data in
            songList.append(contentsOf: data)
            tblView.reloadData()
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
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToShare(_ sender: Any) {
        shareText(self, ITUNE_URL)
    }

}

extension SearchListVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songList.count == 0 ? (errorLbl.isHidden = false) : (errorLbl.isHidden = true)
        return songList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: SongTVC.identifier, for: indexPath) as! SongTVC
        cell.songDataModel = songList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get song detail
        let request = SongDetailRequest.init(profile_id: "1", id: "\(songList[indexPath.row].id)")
        SongDetailService().getSongDetail(request) { data in
            let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: PlaySongVC.className) as! PlaySongVC
            vc.modalPresentationStyle = .fullScreen
            vc.songDetailDataModel = data
            vc.isComeFromSongList = true
            self.present(vc, animated: true, completion: nil)
        }
    }
}
