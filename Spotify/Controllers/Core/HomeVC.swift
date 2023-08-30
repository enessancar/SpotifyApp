//
//  ViewController.swift
//  Spotify
//
//  Created by Enes Sancar on 27.08.2023.
//

import UIKit

final class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Browse"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        
        fetchData()
    }
    
    private func fetchData() {
        APICaller.shared.getNewReleases { result in
            switch result {
            case .success(let success):
                print(success.albums.items[0].name)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    @objc private func didTapSettings() {
        let vc = SettingsVC()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

