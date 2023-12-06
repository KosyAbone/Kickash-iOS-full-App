//
//  ArticleDetailViewController.swift
//  KickAsh
//
//  Created by Subash on 2023-12-05.
//

import UIKit
import AVKit

class ArticleDetailViewController: UIViewController {
    var player: AVPlayer?
    
    @IBOutlet weak var videoView: UIView!
    let videoURL = URL(string: "http://blacpythoz.insomnia247.nl/files/byteforce/vids/nicotine.mp4")!
    var playerController: AVPlayerViewController?
    private var playerObserver: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoPlayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player?.play()
    }
    
    private func setupVideoPlayer() {
        player = AVPlayer(url: videoURL)
        playerController = AVPlayerViewController()
        
        guard let player = player, let playerController = playerController else {
            return
        }
        
        playerController.player = player
        playerController.view.frame = videoView.bounds
        
        addChild(playerController)
        videoView.addSubview(playerController.view)
        playerController.didMove(toParent: self)
        
        playerObserver = player.observe(\.status, options: [.new, .initial]) { [weak self] _, _ in
            guard let self = self else { return }
            if self.player?.status == .failed {
                print("Video playback failed: \(String(describing: self.player?.error))")
            }
        }
    }
    
    deinit {
        playerObserver?.invalidate()
    }
}
