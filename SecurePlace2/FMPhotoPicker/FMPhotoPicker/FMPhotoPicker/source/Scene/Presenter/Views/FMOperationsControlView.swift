//
//  FMOperationsControlView.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 07/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import UIKit
import AVKit
import SnapKit

enum OperationControlViewType {
    case video
    case photo
}

public extension Notification.Name {
    static let controller_play = Notification.Name("controller_play")
    static let controller_pause = Notification.Name("controller_pause")
    static let player_pause = Notification.Name("player_pause")
    static let player_play = Notification.Name("player_play")
}

class FMOperationsControlView: UIView {
    
    private var shareButton: UIButton!
    private var deleteButton: UIButton!
    private var playPauseButton: UIButton!
    private var isPlaying = false
    
    init() {
        super.init(frame: .zero)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        backgroundColor = UIColor(white: 1, alpha: 0.77)
        
        shareButton = UIButton(image: UIImage(systemName: "square.and.arrow.up") ?? UIImage(), tintColor: .none, target: self, action: #selector(shareButtonPressed))
        playPauseButton = UIButton(image: UIImage(systemName: "play.fill") ?? UIImage(), tintColor: .none, target: self, action: #selector(playPauseButtonPressed))
        deleteButton = UIButton(image: UIImage(systemName: "trash") ?? UIImage(), tintColor: .none, target: self, action: #selector(deleteButtonPressed))

        addSubview(shareButton)
        addSubview(playPauseButton)
        addSubview(deleteButton)
        
        playPauseButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(37.withRatio())
        }
        
        shareButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.withRatio())
            make.centerY.equalToSuperview()
            make.height.width.equalTo(37.withRatio())
        }
        
        deleteButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15.withRatio())
            make.centerY.equalToSuperview()
            make.height.width.equalTo(37.withRatio())
        }
        
    }
    
    func updateOperationsControl(type: OperationControlViewType) {
        if(type == .video) {
            self.playPauseButton.isHidden = false
        } else {
            self.playPauseButton.isHidden = true
        }
    }
    
    private func addPlayerObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(playerPlay), name: .player_play, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playerPause), name: .player_pause, object: nil)
    }
    
    func resetUI() {
        self.isPlaying = false
        //NotificationCenter.default.post(name: .controller_pause, object: nil)
        updatePlayButton()
    }
    
    @objc func shareButtonPressed() {
        
    }
    
    @objc func playPauseButtonPressed() {
        isPlaying = !isPlaying
        updatePlayButton()
        if isPlaying {
            NotificationCenter.default.post(name: .controller_play, object: nil)
        } else {
            NotificationCenter.default.post(name: .controller_pause, object: nil)
        }
    }

    @objc func deleteButtonPressed() {
        
    }
    
    @objc private func playerPlay() {
        isPlaying = true
        updatePlayButton()
    }
    
    @objc private func playerPause() {
        isPlaying = false
        updatePlayButton()
    }
    
    private func updatePlayButton() {
        if isPlaying {
            playPauseButton.isHidden = false
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            playPauseButton.isHidden = false
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    private func removePlayerObservers() {
        NotificationCenter.default.removeObserver(self, name: .player_play, object: nil)
        NotificationCenter.default.removeObserver(self, name: .player_pause, object: nil)
    }
    
    deinit {
        removePlayerObservers()
    }
}
