//
//  CarouselLayoutViewController.swift
//  UICollectionViewFlowLayout
//
//  Created by Emin Dağ on 29.04.2023.
//

import UIKit

final class CarouselLayoutViewController: UIViewController {
    
    private let characters = Characters.loadCharacters()
    
    private let collectionView: UICollectionView = {
        let layout = CarouselLayout()
        layout.itemSize = CGSize(width: 200, height: 300)
        layout.minimumLineSpacing = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        configureCollectionView()
    }
    
    private func prepareView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = .systemMint
        collectionView.register(CharacterCardCell.self, forCellWithReuseIdentifier: CharacterCardCell.resuseIdentifier)
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource

extension CarouselLayoutViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCardCell.resuseIdentifier, for: indexPath) as? CharacterCardCell else {
            fatalError()
        }
        
        let character = characters[indexPath.item]
        let characterImage = UIImage(named: character.name)
        cell.configureCell(image: characterImage, title: character.title)
        
        return cell
    }
}
