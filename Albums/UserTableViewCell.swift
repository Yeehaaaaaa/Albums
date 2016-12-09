//
//  UserTableViewCell.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import UIKit

class UserTableViewCell: UITableViewCell {

  // *********************************************************************
  // MARK: - IBOutlets
  @IBOutlet weak var nameLabel: UILabel!
  
  // *********************************************************************
  // MARK: - LifeCycle
  func setupView(_ user: User) {

    nameLabel.text = user.name
  }
}
