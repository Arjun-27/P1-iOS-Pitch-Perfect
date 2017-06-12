//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Arjun Chouhan on 6/9/17.
//  Copyright © 2017 CraterTech. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!

    // MARK: - Audio Recoder (Variable)
    
    var audioRecorder: AVAudioRecorder!
    var isRecording: Bool = false
    
    // MARK: - Overriden View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        print(filePath!)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])

        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear called..")
    }

    // MARK: - Audio Recording Functions
    
    @IBAction func startRecording(_ sender: Any) {
        if !isRecording {
            isRecording = true
            recordingLabel.text = "Recording in progress..."
            recordButton.setImage(UIImage(named: "Stop.png"), for: .normal)
            
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        } else {
            isRecording = false
            recordingLabel.text = "Tap to record"
            recordButton.setImage(UIImage(named: "Record.png"), for: .normal)
            
            audioRecorder.stop()
            let audioSession = AVAudioSession.sharedInstance()
            try! audioSession.setActive(false)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Finished Recording")
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording Failed")
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            playSoundsVC.recordedAudioURL = sender as! URL
        }
        
    }
}

