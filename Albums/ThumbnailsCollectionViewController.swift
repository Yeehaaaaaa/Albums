//
//  ThumbnailsCollectionViewController.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import UIKit

class ThumbnailsCollectionViewController: UIViewController {

  // *********************************************************************
  // MARK: - IBOutlets
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView.delegate = self
      collectionView.dataSource = self
    }
  }

  // *********************************************************************
  // MARK: - Manager
  var albumsManager: AlbumsManagerProtocol!

  // *********************************************************************
  // MARK: - Properties
  fileprivate var dataSource = [Thumbnail]()
  var albumId: Int!

  // *********************************************************************
  // MARK: - Constant
  fileprivate var thumbnailsCellIdentifier = "thumbnailsCell"

  // *********************************************************************
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = "Thumbnail"

    nibRegistration()
    getThumbnails(albumsManager, id: albumId)
  }

  private func nibRegistration() {

    collectionView.register(UINib(nibName: "ThumbnailsCollectionViewCell", bundle: nil),
                            forCellWithReuseIdentifier: thumbnailsCellIdentifier)
  }
}

// *********************************************************************
// MARK: - Request
extension ThumbnailsCollectionViewController {

  fileprivate func getThumbnails(_ manager: AlbumsManagerProtocol, id: Int) {

    manager.fetchThumbnails(albumId) { [weak self] result in
      guard let `self` = self else { return }

      switch result {
      case .success(let thumbnails):
        self.dataSource = thumbnails
        self.collectionView.reloadData()
      case .failure(let error):
        print("Error: \(error)")
      }
    }
  }
}

// *********************************************************************
// MARK: - UITableViewDataSource
extension ThumbnailsCollectionViewController: UICollectionViewDataSource {


  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.count
  }

  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: thumbnailsCellIdentifier,
                                                        for: indexPath) as? ThumbnailsCollectionViewCell
      else {
      fatalError("Error dequeueReusableCell with identifier: \(thumbnailsCellIdentifier)")
    }

    cell.setupView(dataSource[(indexPath as IndexPath).row])
    return cell
  }
}

// *********************************************************************
// MARK: - UITableViewDelegate
extension ThumbnailsCollectionViewController: UICollectionViewDelegate {


  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {

    return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
  }
}
