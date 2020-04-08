//
//  FMPlaybackControlView.swift
//  FMPhotoPicker
//
//  Created by c-nguyen on 2018/02/19.
//  Copyright © 2018 Tribal Media House. All rights reserved.
//

import UIKit
import AVKit

public extension Notification.Name {
    static let player_seek_to = Notification.Name("player_seek_to")
    static let player_seek_began = Notification.Name("player_seek_began")
    static let player_seek_ended = Notification.Name("player_seek_ended")
    static let player_current_position_updated = Notification.Name("player_current_position_updated")
}

class FMPlaybackControlView: UIView {
    
    let progressMarginLeft: CGFloat = 8.0
    let progressMarginTop: CGFloat = 6.0
    let progressHeight: CGFloat = 50
    
    public var playbackProgressView: FMPlaybackProgressView
    private let currentTimeLabel: UILabel!
    private let totalTimeLabel:UILabel!
    
    private var duration: TimeInterval?
    
    public var touchBegan: () -> Void = {} {
        didSet {
            self.playbackProgressView.touchBegan = self.touchBegan
        }
    }
    public var touchEnded: () -> Void = {} {
        didSet {
            self.playbackProgressView.touchEnded = self.touchEnded
        }
    }
    
    init() {
        
        playbackProgressView = FMPlaybackProgressView(frame: .zero)
        currentTimeLabel = UILabel()
        totalTimeLabel = UILabel()
        super.init(frame: .zero)
        
        self.addSubview(playbackProgressView)
        self.addSubview(currentTimeLabel)
        self.addSubview(totalTimeLabel)
        
        playbackProgressView.translatesAutoresizingMaskIntoConstraints = false
        playbackProgressView.topAnchor.constraint(equalTo: self.topAnchor, constant: progressMarginTop).isActive = true
        playbackProgressView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: progressMarginLeft).isActive = true
        playbackProgressView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -progressMarginLeft).isActive = true
        playbackProgressView.heightAnchor.constraint(equalToConstant: progressHeight).isActive = true
        
        currentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTimeLabel.leftAnchor.constraint(equalTo: playbackProgressView.leftAnchor,
                                             constant: (playbackProgressView.thumbWidth - playbackProgressView.thumbIconWidth) / 2).isActive = true
        currentTimeLabel.topAnchor.constraint(equalTo: playbackProgressView.bottomAnchor, constant: 2).isActive = true
        currentTimeLabel.font = UIFont.systemFont(ofSize: 13)
        currentTimeLabel.textColor = .white
        currentTimeLabel.text = "0:00"
        currentTimeLabel.textColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1)
        
        totalTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        totalTimeLabel.rightAnchor.constraint(equalTo: playbackProgressView.rightAnchor,
                                             constant: -(playbackProgressView.thumbWidth - playbackProgressView.thumbIconWidth) / 2).isActive = true
        totalTimeLabel.topAnchor.constraint(equalTo: playbackProgressView.bottomAnchor, constant: 2).isActive = true
        totalTimeLabel.font = UIFont.systemFont(ofSize: 13)
        totalTimeLabel.textColor = .white
        totalTimeLabel.text = "0:00"
        totalTimeLabel.textColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1)
        
        self.backgroundColor = UIColor.white
        self.alpha = 0.77
        
        // top border view
        let topBorder = UIView(frame: .zero)
        topBorder.backgroundColor = kBorderColor
        addSubview(topBorder)
        
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        topBorder.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        topBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        topBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func resetPlaybackControl(cgImages: [CGImage], duration: TimeInterval) {
        self.duration = duration
        playbackProgressView.resetPlaybackControl(cgImages: cgImages)
        currentTimeLabel.text = "0:00"
        totalTimeLabel.text = duration.stringTime
        //playButton.isHidden = true
    }
    
    public func updateFrames() {
        self.playbackProgressView.updateLayerFrames()
    }
    
    public func playerProgressDidChange(value: Double) {
        guard let duration = duration else { return }
        currentTimeLabel.text = (duration * value).stringTime
        playbackProgressView.playerProgressDidChange(value: value)
    }
}
