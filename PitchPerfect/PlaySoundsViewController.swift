//
//  PlaySoundsVC.swift
//  PitchPerfect
//
//  Created by Josh Smith on 5/8/15.
//  Copyright (c) 2015 Square One Nation, LLC. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    
    var audioPlayer : AVAudioPlayer!
    
    var audio : RecordedAudio!
    var audioEngine : AVAudioEngine!
    var audioFile : AVAudioFile!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: audio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: audio.filePathUrl, error: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow()
    {
        playWithSpeed(0.5)
    }
    
    @IBAction func playFast()
    {
        playWithSpeed(1.5)
    }
    
    @IBAction func playChipmunk()
    {
        playWithVariablePitch(1000.0)
    }
    
    @IBAction func playVader()
    {
        playWithVariablePitch(-1000.0)
    }
    
    func playWithSpeed(speed: Float)
    {
        self.stopAll()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func stopAll()
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playWithVariablePitch(pitch: Float)
    {
        self.stopAll()
        var pitchPlayer = AVAudioPlayerNode()
        audioEngine.attachNode(pitchPlayer)
        
        var timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        audioEngine.attachNode(timePitch)
        
        audioEngine.connect(pitchPlayer, to: timePitch, format: nil)
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format: nil)
        
        pitchPlayer.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        pitchPlayer.play()
    }

    @IBAction func stop()
    {
        self.stopAll()
    }


}
