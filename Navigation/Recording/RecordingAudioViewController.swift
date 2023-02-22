//
//  RecordingAudioViewController.swift
//  Navigation
//
//  Created by Vladislav Green on 11/14/22.
//  using https://www.hackingwithswift.com/read/33/2/recording-from-the-microphone-with-avaudiorecorder

import UIKit
import AVFoundation

class RecordingAudioViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    
    private enum LocalizedKeys: String {
        case helperText = "RecVC-helperText"
        case micAccessAlert = "RecVC-micAccessAlert"
        case recFailedAlert = "RecVC-recFailedAlert"
        case recFailedMessage = "RecVC-recFailedMessage"
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 30
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var helper: UILabel = {
        let label = UILabel()
        label.text = ~LocalizedKeys.helperText.rawValue
        label.textColor = .lightGray
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.lineBreakStrategy = .hangulWordPriority
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var recordButton: UIButton = {
        let recordButton = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 64, weight: .regular, scale: .large)
        let image = UIImage(systemName: "mic")?.withTintColor(.red, renderingMode: .alwaysOriginal).withConfiguration(largeConfig)
        recordButton.setImage(image, for: .normal)
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        return recordButton
    }()
    
    private lazy var playButton: UIButton = {
        let playButton = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 64, weight: .regular, scale: .large)
        let image = UIImage(systemName: "play")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal).withConfiguration(largeConfig)
        playButton.setImage(image, for: .normal)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.addTarget(self, action: #selector(bypass), for: .touchUpInside)
        return playButton
    }()
    private var audioURL: URL!

    /*
     Recording audio in iOS uses two classes: AVAudioSession and AVAudioRecorder. AVAudioSession is there to enable and track sound recording as a whole, and AVAudioRecorder is there to track one individual recording. That is, the session is the bit that ensures we are able to record, the recorder is the bit that actual pulls data from the microphone and writes it to disk.
     */
    private var recordingSession: AVAudioSession!
    private var recorder: AVAudioRecorder!
    
    private lazy var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in   // ask for access to mic
                
                /*
                 We also need to add a string to the Info.plist file explaining to the user what we intend to do with the audio. So, open the Info.plist file now, select any row, then click the + next that appears next to it. Select the key name “Privacy - Microphone Usage Description” then give it the value “We need to record your whistle.” Done!
                 */
                
                DispatchQueue.main.async {  // because the callback from requestRecordPermission() can happen on any thread
                    if allowed {
                        print("Great!")
                    } else {
                        self.loadFailUI()
                    }
                }
            }
        } catch {
            self.loadFailUI()
        }
    }
    
    func setupView() {
        view.backgroundColor = .black
        view.addSubview(helper)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(recordButton)
        stackView.addArrangedSubview(playButton)

        helper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        helper.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48).isActive = true
        helper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48).isActive = true
        
        stackView.topAnchor.constraint(equalTo: helper.bottomAnchor, constant: 16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func loadFailUI() {
        let failLabel = UILabel()
        failLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        failLabel.text = ~LocalizedKeys.micAccessAlert.rawValue
        failLabel.numberOfLines = 0

        stackView.addArrangedSubview(failLabel)
    }
    
    // return the path to a writeable directory owned by your app
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    class func getRecordingURL() -> URL {
        return getDocumentsDirectory().appendingPathComponent("recording.m4a")
    }
    
    private func startRecording() {
        
            //  Change buttons appearence
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 64, weight: .regular, scale: .large)
        let imageRec = UIImage(systemName: "mic.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal).withConfiguration(largeConfig)
        recordButton.setImage(imageRec, for: .normal)
        
        let imagePlay = UIImage(systemName: "play")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal).withConfiguration(largeConfig)
        playButton.setImage(imagePlay, for: .normal)

            // Use getRecordingURL() to find where to save
        audioURL = RecordingAudioViewController.getRecordingURL()
        print(audioURL.absoluteString)  // if in trouble see the note at the end

            // Create a settings dictionary describing the format, sample rate, channels and quality
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
                // Create an AVAudioRecorder object pointing at our recording URL, set ourselves as the delegate, then call its record() method
            recorder = try AVAudioRecorder(url: audioURL, settings: settings)
            recorder.delegate = self
            recorder.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    private func finishRecording(success: Bool) {
        recorder.stop()
        recorder = nil

        if success {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 64, weight: .regular, scale: .large)
            let image = UIImage(systemName: "mic")?.withTintColor(.red, renderingMode: .alwaysOriginal).withConfiguration(largeConfig)
            recordButton.setImage(image, for: .normal)
            loadPlayingUI()
            
        } else {
            let ac = UIAlertController(
                title: ~LocalizedKeys.recFailedAlert.rawValue,
                message: ~LocalizedKeys.recFailedMessage.rawValue, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
        
    @objc
    private func recordTapped() {
        if recorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    private func loadPlayingUI() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 64, weight: .regular, scale: .large)
        let image = UIImage(systemName: "play.fill")?.withTintColor(.green, renderingMode: .alwaysOriginal).withConfiguration(largeConfig)
        playButton.setImage(image, for: .normal)
        playButton.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
    }
    
    @objc
    private func playTapped() {
        if player.isPlaying {
            stopPlayingAudio()
        } else {
            do {
                player = try AVAudioPlayer(contentsOf: audioURL)
                player.delegate = self
                let largeConfig = UIImage.SymbolConfiguration(pointSize: 64, weight: .regular, scale: .large)
                let image = UIImage(systemName: "stop.fill")?.withTintColor(.green, renderingMode: .alwaysOriginal).withConfiguration(largeConfig)
                playButton.setImage(image, for: .normal)
                player.play()
            }
            catch {
                print("whoops")
            }
        }
    }
    
    @objc
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("playing finished")
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 64, weight: .regular, scale: .large)
        let image = UIImage(systemName: "play.fill")?.withTintColor(.green, renderingMode: .alwaysOriginal).withConfiguration(largeConfig)
        playButton.setImage(image, for: .normal)
    }
    
    private func stopPlayingAudio() {
        if player.isPlaying {
            
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 64, weight: .regular, scale: .large)
            let image = UIImage(systemName: "play.fill")?.withTintColor(.green, renderingMode: .alwaysOriginal).withConfiguration(largeConfig)
            playButton.setImage(image, for: .normal)
            
            let fadeOutDuration = 0.2
            player.setVolume(0, fadeDuration: fadeOutDuration)
            DispatchQueue.main.asyncAfter(deadline: .now() + fadeOutDuration) {
                self.player.stop()
                self.player.currentTime = 0
            }
        }
        else {
            print("Already stopped!")
        }
    }
    
    @objc
    private func bypass() {
        
    }
}

/*
 Note: if you're a less experienced macOS user, you might not know how to navigate to a folder like the one the iOS Simulator uses, because it's hidden by default. For example, you'll get something like this: file:///Users/twostraws/Library/Developer/CoreSimulator/Devices/E470B24D-5C0C-455F-9726-DC1EAF30D5A4/data/Containers/Data/Application/D5E4C08C-2B1E-40BC-8EBE-97F136D0AFC0/Documents/whistle.m4a – which hardly trips off the tongue!

 The easiest thing to do is copy that to a clipboard, open a Finder window, press Shift+Cmd+G, and paste it into the box. Now delete the "file://" from the start so that it reads "/Users/yourusername/.....", and "whistle.m4a" from the end, then press Return.
 */



