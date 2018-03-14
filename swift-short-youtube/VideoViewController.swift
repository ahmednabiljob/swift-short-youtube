//
//  VideoViewController.swift
//  swift-short-youtube
//
//  Created by Ahmed on 3/13/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit
import YouTubePlayer

class VideoViewController: UIViewController {
    
    var videoID:String = ""
    var videoTitle:String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let videoPlayer = YouTubePlayerView(frame: CGRect(x: self.view.frame.minX+10, y: 10, width: self.view.frame.maxX-10, height: 200))
        videoPlayer.loadVideoID(videoID)
        
        let title = UILabel(frame: CGRect(x: self.view.frame.minX+10, y: 220, width: self.view.frame.maxX-10, height: 64))
        title.text=videoTitle
        
        self.view.addSubview(videoPlayer)
        self.view.addSubview(title)
        
        if videoPlayer.ready{
            print("player is ready")
            videoPlayer.play()
        }
        
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: self.view.frame.minX+10, y: self.view.frame.maxY-70, width: self.view.frame.maxX-20, height: 64)
        backButton.addTarget(self, action: #selector(backToPreviousView), for: .touchUpInside)
        backButton.backgroundColor = UIColor.red
        backButton.setTitle("Back", for: .normal)
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
