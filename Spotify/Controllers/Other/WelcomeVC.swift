//
//  WelcomeVC.swift
//  Spotify
//
//  Created by Enes Sancar on 27.08.2023.
//

import UIKit
import SnapKit

final class WelcomeVC: UIViewController {
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
    }
    
    private func configureVC() {
        title = "Spotify"
        view.backgroundColor = .systemBackground
        
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    @objc private func didTapSignIn() {
        let vc = AuthVC()
        vc.completionHandler = { [weak self] success in
            guard let self else { return }
            DispatchQueue.main.async {
                self.handleSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        guard success else {
            showAlert(alertText: "Oops",
                      alertMessage: "Something went wrong when signing in")
            return
        }
        let mainAppTabBarVC = TabBarVC()
        mainAppTabBarVC.modalPresentationStyle = .fullScreen
        present(mainAppTabBarVC, animated: true)
    }
}

extension WelcomeVC {
    private func configureUI() {
        signInButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
}
