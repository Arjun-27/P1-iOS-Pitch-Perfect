//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Arjun Chouhan on 6/10/17.
//  Copyright © 2017 CraterTech. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: - Variables (For Playing Audio)
    
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // MARK: - Sound Effects
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: - Overriden View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }

    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
    
    // MARK: - Play Sound Effects
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch (ButtonType(rawValue: sender.tag)!) {
            case .slow:
                playSound(rate: 0.5)
            case .fast:
                playSound(rate: 2.0)
            case .chipmunk:
                playSound(pitch: 1000)
            case .vader:
                playSound(pitch: -1000)
            case .echo:
                playSound(echo: true)
            case .reverb:
                playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    // MARK: - Stop Audio
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
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
