//
//  CameraViewController.swift
//  flowers
//
//  Created by Ryan Stromberg on 4/10/16.
//  Copyright © 2016 Ryan Stromberg. All rights reserved.
//

import UIKit
import AVFoundation
import FontAwesome_swift

class CameraViewController: UIViewController{

    let captureSession = AVCaptureSession()
    
    //store device for future use
    var captureDevice : AVCaptureDevice?
   
    
    @IBOutlet weak var takePictureBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        
        // Do any additional setup after loading the view.
        captureSession.sessionPreset = AVCaptureSessionPresetLow
        
        let devices = AVCaptureDevice.devices()
        
        //loop through capture devices on phone
        for device in devices{
        
            //check position and confirm back camera
            if(device.position == AVCaptureDevicePosition.Back){
                captureDevice = device as? AVCaptureDevice
                
            }
        }
        
        if(captureDevice != nil){
            beginSession()
        }
        
        takePictureBtn.titleLabel?.textAlignment = NSTextAlignment.Center
        takePictureBtn.titleLabel?.font = UIFont.fontAwesomeOfSize(48)
        takePictureBtn.setTitle(String.fontAwesomeIconWithCode("fa-camera"), forState: .Normal)
        self.view.bringSubviewToFront(takePictureBtn)
    }
    
    func beginSession(){
        
        do{
            
            try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            self.view.layer.addSublayer(previewLayer)
            previewLayer?.frame = self.view.layer.frame
            captureSession.startRunning()
            
        } catch let error as NSError{
            print(error)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
