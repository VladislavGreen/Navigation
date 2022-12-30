//
//  VideoViewController.swift
//  Navigation
//
//  Created by Vladislav Green on 11/14/22.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {
    
    private lazy var streamURL = URL(string:
        "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8"
    )!
    
    private var videosNameAndLink: [String : String] = [
        "Audio Haptics Design" : "https://devstreaming-cdn.apple.com/videos/wwdc/2021/10278/6/22D440E4-3CF8-4968-8FCB-6F21B4587DAD/cmaf.m3u8",
        "Transition Media Gaplessly" : "https://devstreaming-cdn.apple.com/videos/wwdc/2021/10142/14/423D5648-E58A-4CD1-A06F-1290EFA18BC4/cmaf.m3u8",
        "Geometry aware audio" : "https://devstreaming-cdn.apple.com/videos/wwdc/2021/10079/4/B49836DD-46CA-49CD-81CF-9D08B251FDFA/cmaf.m3u8",
        "Better HLS Audio Experience" : "https://devstreaming-cdn.apple.com/videos/wwdc/2020/10158/5/1244B634-C720-4325-A806-A201BFDF5E51/master.m3u8",
        "Record stereo audio" : "https://devstreaming-cdn.apple.com/videos/wwdc/2020/10226/5/C8C3C21B-7FB6-4655-A9C9-7879416D0435/master.m3u8"
    ]
    
    private var videoStackViews: [UIStackView] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .black
        tableView.sectionHeaderHeight = 46.6
        tableView.rowHeight = 44
        tableView.allowsSelection = false
        tableView.dataSource = self
//        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCellID")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var watchButton: UIButton = {
        let button = UIButton()
        let imagePlay = UIImage(systemName: "tv.fill")
        button.setImage(imagePlay, for: .normal)
        button.addTarget(self, action: #selector(watchButtonPressed(_:)) , for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createVideoButtons()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(watchButton)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            self.watchButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 48),
            self.watchButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.tableView.topAnchor.constraint(equalTo: self.watchButton.bottomAnchor, constant: 48),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    @objc
    func watchButtonPressed(_ sender: Any) {
        // Создаём AVPlayer со ссылкой на видео.
        let player = AVPlayer(url: streamURL)

        // Создаём AVPlayerViewController и передаём ссылку на плеер.
        let controller = AVPlayerViewController()
        controller.player = player

        // Показываем контроллер модально и запускаем плеер.
        present(controller, animated: true) {
            player.play()
        }
    }
    
    private func selectAndPlayVideo(withURL: URL) {
        print(withURL)
        let player = AVPlayer(url: withURL)
        let controller = AVPlayerViewController()
        controller.player = player
        present(controller, animated: true) {
            player.play()
        }
    }
    
    private func createVideoButtons() {
        for (videoName, videoLink) in videosNameAndLink {
            
            let label = UILabel()
            label.text = videoName
            label.textColor = .white
            
            let link = videoLink
            let URL = URL(string: link)
            let action = UIAction(
//                title: videoName,
                title: " смотреть",
                image: UIImage(systemName: "tv"),
                handler: { _ in
                    self.selectAndPlayVideo(withURL: URL!)
                }
            )
            let button = UIButton(primaryAction: action)
            
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.backgroundColor = .black
            stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.addArrangedSubview(button)
            stackView.addArrangedSubview(label)
            
            videoStackViews.append(stackView)
        }
    }
}


extension VideoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = videosNameAndLink.count
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCellID", for: indexPath)
        
        let stackView = videoStackViews[indexPath.row]
        cell.addSubview(stackView)
        cell.backgroundColor = .black
        cell.contentView.removeFromSuperview()
        return cell
    }
}
