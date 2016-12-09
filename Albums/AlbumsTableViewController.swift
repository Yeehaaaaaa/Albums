//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import Foundation
import UIKit

class AlbumsTableViewController: UIViewController {

  // *********************************************************************
  // MARK: - IBOutlets
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.estimatedRowHeight = 100
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.delegate = self
      tableView.dataSource = self
    }
  }

  // *********************************************************************
  // MARK: - Manager
  var albumsManager: AlbumsManagerProtocol!

  // *********************************************************************
  // MARK: - Properties
  fileprivate var dataSource = [Album]()
  var userId: Int!

  // *********************************************************************
  // MARK: - Constant
  fileprivate var albumCellIdentifier = "albumCell"
  fileprivate var thumbnailsSegueIdentifier = "goToThumbnails"

  // *********************************************************************
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = "Albums"

    nibRegistration()
    getAlbums(albumsManager, id: userId)
  }

  private func nibRegistration() {

    tableView.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: albumCellIdentifier)
  }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
      switch (segue.identifier, segue.destination) {
  
      case (thumbnailsSegueIdentifier?, let viewController as ThumbnailsCollectionViewController):
        if let albumId = sender as? Int {

          viewController.albumsManager = albumsManager
          viewController.albumId = albumId
        }
      default:
        break
      }
    }
}

// *********************************************************************
// MARK: - Request
extension AlbumsTableViewController {

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
extension AlbumsTableViewController: UITableViewDataSource {

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
    cell.backgroundColor = UIColor.clear
    return cell
  }
}

// *********************************************************************
// MARK: - UITableViewDelegate
extension AlbumsTableViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    tableView.deselectRow(at: indexPath, animated: true)

    self.performSegue(withIdentifier: thumbnailsSegueIdentifier, sender: dataSource[(indexPath as IndexPath).row].userId)
  }
}
