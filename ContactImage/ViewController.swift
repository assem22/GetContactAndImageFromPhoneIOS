//
//  ViewController.swift
//  ContactImage
//
//  Created by Assem Mukhamadi on 24.11.2020.
//

import UIKit
import RealmSwift
import ContactsUI
import Photos


class ViewController: UIViewController {
    
    let realm = try! Realm()
    var incomingData: Contact? = nil
    
    let contactsController = CNContactPickerViewController()
    
    let imageController = UIImagePickerController()
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var imageField: UIImageView!
    
    @IBAction func saveContact(_ sender: UIButton) {
        let newContact = Contact()
        newContact.name = name.text!
        newContact.number = contactLabel.text!
        let image = NSData(data: imageField.image!.jpegData(compressionQuality: 0.5)!)
        newContact.image = image
        try! realm.write{
            realm.add(newContact)
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ContactListViewController") as? ContactListViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
    
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
        imageController.delegate = self
    }

    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imageController.sourceType = UIImagePickerController.SourceType.camera
            imageController.allowsEditing = true
            self.present(imageController, animated: true, completion: nil)
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
        imageController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imageController.allowsEditing = true
        self.present(imageController, animated: true, completion: nil)
    }

}


extension ViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        print(contact.phoneNumbers[0].value.stringValue)
        print(contact.familyName + " " + contact.familyName)
        self.contactLabel.text = contact.phoneNumbers[0].value.stringValue
        self.name.text = contact.givenName + " " + contact.familyName
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
