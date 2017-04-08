//
//  ViewController.swift
//  SegmentControlTutorial
//
//  Created by John Xiong on 4/7/17.
//  Copyright © 2017 Xiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var containerVC1: UIView!
    @IBOutlet weak var containerVC2: UIView!
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            containerVC1.isHidden = false;
            containerVC2.isHidden = true;
            break;
        default:
            containerVC1.isHidden = true;
            containerVC2.isHidden = false;
            break;
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.setTitle("VC1", forSegmentAt: 0);
        segmentControl.setTitle("VC2", forSegmentAt: 1);
    }
}

