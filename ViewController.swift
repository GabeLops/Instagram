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
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let photo = Cell(caption: "Enter Caption", fileName: imageName)
        pictureArray.append(photo)
        imageLoaded()
        tableView.reloadData()
        dismiss(animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictureArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let photo = pictureArray[indexPath.row]
        let path = getDocumentsDirectory().appendingPathComponent(photo.fileName)
        
        cell.textLabel?.text = photo.caption
        //shows preview of image in tableview
        cell.imageView?.image = UIImage(contentsOfFile: path.path)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let photo = pictureArray[indexPath.row]
            let path = getDocumentsDirectory().appendingPathComponent(photo.fileName)
                
                let ac = UIAlertController(title: "Add Caption", message: nil, preferredStyle: .alert)
                ac.addTextField()
                ac.addAction(UIAlertAction(title: "Add Caption", style: .default, handler: {
                    [weak self, weak ac] _ in
                    guard let caption = ac?.textFields?[0].text else { return }
                    photo.caption = caption
                    self?.imageLoaded()
                    self?.tableView.reloadData()
                }))
                ac.addAction(UIAlertAction(title: "Delete", style: .destructive){
                    [weak self]  _ in
                    self?.pictureArray.remove(at: indexPath.item)
                    self?.imageLoaded()
                    self?.tableView.reloadData()
                })
                ac.addAction(UIAlertAction(title: "View", style: .default, handler: {
                    [weak self] _ in
                    if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                        vc.selectedImage = photo
                        vc.path = path
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                } ))
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                present(ac, animated: true)
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


