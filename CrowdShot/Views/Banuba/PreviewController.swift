//
//  PreviewController.swift
//  CrowdShot
//
//  Created by Soni A on 13/02/2021.
//

import UIKit

class PreviewController: UIViewController {
    
    var image: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = self.image
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}

