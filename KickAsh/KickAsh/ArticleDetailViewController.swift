//
//  ArticleDetailViewController.swift
//  KickAsh
//
//  Created by subash on 2023-12-05.
//

import UIKit
import AVKit

class ArticleDetailViewController: UIViewController {

    // Replace "your_video_url" with your actual video URL
    @IBOutlet weak var videoView: UIView!
    let videoURL = URL(string: "http://blacpythoz.insomnia247.nl/files/byteforce/vids/nicotine.mp4")!
    
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the player
        player = AVPlayer(url: videoURL)
        
        // Create AVPlayerLayer
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoView.bounds
        
        // Add AVPlayerLayer to videoView's layer
        videoView.layer.addSublayer(playerLayer)
        
        // Start playing the video
        player?.play()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
