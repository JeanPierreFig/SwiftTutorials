//
//  VideoViewController.swift
//  VideoInTableViewTutorial
//
//  Created by John Xiong on 3/11/17.
//  Copyright © 2017 Xiong. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        /*
        let url = URL(fileURLWithPath: "https://www.youtube.com/watch?v=rbK_j6n6r2Q");
        let player = AVPlayer(url: url);
        let playerLayer = AVPlayerLayer(player: player);
        playerLayer.frame = self.view.bounds;
        view.layer.addSublayer(playerLayer);
        player.play();
        */
        
        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
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
