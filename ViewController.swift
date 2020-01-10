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
    
    func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {return}
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Cell(caption: "LOL", fileName: "JO")
        pictureArray.append(person)
        imageLoaded()
        tableView?.reloadData()
        
        dismiss(animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictureArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? labelCell
        let picture = pictureArray[indexPath.row]
        cell?.name.text = (picture.caption)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let picture = pictureArray[indexPath.item]
            vc.selectedImage = picture.caption
            imageLoaded()
            navigationController?.pushViewController(vc, animated: true)
            
            
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


