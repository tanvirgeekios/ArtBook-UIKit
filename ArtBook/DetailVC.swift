//
//  DetailVCViewController.swift
//  ArtBook
//
//  Created by MD Tanvir Alam on 16/3/21.
//

import UIKit
import CoreData

class DetailVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(gestureRecognizer)
        image.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        image.addGestureRecognizer(imageTapRecognizer)
    }
    
    @objc func hideKeyBoard(){
        view.endEditing(true)
    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = Paintings(context: context)
        newPainting.artist = artistText.text
        newPainting.name = artistText.text
        if let yearText = yearText.text{
            if yearText.isInt32{
                newPainting.year = Int32(yearText)!
            }
        }
        newPainting.id = UUID()
        let data = image.image?.jpegData(compressionQuality: 0.5)
        if let data = data{
            newPainting.image = data
        }
        do {
            try context.save()
            print("success")
        } catch  {
            print("Error saving Data")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension String{
    var isInt32:Bool{
        return Int32(self) != nil
    }
}
