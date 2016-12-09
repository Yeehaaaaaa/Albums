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
  fileprivate var albumsManager: AlbumsManagerProtocol!

  // *********************************************************************
  // MARK: - Properties
  fileprivate var dataSource = [User]()

  // *********************************************************************
  // MARK: - Constant
  fileprivate var userCellIdentifier = "userCell"
  fileprivate var albumSegueIdentifier = "goToAlbum"

  // *********************************************************************
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()

    albumsManager = AppManager.sharedInstance.container.resolve(AlbumsManagerProtocol.self)

    nibRegistration()
    getUsers(albumsManager)
  }

  private func nibRegistration() {

    tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: userCellIdentifier)
  }

  //  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  //
  //    switch (segue.identifier, segue.destination) {
  //
  //    case (albumSegueIdentifier?, let viewController as CommentTableViewController):
  //      if let cell = sender as? Int {
  //
  //
  //      }
  //    }
  //  }
}

// *********************************************************************
// MARK: - Request
extension AlbumsTableViewController {

  fileprivate func getUsers(_ manager: AlbumsManagerProtocol) {

    manager.fetchUser() { [weak self] result in
      guard let `self` = self else { return }

      switch result {
      case .success(let users):
        self.dataSource = users
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

    guard let cell = tableView.dequeueReusableCell(withIdentifier: userCellIdentifier,
                                                   for: indexPath) as? UserTableViewCell
      else {
        fatalError("Error dequeueReusableCell with identifier: \(userCellIdentifier)")
    }

    cell.setupView(dataSource[(indexPath as IndexPath).row])
    return cell
  }
}

// *********************************************************************
// MARK: - UITableViewDelegate
extension AlbumsTableViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    tableView.deselectRow(at: indexPath, animated: true)

    self.performSegue(withIdentifier: albumSegueIdentifier, sender: self)
  }
}
