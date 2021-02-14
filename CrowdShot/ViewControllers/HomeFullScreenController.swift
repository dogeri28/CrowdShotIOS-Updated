//
//  HomeFullScreenController.swift
//  CrowdShot
//
//  Created by Soni A on 28/12/2020.
//  Copyright © 2020 Thoughtlights. All rights reserved.
//

import UIKit
import AVFoundation

class HomeFullScreenController: UIViewController, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    public var player: AVPlayer?
    public var playerLayer:AVPlayerLayer?
    
    enum Section: Int {
        case header = 1
        case post = 2
    }
    
    var dataSource : UICollectionViewDiffableDataSource<Section, Post>!
    var snapshot : NSDiffableDataSourceSnapshot<Section, Post>!
    
   lazy var fullScreenCollectionView : UICollectionView = {
        var layout = HomeFullScreenLayoutManager.createLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPrefetchingEnabled = false
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupCollectionView()
        configureDataSource()
        setupFloatingControls()
    }
    

    func setupCollectionView()  {
        setNeedsStatusBarAppearanceUpdate()
        view.addSubview(fullScreenCollectionView)
        self.view.layoutIfNeeded()
        NSLayoutConstraint.activate([
            fullScreenCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            fullScreenCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fullScreenCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fullScreenCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        fullScreenCollectionView.register(HomeFullScreenHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeFullScreenHeaderView.reuseIdentifier)
        fullScreenCollectionView.register(PostCellFullScreen.self, forCellWithReuseIdentifier: PostCellFullScreen.reuseIdentifier)
    }
    
    
    func configureDataSource()  {
        
        snapshot = NSDiffableDataSourceSnapshot()
        snapshot.appendSections([Section.post])

        let postDataSource = FakePostDataStore()
        let postItems = postDataSource.getPosts()
        
        snapshot.appendItems(postItems)
        dataSource = UICollectionViewDiffableDataSource<Section, Post>(collectionView: fullScreenCollectionView, cellProvider: { (collectionView, indexPath, number) -> UICollectionViewCell? in
           guard let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCellFullScreen.reuseIdentifier, for: indexPath) as? PostCellFullScreen else {
               fatalError("Cannot create new cell")
           }
          
        postCell.profileImage.image = UIImage(named: postItems[indexPath.row].coverImage)
            //postCell.layer.shouldRasterize = true;
            //postCell.layer.rasterizationScale = UIScreen.main.scale;
           // postCell.setupPlayerViewAndLoadVideo(videoUrl: postItems[indexPath.row].videoUrl)
 
        return postCell
      })

     dataSource.supplementaryViewProvider = {collectionView, kind, indexPath in
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeFullScreenHeaderView.reuseIdentifier, for: indexPath) as! HomeFullScreenHeaderView
            return header
          }
         return nil
        }
       
        dataSource.apply(snapshot)
      }
    
 func removeView() {
    let scaleTransform = CGAffineTransform.init(scaleX: 0.001, y: 0.001)
    self.fullScreenCollectionView.transform = .identity
    self.view.transform = .identity
    self.floatingContainerView.isHidden = true
    self.fullScreenCollectionView.alpha = 0.8
    self.view.layoutIfNeeded()
    UIView.animate(withDuration: 0.8, delay: 0.4, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
        self.view.transform = scaleTransform
        self.fullScreenCollectionView.transform = scaleTransform
        self.floatingContainerView.transform = scaleTransform
        self.view.alpha = 0.0
        self.view.layoutIfNeeded()
    } completion: { (_) in
        self.fullScreenCollectionView.isHidden = true
        self.floatingContainerView.isHidden = true
        self.view.isHidden = true
    }
  }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        showFloatView()
        hideFloatView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
    }
    
    var canAnimate = true
  fileprivate func showFloatView() {
        if canAnimate {
            UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations:  {
                self.canAnimate = true
                self.floatingContainerView.transform = .init(translationX: 0, y: -115)
            }) { (_) in
                 self.canAnimate = false
            }
        }
    }
    
   fileprivate func hideFloatView(){
        if !self.canAnimate {
            UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations:  {
                self.canAnimate = false
                self.floatingContainerView.transform = .init(translationX: 0, y: 110)
            }){ (_) in
                self.canAnimate = true
             }
         }
    }
    
    let floatingContainerView = UIView()
    fileprivate func setupFloatingControls()  {
        floatingContainerView.layer.cornerRadius = 16
        floatingContainerView.clipsToBounds = true
        floatingContainerView.translatesAutoresizingMaskIntoConstraints = false
        floatingContainerView.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        view.addSubview(floatingContainerView)
        
        let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        floatingContainerView.addSubview(blurVisualEffectView)
        blurVisualEffectView.layer.cornerRadius = 16
        blurVisualEffectView.layer.masksToBounds = true
        blurVisualEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        // add subviews
//        let image = UIImage(named: "articleimage1")
//        let imageView = UIImageView(image: image)
//        imageView.layer.cornerRadius = 16
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
     
        let label = UILabel()
        label.font = UIFont.init(name: "TheBoldFont", size:14)
        label.text = "august alsina: will smith gave me permission to sleep w/wife jada pinkett smith!!"
        label.textColor = .darkGray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        //floatingContainerView.addSubview(imageView)
        floatingContainerView.addSubview(label)

        NSLayoutConstraint.activate([
            floatingContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            floatingContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            floatingContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100),
            floatingContainerView.heightAnchor.constraint(equalToConstant: 94),

            blurVisualEffectView.topAnchor.constraint(equalTo: floatingContainerView.topAnchor),
            blurVisualEffectView.leadingAnchor.constraint(equalTo: floatingContainerView.leadingAnchor),
            blurVisualEffectView.trailingAnchor.constraint(equalTo: floatingContainerView.trailingAnchor),
            blurVisualEffectView.bottomAnchor.constraint(equalTo: floatingContainerView.bottomAnchor),
            
//            imageView.topAnchor.constraint(equalTo: floatingContainerView.topAnchor, constant: 2),
//            imageView.leftAnchor.constraint(equalTo: floatingContainerView.leftAnchor, constant: 8),
//            imageView.widthAnchor.constraint(equalToConstant: 110),
//            imageView.heightAnchor.constraint(equalToConstant: 90),
//
            label.topAnchor.constraint(equalTo: floatingContainerView.topAnchor, constant: 4),
            label.leftAnchor.constraint(equalTo: floatingContainerView.leftAnchor, constant: 4),
            label.rightAnchor.constraint(equalTo: floatingContainerView.rightAnchor, constant: -4),
            label.bottomAnchor.constraint(equalTo: floatingContainerView.bottomAnchor, constant: -4),
//            label.heightAnchor.constraint(equalToConstant: 40),
//            label.widthAnchor.constraint(equalToConstant: floatingContainerView.frame.width)
        ])
    }
}
