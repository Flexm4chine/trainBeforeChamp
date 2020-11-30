//
//  UserDefaultsFile.swift
//  wsrRCH2019
//
//  Created by Admin on 14.11.2020.
//

import Foundation
import SwiftUI
import RealmSwift

class UserDefaultsSettings: Object {

    @objc dynamic var id = 0
    @objc dynamic var userName = ""
    @objc dynamic var userPassword = ""
    @objc dynamic var userSex = ""

  override static func primaryKey() -> String? {
    "id"
  }
    
}


