//
//  AuthVC.swift
//  Spotify
//
//  Created by Enes Sancar on 27.08.2023.
//

import UIKit
import WebKit

final class AuthVC: UIViewController, WKNavigationDelegate {
    
    private let webView: WKWebView = {
        let preference = WKWebpagePreferences()
        preference.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = preference
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    
    public var completionHandler: ((Bool) -> Void)?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        
    }
    
    private func configureVC() {
        title = "Sign In"
        view.backgroundColor = .systemBackground
        
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        guard let url = AuthManager.shared.signInURL else {return}
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code"})?.value else {
            return
        }
        webView.isHidden = true
        
        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
            guard let self else { return }
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                self.completionHandler?(success)
            }
        }
    }
}
