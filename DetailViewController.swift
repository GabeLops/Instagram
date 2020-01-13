//
//  DetailViewController.swift
//  Challenge4
//
//  Created by Gabriel Lops on 1/6/20.
//  Copyright © 2020 Gabriel Lops. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: Cell?
    var path: URL?
    
    override func viewDidLoad() {
           super.viewDidLoad()
        title = "Picture"
        if selectedImage != nil {
             imageView.image = UIImage(contentsOfFile: path!.path)
         }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
