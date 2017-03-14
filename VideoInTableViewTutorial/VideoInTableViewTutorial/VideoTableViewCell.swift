//
//  VideoTableViewCell.swift
//  VideoInTableViewTutorial
//
//  Created by John Xiong on 3/11/17.
//  Copyright © 2017 Xiong. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    @IBOutlet weak var playerView: PlayerView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
