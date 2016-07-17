//
//  PlayRecordedAudioVC.swift
//  Pitch Perfect
//
//  Created by Ajay Mann on 17/07/16.
//  Copyright © 2016 Ajay Mann. All rights reserved.
//

import UIKit
import AVFoundation

class PlayRecordedAudioVC: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton : UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton : UIButton!
    @IBOutlet weak var echoButton : UIButton!
    @IBOutlet weak var stopButton : UIButton!
    @IBOutlet weak var reverbButton : UIButton!
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine : AVAudioEngine!
    var audioPlayerNode : AVAudioPlayerNode!
    var stopTimer : NSTimer!
    
    enum ButtonType : Int {case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb}


    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func playAudioButtonPressed (sender : UIButton) {
        print("Play Pressed")
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Slow : playSound(rate: 0.5)
        case .Fast : playSound(rate: 1.5)
        case .Chipmunk: playSound(pitch: 1000)
        case .Vader : playSound(pitch : -1000)
        case .Echo : playSound(echo: true)
        case .Reverb : playSound(reverb : true)
        }
        configureUI(.Playing)
    }
    
    @IBAction func stopAudioButtonPressed(sender : AnyObject) {
        print("Stop Pressed")
        stopAudio()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
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
