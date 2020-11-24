//
//  ViewController.swift
//  ContactImage
//
//  Created by Assem Mukhamadi on 24.11.2020.
//

import UIKit
import ContactsUI

class ViewController: UIViewController {

    let contactsController = CNContactPickerViewController()
    
    let vc = UIImagePickerController()
    
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var imageField: UIImageView!
    
    @IBAction func addContact(_ sender: UIButton) {
        self.present(contactsController, animated: true, completion: nil)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

            /*If you want work actionsheet on ipad
            then you have to use popoverPresentationController to present the actionsheet,
            otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                alert.popoverPresentationController?.sourceView = sender
                alert.popoverPresentationController?.sourceRect = sender.bounds
                alert.popoverPresentationController?.permittedArrowDirections = .up
            default:
                break
        }

        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsController.delegate = self
        vc.delegate = self
    }

    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            vc.sourceType = UIImagePickerController.SourceType.camera
            vc.allowsEditing = true
            self.present(vc, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func openGallary()
    {
        vc.sourceType = UIImagePickerController.SourceType.photoLibrary
        vc.allowsEditing = true
        self.present(vc, animated: true, completion: nil)
    }

}


extension ViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        print(contact.phoneNumbers[0].value.stringValue)
        self.contactLabel.text = contact.phoneNumbers[0].value.stringValue
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageField.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
