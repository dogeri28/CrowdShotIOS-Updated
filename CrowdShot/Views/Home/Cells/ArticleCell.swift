//
//  ArticleCell.swift
//  CrowdShot
//
//  Created by Soni A on 22/12/2020.
//  Copyright © 2020 Thoughtlights. All rights reserved.
//

import Foundation
import UIKit

class ArticleCell: UICollectionViewCell {
    static let reuseIdentifier = "ArticleCell"

    // Image (image)
    // Title (title)
    // Username (text)
    
    var articleImageView : UIImageView = {
         let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFill
         imageView.layer.cornerRadius = 8
         imageView.layer.masksToBounds = true
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
    
    var articleTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.init(name: "TheBoldFont", size:18)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setupViews() {
        addSubview(articleImageView)
        addArticleGradientBackground()
        addSubview(articleTitle)
    
       NSLayoutConstraint.activate([
         articleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
         articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
         articleImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
         articleImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2),
         articleTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
         articleTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
         articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
       ])
    }
    
    private func addArticleGradientBackground(){
        let gradientView = UIView(frame: CGRect(x: 0, y: 0, width:frame.width, height: frame.height))
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.frame.size
        gradientLayer.colors = [UIColor.darkGray, UIColor.black.withAlphaComponent(1).cgColor]
        gradientView.layer.addSublayer(gradientLayer)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.80)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        addSubview(gradientView)
    }
}
