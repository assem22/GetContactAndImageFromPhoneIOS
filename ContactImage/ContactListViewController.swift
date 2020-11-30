//
//  ContactListViewController.swift
//  ContactImage
//
//  Created by Assem Mukhamadi on 28.11.2020.
//

import UIKit
import RealmSwift

class ContactListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var contacts: Results<Contact>{
        get{
            return realm.objects(Contact.self)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.tableView.reloadData()
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let contact = contacts[indexPath.row]
        cell.name.text = contact.name
        cell.phone.text = contact.number
        let image: UIImage = UIImage(data: contact.image! as Data)!
        cell.photo.image = image
        return cell
    }
    
}
