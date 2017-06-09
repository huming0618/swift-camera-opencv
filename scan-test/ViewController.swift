//
//  ViewController.swift
//  scan-test
//
//  Created by peter on 2017/6/3.
//  Copyright © 2017年 Peter. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    var session: AVCaptureSession!
    var videoCaptureDevice: AVCaptureDevice!
    var output: AVCaptureVideoDataOutput!
    
    //var previewLayer: AVCaptureVideoPreviewLayer!
    
    @IBOutlet weak var imageView: UIImageView!
    
    func setupCamera() -> Bool{
        // Do any additional setup after loading the view, typically from a nib.
        // Create a session object.
        session = AVCaptureSession()
        
        // Set the captureDevice.
        videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType:AVMediaTypeVideo)
        
        // Create input object.
        let videoInput: AVCaptureDeviceInput?
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return false
        }
        
        // Add input to the session.
        if (session.canAddInput(videoInput)) {
            session.addInput(videoInput)
        } else {
            //scanningNotPossible()
            return false
        }
        
        output = AVCaptureVideoDataOutput()
        output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable: Int(kCVPixelFormatType_32BGRA)]
        
        do {
            try videoCaptureDevice.lockForConfiguration()
            videoCaptureDevice.activeVideoMinFrameDuration = CMTimeMake(1, 15)
            videoCaptureDevice.unlockForConfiguration()
            
            let queue: DispatchQueue = DispatchQueue(label: "myqueue", attributes:[])
        
            output.setSampleBufferDelegate(self, queue: queue)
            output.alwaysDiscardsLateVideoFrames = true
            
            for connection in output.connections {
                if let conn = connection as? AVCaptureConnection {
                    if conn.isVideoOrientationSupported {
                        conn.videoOrientation = AVCaptureVideoOrientation.portrait
                    }
                }
            }
        } catch let error as NSError {
            print(error)
            return false
        }
        

//        present the preview layer
//        previewLayer = AVCaptureVideoPreviewLayer(session: session)
//        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
//        previewLayer?.frame = view.layer.bounds
//        view.layer.addSublayer(previewLayer!)
        
        
        return true
    }
    
    @IBAction func startTesting(){
        if setupCamera() {
            session.startRunning()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let openCVWrapper = OpenCVWrapper()
        openCVWrapper.isThisWorking()
        print("viewDidLoad")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

