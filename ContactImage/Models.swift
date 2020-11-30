//
//  Models.swift
//  ContactImage
//
//  Created by Assem Mukhamadi on 28.11.2020.
//

import Foundation
import RealmSwift


class Contact: Object {
    @objc dynamic var name = ""
    @objc dynamic var number = ""
    @objc dynamic var image: NSData?
}
