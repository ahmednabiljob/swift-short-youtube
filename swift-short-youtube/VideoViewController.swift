//
//  VideoViewController.swift
//  swift-short-youtube
//
//  Created by Ahmed on 3/13/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit
import YouTubePlayer
//import AVKit


class VideoViewController: UIViewController {
    
    var videoID:String = ""
    var videoTitle:String = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let videoPlayer = YouTubePlayerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width*9/16))
        
        let playerVars = ["controls": "1", "playsinline": "1", "autohide": "1", "showinfo": "1", "autoplay": "1", "fs": "1", "rel": "0", "loop": "0", "enablejsapi": "1", "modestbranding": "1"]
        
        videoPlayer.playerVars = playerVars as YouTubePlayerView.YouTubePlayerParameters
        
        videoPlayer.loadVideoID(videoID)
        if videoPlayer.ready{
            print("player is ready")
            videoPlayer.play()
        }
        videoPlayer.play()
        self.view.addSubview(videoPlayer)
        
        
        
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        /*let url = URL(string: "https://www.youtube.com/watch?v=\(videoID)")!
        let player = AVPlayer(url: url)
        
        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player
        controller.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width*9/16)
        self.addChildViewController(controller)
        self.view.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
        // Modally present the player and call the player's play() method when complete.
        present(controller, animated: true) {
            player.play()
        }*/
        //let url = URL(string:"https://www.ebookfrenzy.com/ios_book/movie/movie.mov")

        
        
        let title = UILabel(frame: CGRect(x: self.view.frame.minX+10, y: 220, width: self.view.frame.maxX-10, height: 64))
        title.text=videoTitle
        title.textAlignment = .center
        title.numberOfLines = 0
        self.view.addSubview(title)
        
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: self.view.frame.minX+10, y: self.view.frame.maxY-70, width: self.view.frame.maxX-20, height: 64)
        backButton.addTarget(self, action: #selector(backToPreviousView), for: .touchUpInside)
        backButton.backgroundColor = UIColor.red
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        self.view.addSubview(backButton)
    }
    
    @objc func backToPreviousView(){
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(videoID)
        print(videoTitle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}




