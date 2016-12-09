//
//  ViewController.swift
//  Albums
//
//  Created by Arthur Daurel on 09/12/2016.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import UIKit

class UserTableViewController: UIViewController {

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
  // MARK: - Properties
  fileprivate var dataSource = [User]()

  // *********************************************************************
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()

    nibRegistration()
  }

  private func nibRegistration() 
}

// *********************************************************************
// MARK: - Request
extension UserTableViewController {

  fileprivate func getUsers(_ manager: AlbumsManagerProtocol) {

    manager.fetchUser() { [weak self] result in
      guard let `self` = self else { return }

      switch result {
      case .success(let users):
        self.dataSource = users
      case .failure(let error):
        print("Error: \(error)")
      }
    }
  }
}

// *********************************************************************
// MARK: - UITableViewDataSource
extension UserTableViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return newsDataSource.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

    checkIfNeedToLoadMoreCell(section)

    guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: StoryboardIdentifiers.newsHeader.string) as? NewsHeaderViewCell else {
      fatalError("Error dequeueReusableHeader with identifier: \(StoryboardIdentifiers.newsHeader.string)")
    }

    return cell
  }
}

// *********************************************************************
// MARK: - UITableViewDelegate
extension UserTableViewController: UITableViewDelegate {

  
}
