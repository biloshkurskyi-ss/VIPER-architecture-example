//
//  PreviewViewController.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/12/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import UIKit
import WebKit

class PreviewViewController: UIViewController {

    // MARK: - Injections
    var presenter: PreviewPresenterProtocol?
    
    // MARK: - Instance Properties
    var transitioningBackgroundView : UIView = UIView()
    var webView: WKWebView!
    
    // MARK: - Constructor
    required init(coder aDecoder: NSCoder) {
        self.webView = WKWebView(frame: CGRect.zero)
        super.init(coder: aDecoder)!
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    // MARK: - Actions
    @IBAction func close(_ sender: UIBarButtonItem) {
        presenter?.cancelPreviewAction()
    }
    
    @objc func dissmissVC() {
        presenter?.cancelPreviewAction()
    }
    
    // MARK: - Private
    
    fileprivate func configureView() {
        view.insertSubview(webView, at: 0)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: webView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: webView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        view.addConstraints([height, width])
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PreviewViewController.dissmissVC))
        transitioningBackgroundView.isUserInteractionEnabled = true
        transitioningBackgroundView.addGestureRecognizer(gestureRecognizer)
    }
}

// MARK: - PreviewViewInterface
extension PreviewViewController: PreviewViewInterface {
    func openRepositoryPage(_ url: String) {
        let url = URL(string: url)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
