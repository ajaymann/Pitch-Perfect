//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Ajay Mann on 17/07/16.
//  Copyright © 2016 Ajay Mann. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundVC: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordStatusLbl: UILabel!    
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    var audioRecorder:AVAudioRecorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopBtn.enabled = false
        recordStatusLbl.text = "Tap to Record"
    }

    @IBAction func recordButtonPressed(sender: AnyObject) {
        recordStatusLbl.text = "Recording in Progress..."
        print("recordButtonPressed")
        stopBtn.enabled = true
        recordBtn.enabled = false
        recordAudio()
    }

    @IBAction func stopButtonPressed(sender: AnyObject) {
        recordStatusLbl.text = "Recording Done"
        recordBtn.enabled = true
        stopAudioRecording()
    }
    
    func recordAudio() {
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        //print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    
    func stopAudioRecording() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)

}


    
//    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
//        if flag {
//            prepareForSegue(segue: UIStoryboardSegue, sender: ?) {
//                if segue.identifier == "stopRecording" {
//                    let playRecordedSoundVC = segue.destinationViewController as! PlayRecordedAudioVC
//                    let recordedAudioURL = sender as! NSURL
//                    playRecordedSoundVC.recordedAudioURL = recordedAudioURL
//                }
//            }
//
//            
//                   }
//        else {
//            print("Some Error Bro!")
//        }
//    }
 
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        }
        else {
            print("Saving Failed")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
                let playRecordedAudioVC = segue.destinationViewController as! PlayRecordedAudioVC
                let recordedAudioURL = sender as! NSURL
                playRecordedAudioVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}


