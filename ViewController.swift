//
//  ViewController.swift
//  Challenge4
//
//  Created by Gabriel Lops on 1/5/20.
//  Copyright © 2020 Gabriel Lops. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    var pictureArray = [Cell]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addnewPicture))
        let defaults = UserDefaults.standard
        if let savedPictures = defaults.object(forKey: "load") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                pictureArray = try jsonDecoder.decode([Cell].self, from: savedPictures)
            } catch {
                print("Failed to load data")
            }
        }
        
    }


   @objc func addnewPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .camera
        present(picker, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictureArray.count
    }
   // override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? Cell
     //   return cell
  //  }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let picture = pictureArray[indexPath.item]
            
            
        }
    }
    func imageLoaded() {
        let jsonEncoder = JSONEncoder()
        if let imageLoad = try? jsonEncoder.encode(pictureArray) {
            let defaults = UserDefaults.standard
            defaults.set(imageLoad, forKey: "load")
            
        }else {
            print("Failed to load image.")
        }
    }

}


