//
//  AudioViewController.swift
//  Navigation
//
//  Created by Vladislav Green on 11/12/22.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {
    
    private var musicFiles: [String] = [
        "Queen",
        "TAET & EXAN Eastern Bells",
        "TÆT Back Beams",
        "TÆT Coins For The Ghost",
        "TÆT Minus Five",
        "TÆT South Point Blues"
    ]
    
    var trackID: Int = 0    // default track
    
    private var player = AVAudioPlayer()
    
    private var songsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var songsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var playerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .black
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var songName: UILabel = {
        let label = UILabel()
        label.text = "Song Name"
        label.textColor = .gray
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currentSongName: UILabel = {
        let label = UILabel()
        label.text = "Current Song Name"
        label.textColor = .gray
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var playPauseButton: UIButton = {
        let button = UIButton()
        let imagePlay = UIImage(systemName: "play.fill")
        button.setImage(imagePlay, for: .normal)
        button.addTarget(self, action: #selector(playPauseAudio(_:)) , for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        let imagePlay = UIImage(systemName: "stop.fill")
        button.setImage(imagePlay, for: .normal)
        button.addTarget(self, action: #selector(stopPlayingAudio(_:)) , for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        do {
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(
                forResource: musicFiles[trackID],
                ofType: "mp3")!))
            currentSongName.text = musicFiles[trackID]
            player.prepareToPlay()
        }
        catch {
            print(error)
        }
    }
    
    private func setupView() {
        
        view.addSubview(playerStackView)
        playerStackView.addArrangedSubview(currentSongName)
        playerStackView.addArrangedSubview(playPauseButton)
        playerStackView.addArrangedSubview(stopButton)
        
        view.addSubview(songsScrollView)
        songsScrollView.addSubview(songsStackView)
        
        for i in 0..<musicFiles.count {
            
            let label = UILabel()
            label.text = musicFiles[i]
            label.textColor = .white
            
            let action = UIAction(
                image: UIImage(systemName: "play.circle"),
                handler: { _ in
                    self.selectSong(withID: i)
                }
            )
            let button = UIButton(primaryAction: action)
            
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 10
            stackView.alignment = .trailing
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
            stackView.addArrangedSubview(label)
            
            songsStackView.addArrangedSubview(stackView)
        }
        
        NSLayoutConstraint.activate([
            playerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            
            songsScrollView.topAnchor.constraint(equalTo: playerStackView.bottomAnchor, constant: 48),
            songsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            songsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            songsScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            songsStackView.leadingAnchor.constraint(equalTo: songsScrollView.leadingAnchor),
            songsStackView.widthAnchor.constraint(equalTo: songsScrollView.widthAnchor)
            
        ])
    }
    
    @objc
    private func playPauseAudio(_ sender: Any) {
        if player.isPlaying {
            self.playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            let fadeOutDuration = 0.08          // защита от щелчков
            player.setVolume(0, fadeDuration: fadeOutDuration)
            DispatchQueue.main.asyncAfter(deadline: .now() + fadeOutDuration) {
                self.player.stop()
            }
        } else {
            self.playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            let fadeInDuration = 0.08
            player.setVolume(0, fadeDuration: 0)
            player.play()
            player.setVolume(1, fadeDuration: fadeInDuration)
        }
    }
    
    @objc
    private func stopPlayingAudio(_ sender: Any) {
        if player.isPlaying {
            self.playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            let fadeOutDuration = 1.0
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
    
    private func selectSong(withID: Int) {
        print("track \(withID)")
        trackID = withID
        do {
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(
                forResource: musicFiles[trackID],
                ofType: "mp3")!))
            currentSongName.text = musicFiles[trackID]
            player.prepareToPlay()
            playPauseAudio(self)
        }
        catch {
            print(error)
        }
    }
}


