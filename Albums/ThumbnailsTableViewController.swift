//
//  ThumbnailsTableViewController.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import UIKit

class ThumbnailsTableViewController: UIViewController {

  // *********************************************************************
  // MARK: - IBOutlets
  @IBOutlet weak var collectionView: UITableView! {
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
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = "Thumbnail"

    nibRegistration()
    getAlbums(albumsManager, id: userId)
  }

  private func nibRegistration() {

    collectionView.register(UINib(nibName: "ChallengesCollectionViewCell", bundle: nil),
                            forCellWithReuseIdentifier: cellIdentifier)
  }
}

// *********************************************************************
// MARK: - Request
extension ThumbnailsTableViewController {

  fileprivate func getAlbums(_ manager: AlbumsManagerProtocol, id: Int) {

    manager.fetchAlbum(id) { [weak self] result in
      guard let `self` = self else { return }

      switch result {
      case .success(let albums):
        self.dataSource = albums
        self.tableView.reloadData()
      case .failure(let error):
        print("Error: \(error)")
      }
    }
  }
}

// *********************************************************************
// MARK: - UITableViewDataSource
extension ThumbnailsTableViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: albumCellIdentifier,
                                                   for: indexPath) as? AlbumTableViewCell
      else {
        fatalError("Error dequeueReusableCell with identifier: \(albumCellIdentifier)")
    }

    cell.setupView(dataSource[(indexPath as IndexPath).row])
    return cell
  }
}

// *********************************************************************
// MARK: - UITableViewDelegate
extension ThumbnailsTableViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    tableView.deselectRow(at: indexPath, animated: true)

    self.performSegue(withIdentifier: thumbnailsSegueIdentifier, sender: self)
  }
}
