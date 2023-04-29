//
//  BasicFlowLayoutViewController.swift
//  UICollectionViewFlowLayout
//
//  Created by Emin Dağ on 29.04.2023.
//

import UIKit

final class BasicFlowLayoutViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constant {
        static let columns: CGFloat = 3
        static let inset: CGFloat = 8
        static let spacing: CGFloat = 8
        static let lineSpacing: CGFloat = 8
    }
    
    // MARK: - Data
    
    let characters = Characters.loadCharacters()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemMint
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.reuseIdetifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource

extension BasicFlowLayoutViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.reuseIdetifier, for: indexPath) as? CharacterCell else {
            fatalError("")
        }
        
        let character = characters[indexPath.item]
        let characterImage = UIImage(named: character.name)
        cell.configureCell(image: characterImage, title: character.title)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BasicFlowLayoutViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int((collectionView.frame.width / Constant.columns) - (Constant.inset + Constant.spacing))
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(
            top: Constant.inset,
            left: Constant.inset,
            bottom: Constant.inset,
            right: Constant.inset
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constant.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constant.lineSpacing
    }
}
