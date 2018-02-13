//
//  SearchViewController.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import UIKit
import PKHUD

var SearchEntryCellIdentifier = "searchEntryCellIdentifier"

class SearchViewController: UIViewController {

    // MARK: - Injections
    var presenter: SearchPresenterProtocol?
    
    // MARK: - Instance Properties
    var data: UpcomingDisplayData?
    
    // MARK: - Outlets
    @IBOutlet weak var noContentView: NoContentView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var stopSearching: UIBarButtonItem!
    @IBOutlet weak var bottomIndent: NSLayoutConstraint!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Actions
    @IBAction func stopSearching(_ sender: UIBarButtonItem) {
        presenter?.stopSearching()
    }
    
    // MARK: - Notifications
    @objc func keyboardWillChangeFrame(notification: Notification) {
        if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardFrame.origin.y < view.frame.size.height {
                bottomIndent.constant = -keyboardFrame.height
            } else {
                 bottomIndent.constant = 0.0
            }
            UIView.animate(withDuration: 0.3, animations: {
                self.view.setNeedsLayout()
            })
        }
    }
    
    // MARK: - Private Methods
    fileprivate func configureView() {
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func show(results: Bool) {
        tableView.isHidden = !results
        noContentView.isHidden = results
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let upcomingItem = data?.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchEntryCellIdentifier, for: indexPath)
        cell.textLabel?.text = upcomingItem?.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let upcomingItem = data?.rows[indexPath.row] else { return }
        presenter?.showRepositoryDetail(upcomingItem)
    }
}

// MARK: - SearchViewInterface
extension SearchViewController: SearchViewInterface {
    func showErrorPopUp(error text: String) {
        HUD.flash(.label(text), delay: 2.0)
    }
    
    func showNoContentMessage(_ text: String) {
        show(results: false)
        noContentView.setText(text)
    }
    
    func startSearching() {
        stopSearching.isEnabled = true
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func finishSearching() {
        stopSearching.isEnabled = false
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func showRepositories(_ data: UpcomingDisplayData) {
        show(results: true)
        
        self.data = data
        reloadEntries()
    }
    
    func reloadEntries() {
        tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.retrieveRepository(searchBar.text!)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.cancelSearching()
        
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
}
