//
//  ThumbnailsCollectionViewCell.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ThumbnailsCollectionViewCell: UICollectionViewCell {

  // *********************************************************************
  // MARK: - IBOutlets
  @IBOutlet weak var imageView: UIImageView!

  // *********************************************************************
  // MARK: - LifeCycle
  func setupView(_ thumbnail: Thumbnail) {

    let url = URL(string: thumbnail.thumbnailUrl)

    imageView.kf.setImage(with: url)
  }
}
