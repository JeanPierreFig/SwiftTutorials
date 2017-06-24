//
//  CustomCameraViewController.swift
//  iCaptureMe
//
//  Created by John Xiong on 5/24/17.
//  Copyright © 2017 xiong. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class RecordVideoViewController: UIViewController {
    
    fileprivate var isRecording: Bool = false
    
    //@IBOutlet weak var capturedImage: UIImageView!
    @IBOutlet weak var previewView: UIView!
    @IBAction func takePhotoButtonPressed(_ sender: Any) {
        toggleRecording()
    }
    
    /*
     Things needed for Audio/Video
     - Session
     - Video device
     - Audio device
     - Video preview layer to show what the camera is showing
     - Video output
    */
    
    var videoDevice: AVCaptureDevice?
    var audioDevice: AVCaptureDevice?
    
    // Session
    lazy var session: AVCaptureSession = {
        let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetHigh
        return session
    }()
    
    // Display what is seen by the camera onto phone
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        previewLayer?.bounds = self.previewView.bounds
        previewLayer?.position = CGPoint(x: self.previewView.bounds.midX, y: self.previewView.bounds.midY)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        return previewLayer!
    }()
    
    // Allows you to record
    lazy var videoOutput: AVCaptureMovieFileOutput = {
        let videoOutput = AVCaptureMovieFileOutput()
        let allowedRecordedSeconds = 60.0
        let framesPerSecond: Int = 30
        let maxDuration = CMTimeMakeWithSeconds(allowedRecordedSeconds, Int32(framesPerSecond))
        videoOutput.maxRecordedDuration = maxDuration
        videoOutput.minFreeDiskSpaceLimit = 1024 * 1024
        return videoOutput
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewView.layer.addSublayer(previewLayer)
    }
    
    func initialize() {
        videoDevice = defaultCameraDevice()
        audioDevice = defaultAudioDevice()
        
        do {
            let videoInput = try AVCaptureDeviceInput(device: videoDevice)
            let audioInput = try AVCaptureDeviceInput(device: audioDevice)
            session.beginConfiguration()
            
            if session.canAddInput(videoInput) {
                session.addInput(videoInput)
            }
            if session.canAddInput(audioInput) {
                session.addInput(audioInput)
            }
            if session.canAddOutput(videoOutput) {
                session.addOutput(videoOutput)
            }
            
            session.commitConfiguration()
            session.startRunning()
            
            startCamera()
            
        } catch let error as NSError {
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
    
    func defaultAudioDevice() -> AVCaptureDevice? {
        if let audioDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio) {
            return audioDevice
        } else {
            return nil
        }
    }
    
    func startCamera() {
        let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        if authStatus == AVAuthorizationStatus.authorized {
            session.startRunning()
        } else if authStatus == AVAuthorizationStatus.denied || authStatus == AVAuthorizationStatus.restricted {
            if session.isRunning {
                session.stopRunning()
            }
        }
    }
    
    func stopCamera() {
        if isRecording {
            toggleRecording()
        }
        if session.isRunning {
            session.stopRunning()  
        }
    }
    
    func toggleRecording() {
        isRecording = !isRecording
        if isRecording {
            let savePath = "\(NSTemporaryDirectory())output.mov"
            let saveURL = URL(fileURLWithPath: savePath)
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: savePath) {
                do {
                    try fileManager.removeItem(at: saveURL)
                } catch {
                    print("error removing item at path: \(savePath)")
                    self.isRecording = false
                    return
                }
            }
            videoOutput.startRecording(toOutputFileURL: saveURL, recordingDelegate: self)
        } else {
            videoOutput.stopRecording()
        }
    }
}

extension RecordVideoViewController: AVCaptureFileOutputRecordingDelegate {
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        // play saved video
    }
}
