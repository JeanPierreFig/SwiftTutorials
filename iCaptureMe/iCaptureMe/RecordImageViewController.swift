//
//  RecordImageViewController.swift
//  iCaptureMe
//
//  Created by John Xiong on 6/24/17.
//  Copyright © 2017 xiong. All rights reserved.
//

import UIKit
import AVFoundation

class RecordImageViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var previewView: UIView!
    
    @IBAction func takeImageButtonPressed(_ sender: Any) {
        
    }
    
    
    var cameraDevice: AVCaptureDevice?
    
    // Session
    lazy var session: AVCaptureSession = {
       let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetPhoto
        return session
    }()
    
    // Preview layer
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        previewLayer?.bounds = self.previewView.bounds
        previewLayer?.position = CGPoint(x: self.previewView.bounds.midX, y: self.previewView.bounds.midY)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        return previewLayer!
    }()
    
    
    lazy var photoOutput: AVCapturePhotoOutput = {
        let output = AVCapturePhotoOutput()
        return output
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func initialize() {
        cameraDevice = defaultCameraDevice()
        
        do {
            let cameraInput = try AVCaptureDeviceInput(device: cameraDevice)
            
            session.beginConfiguration()
            if session.canAddInput(cameraInput) {
                session.addInput(cameraInput)
            }
            if session.canAddOutput(photoOutput) {
                session.addOutput(photoOutput)
            }
        } catch {
            print(error)
        }
    }
    
    func defaultCameraDevice() -> AVCaptureDevice? {
        if let camera = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .front) {
            return camera
        } else if let camera = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .back) {
            return camera
        } else {
            return nil
        }
    }
}

extension RecordImageViewController {
    
}
