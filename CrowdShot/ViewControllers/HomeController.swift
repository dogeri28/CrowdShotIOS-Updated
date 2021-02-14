//
//  HomeController.swift
//  CrowdShot
//
//  Created by Soni A on 22/11/2020.
//  Copyright © 2020 Thoughtlights. All rights reserved.
//

import UIKit
import AVFoundation

class HomeController: UIViewController, UICollectionViewDelegate{
   
    enum Section: Int {
        case header = 1
        case post = 2
    }
    
   lazy var homeCollectionView : UICollectionView = {
        var layout = HomeLayoutManager.createLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.isPrefetchingEnabled = false
        return collectionView
    }()
    
    var dataSource : UICollectionViewDiffableDataSource<Section, Post>!
    var snapshot : NSDiffableDataSourceSnapshot<Section, Post>!
    
    enum SupplementaryElementKind {
        static let sectionHeader = "supplementary-section-header"
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupCollectionView()
        configureDataSource()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("i appeared")
    }

    func setupCollectionView()  {
        setNeedsStatusBarAppearanceUpdate()
        // quirk fixes navigation bar style to white (even though its black)
        self.navigationController?.navigationBar.barStyle = .black
        view.addSubview(homeCollectionView)
        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo:view.topAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            homeCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        homeCollectionView.register(HomeSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier)
        homeCollectionView.register(PostCell.self, forCellWithReuseIdentifier: PostCell.reuseIdentifier)
        
    }
    
    func configureDataSource()  {
        
        snapshot = NSDiffableDataSourceSnapshot()
        snapshot.appendSections([Section.post])

        let postDataSource = FakePostDataStore()
        let postItems = postDataSource.getPosts()
        
        snapshot.appendItems(postItems)
        dataSource = UICollectionViewDiffableDataSource<Section, Post>(collectionView: homeCollectionView, cellProvider: { (collectionView, indexPath, number) -> UICollectionViewCell? in
           guard let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.reuseIdentifier, for: indexPath) as? PostCell else {
               fatalError("Cannot create new cell")
           }
          
            
    
            
            
        //postCell.profileImage.image = UIImage(named: postItems[indexPath.row].coverImage)
            postCell.layer.shouldRasterize = true;
            postCell.layer.rasterizationScale = UIScreen.main.scale;
           postCell.setupPlayerViewAndLoadVideo(videoUrl: postItems[indexPath.row].videoUrl)
 
        return postCell
      })

     dataSource.supplementaryViewProvider = {collectionView, kind, indexPath in
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier, for: indexPath) as! HomeSectionHeaderView
            return header
          }
         return nil
        }
       
        dataSource.apply(snapshot)
      }
    
    // fullscreen animation variables
    var startingFrame :CGRect?
    var fullScreenController:HomeFullScreenController!
    var topConstraint:NSLayoutConstraint?
    var leadingConstraint:NSLayoutConstraint?
    var widthConstraint:NSLayoutConstraint?
    var heightConstraint:NSLayoutConstraint?

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        fullScreenController = HomeFullScreenController()

        let redView = fullScreenController.view!
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveRedView)))
        redView.layer.cornerRadius = 8
        redView.layer.masksToBounds = true
        view.addSubview(redView)
        addChild(fullScreenController)
    
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
    
        // to do remove items
        // let postDataSource = FakePostDataStore()
        // let postItems = postDataSource.getPosts()
        //fullScreenController.setupPlayerViewAndLoadVideo(videoUrl: postItems[indexPath.row].videoUrl)
        
        // absolute co-ordinates of uicollectionview cell
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
        
        topConstraint = redView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = redView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = redView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach {$0?.isActive = true}
        self.view.layoutIfNeeded()
         
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
        self.toggleTabbar()
        } completion: { (_) in
        
        }
    }

    @objc func handleRemoveRedView(gesture: UITapGestureRecognizer)  {
        self.fullScreenController.removeView()
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            guard let startingFrame = self.startingFrame else { return }
            self.topConstraint?.constant =  startingFrame.origin.y
            self.leadingConstraint?.constant =  startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            self.view.layoutIfNeeded()
  
          self.toggleTabbar()
        } completion: {  (_) in
            gesture.view?.removeFromSuperview()
            self.fullScreenController.removeFromParent()
        }
    }
    // TODO: Turn this method to an extension / helper method
    func toggleTabbar() {
        guard var frame = tabBarController?.tabBar.frame else { return }
        let hidden = frame.origin.y == view.frame.size.height
        frame.origin.y = hidden ? view.frame.size.height - frame.size.height : view.frame.size.height
        UIView.animate(withDuration: 0.7, delay: 0.2, usingSpringWithDamping: 0, initialSpringVelocity: 0.7, options: .curveEaseOut){
            self.tabBarController?.tabBar.frame = frame
        }
    }
    
    func hideTabBarGlitch()  {
        guard var frame = tabBarController?.tabBar.frame else { return }
        let hidden = frame.origin.y == view.frame.size.height
        if !hidden {
            // if tab bar is visible when its not meant to be
            // when the app comes back from the foreground we
            // hide it here.
            frame.origin.y = view.frame.size.height
            self.tabBarController?.tabBar.frame = frame
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in homeCollectionView.visibleCells {
            guard let indexPath = homeCollectionView.indexPath(for: cell) else {return}
            let postCell:PostCell = homeCollectionView.cellForItem(at: indexPath) as! PostCell
            postCell.play()
       }
    }
 }
