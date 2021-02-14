//
//  PostCellFullScreen.swift
//  CrowdShot
//
//  Created by Soni A on 02/01/2021.
//  Copyright © 2021 Thoughtlights. All rights reserved.
//
import AVFoundation
import UIKit

class PostCellFullScreen : UICollectionViewCell {
    static let reuseIdentifier = "PostCellFullScreen"
    
    //   TODO: Add the below info
    // - Username
    // - Icons - Shares, Likes, Comments
    
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

    lazy var articleTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "august alsina: will smith gave me permission to sleep w/wife jada pinkett smith!!"
        label.font = UIFont.init(name: "TheBoldFont", size:18)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    // UI Incons
    
     
   public var player: AVPlayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
        isRed = !isRed
    }
    
    func play()  {
        self.player?.play()
    }
    
  func customPath() -> UIBezierPath {
    let path = UIBezierPath()
        path.move(to: CGPoint(x: frame.width - 40, y: (frame.height / 2) + 20))
        let endPoint = CGPoint(x: -(frame.width + 40), y: 200)
        let randomYShift = 200 + drand48() * 300
        let cp1 = CGPoint(x: 100, y: 100 - randomYShift)
        let cp2 = CGPoint(x: 200, y: 300 + randomYShift)
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
      return path
    }
    
    var isRed = false
    @objc func handleTap() {
        UIView.animate(withDuration: 0.40,
            animations: {
                self.isRed = !self.isRed
                self.likeButton.titleLabel?.textColor = .red
                self.likeButton.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.50) {
                    self.likeButton.transform = CGAffineTransform.identity
                    self.likeButton.titleLabel?.textColor  = (self.isRed) ? .red : .white
                 
             }
        })
        if self.isRed {
            (0...10).forEach { (_) in
                self.generateAnimatedViews()
            }
        }
      
    }
    
    fileprivate func generateAnimatedViews() {
        let image = drand48() > 0.5 ? #imageLiteral(resourceName: "thumbs_up") : #imageLiteral(resourceName: "heart")
        let imageView = UIImageView(image: image)
        let dimension = 20 + drand48() * 10
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath
        animation.duration = 2 + drand48() * 3
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        imageView.layer.add(animation, forKey: nil)
        addSubview(imageView)
    }
    
    private func setupView() {
        backgroundColor = .black
        
        let bgClearView = UIView()
        bgClearView.translatesAutoresizingMaskIntoConstraints = false
        bgClearView.backgroundColor = UIColor(white: 0.1, alpha: 0.15)
     
        addSubview(profileImage)
        addSubview(title)
        let curvedView = CurvedView(frame: frame)
        curvedView.backgroundColor = .clear
        curvedView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(curvedView)
        addSubview(bgClearView)
        addIcons()
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            profileImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            profileImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            curvedView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            curvedView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            curvedView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            curvedView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            bgClearView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            bgClearView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            bgClearView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            bgClearView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
          ])
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
            playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
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
    
    //MARK: Icons
    lazy var likeButton: UIButton = {
        let button = UIButton()
        let buttonString = String.fontAwesomeString(name: "fa-heart")
        let buttonStringAttributed = NSMutableAttributedString(string: buttonString, attributes: [NSAttributedString.Key.font:UIFont(name: "HelveticaNeue", size: 11.00)!])
        buttonStringAttributed.addAttribute(NSAttributedString.Key.font, value: UIFont.iconFontOfSize(font: "FontAwesome5ProSolid", fontSize: 25), range: NSRange(location: 0,length: 1))
        buttonStringAttributed.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(white: 1, alpha: 0.8),range: NSRange(location: 0,length: 1))
        button.titleLabel?.textAlignment = .center
        button.setAttributedTitle(buttonStringAttributed, for: .normal)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        return button
    }()
    
    lazy var likeCountLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1.3M"
        label.font = UIFont.init(name: "TheBoldFont", size:14)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    lazy var commentButton: UIButton = {
        let button = UIButton()
        let buttonString = String.fontAwesomeString(name: "fa-comment")
        let buttonStringAttributed = NSMutableAttributedString(string: buttonString, attributes: [NSAttributedString.Key.font:UIFont(name: "HelveticaNeue", size: 11.00)!])
        buttonStringAttributed.addAttribute(NSAttributedString.Key.font, value: UIFont.iconFontOfSize(font: "FontAwesome5ProSolid", fontSize: 25), range: NSRange(location: 0,length: 1))
        buttonStringAttributed.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(white: 1, alpha: 0.8),range: NSRange(location: 0,length: 1))
        button.titleLabel?.textAlignment = .center
        button.setAttributedTitle(buttonStringAttributed, for: .normal)
        return button
    }()
    
    lazy var commentCountLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10.7M"
        label.font = UIFont.init(name: "TheBoldFont", size:14)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        let buttonString = String.fontAwesomeString(name: "fa-share")
        let buttonStringAttributed = NSMutableAttributedString(string: buttonString, attributes: [NSAttributedString.Key.font:UIFont(name: "HelveticaNeue", size: 11.00)!])
        buttonStringAttributed.addAttribute(NSAttributedString.Key.font, value: UIFont.iconFontOfSize(font: "FontAwesome5ProSolid", fontSize: 25), range: NSRange(location: 0,length: 1))
        buttonStringAttributed.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(white: 1, alpha: 0.8), range: NSRange(location: 0,length: 1))
        button.titleLabel?.textAlignment = .center
        button.setAttributedTitle(buttonStringAttributed, for: .normal)
        return button
    }()
    
    lazy var shareCountLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "30.9m"
        label.font = UIFont.init(name: "TheBoldFont", size:14)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    func addIcons()  {
        var vStackView = UIStackView()
        vStackView = UIStackView(arrangedSubviews: [likeButton, likeCountLabel, commentButton, commentCountLabel, shareButton, shareCountLabel ])
        vStackView.axis = .vertical
        vStackView.distribution = .fill
        vStackView.spacing = 10
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vStackView)
       
        let height = contentView.frame.height / 2
        NSLayoutConstraint.activate([
            vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: height),
        ])
    }
}

class CurvedView: UIView {
    override func draw(_ rect: CGRect) {
        //do some fancy curve drawing
        let path = PostCellFullScreen().customPath()
        path.lineWidth = 0
        path.stroke()
    }
}
