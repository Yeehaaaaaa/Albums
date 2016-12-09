//
//  AlbumTableViewCell.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import UIKit

class AlbumTableViewCell: UITableViewCell {

  // *********************************************************************
  // MARK: - IBOutlets
  @IBOutlet weak var titleLabel: UILabel!

  // *********************************************************************
  // MARK: - LifeCycle
  func setupView(_ album: Album) {

    titleLabel.text = album.title
  }
}
