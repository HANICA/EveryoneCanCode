//
//  ViewController.swift
//  CamDemo
//
//  Created by J.A. Korten on 17-05-18.
//  Copyright © 2018 HAN University of Applied Sciences. All rights reserved.
//

// resources:
// https://stackoverflow.com/questions/40854886/swift-take-a-photo-and-save-to-photo-library
//

import UIKit

class ViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var photoImage: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var photoInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func letsTakeAPicture(_ sender: UIButton) {
        // don't forget to put NSCameraUsageDescription in your plist (asks user to authorize camera usage)
        // NSPhotoLibraryUsageDescription if you use the photo library!
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                //
            photoImage.image = image
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            saveImageToAppDirectory(image: image)
        }
    }

    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func saveImageToAppDirectory(image : UIImage) {
        let directoryPath           =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
        if let fileURL : URL       = directoryPath.appendingPathComponent("\(currentMomentToString()).png") {
            // better: use a guard!

            if let data = UIImageJPEGRepresentation(image, 1.0),
                !FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    // writes the image data to disk
                    try data.write(to: fileURL)
                    print("file saved")
                    photoInfoLabel.text = "Image saved to \(fileURL.path)"
                } catch {
                    print("error saving file:", error)
                    photoInfoLabel.text = "Alas, could not save file :("

                }
            }
        }
    }
    
    func currentMomentToString() -> String {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        return "\(day)\(month)\(year)\(hour)\(minutes)\(second)"
    }
    
}

