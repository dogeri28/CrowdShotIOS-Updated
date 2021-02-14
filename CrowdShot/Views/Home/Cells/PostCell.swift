//
//  PostCell.swift
//  CrowdShot
//
//  Created by Soni A on 22/12/2020.
//  Copyright © 2020 Thoughtlights. All rights reserved.
//

import AVFoundation
import Foundation
import UIKit

class PostCell: UICollectionViewCell {
    static let reuseIdentifier = "PostCell"
    
    //   TODO: Add the below info
    // - Username
    // - Icons - Shares, Likes, Comments
    
   public var player: AVPlayer?
    
   var profileImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "postimage8")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var title : UILabel = {
        var rect = CGRect(x: 20, y: 20, width: 300, height: 60)
        let label = UILabel(frame: rect)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "HOUSTON IS CRAZY..."
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        label.textColor = UIColor(red:1.00, green:0.82, blue:0.00, alpha:1.00)
        label.frame = rect
        container.addSubview(label)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 1.4
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        label.layer.masksToBounds = false
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
    }
    
    func play()  {
        self.player?.play()
    }
    
    private func setupView() {
      backgroundColor = .black
//      addSubview(profileImage)
//      addSubview(title)
//        NSLayoutConstraint.activate([
//            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 2),
//            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
//            profileImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
//            profileImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2),
//            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
//            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
//            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2)
//        ])
    }
    
    func setupPlayerViewAndLoadVideo(videoUrl: String) {
        guard let filePath = Bundle.main.path(forResource: videoUrl, ofType:"mp4") else {
             debugPrint("video.m4v not found")
             return
         }

   //let filePath = "https://firebasestorage.googleapis.com/v0/b/talentwars-594fd.appspot.com/o/talentwars_videos%2FCarrot%20Crazy.mp4?alt=media&token=ff231761-ab2b-4dd0-a6a0-f62f5b10243c"
        if self.player == nil {
            self.player = AVPlayer()
            let playerLayer = AVPlayerLayer(player: self.player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.bounds
            playerLayer.cornerRadius = 10
            playerLayer.masksToBounds = true
            playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
             let url = URL(fileURLWithPath: filePath)
             let asset = AVAsset(url: url)
             let playerItem = AVPlayerItem(asset: asset)
            playerItem.preferredPeakBitRate = .leastNonzeroMagnitude
            self.player?.automaticallyWaitsToMinimizeStalling = false
            self.player?.replaceCurrentItem(with: playerItem)
            self.player?.volume = 0
            self.player?.play()
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: .main) { [self] _ in
                self.player?.seek(to: CMTime.zero)
                self.player?.play()
            }
        } else {
                let url = URL(fileURLWithPath: filePath)
                let asset = AVAsset(url: url)
                let playerItem = AVPlayerItem(asset: asset)
                self.player?.automaticallyWaitsToMinimizeStalling = false
                self.player?.replaceCurrentItem(with: playerItem)
                self.player?.pause()
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: .main) { [self] _ in
                    self.player?.seek(to: CMTime.zero)
                    self.player?.play()
                }
        }
    }
}

extension UILabel {

    func setOutLinedText(_ text: String) {
        let attribute : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeWidth : -2.0,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)
            ] as [NSAttributedString.Key  : Any]

        let customizedText = NSMutableAttributedString(string: text,
                                                       attributes: attribute)
        attributedText = customizedText
     }
}
