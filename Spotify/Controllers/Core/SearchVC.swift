//
//  SearchVC.swift
//  Spotify
//
//  Created by Enes Sancar on 27.08.2023.
//

import UIKit

final class SearchVC: UIViewController {
    
    //MARK: - Properties
    private let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultVC())
        vc.searchBar.placeholder = "Songs, Artists, Albums"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = .init(top: 2, leading: 7, bottom: 2, trailing: 7)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(150)),
                subitem: item,
                count: 2
            )
            group.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
            return NSCollectionLayoutSection(group: group)
        }))
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        view.addSubview(collectionView)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.idenditifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

//MARK: - Search Result
extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultController = searchController.searchResultsController as? SearchResultVC,
              let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
    }
}

//MARK: - Collection View
extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.idenditifier, for: indexPath) as? GenreCollectionViewCell else {
            fatalError()
        }
        cell.backgroundColor = .systemGreen
        return cell
    }
}
