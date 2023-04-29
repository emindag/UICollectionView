//
//  CharacterCell.swift
//  UICollectionViewFlowLayout
//
//  Created by Emin Dağ on 29.04.2023.
//

import UIKit

final class CharacterCell: UICollectionViewCell {
    
    // MARK: - Reuse Identifier
    
    static let reuseIdetifier = String(describing: CharacterCell.self)
    
    // MARK: - Views
    
    private let characterImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let characterTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        characterImage.image = nil
        characterTitle.text = nil
    }
    
    private func prepareCell() {
        contentView.clipsToBounds = true
        contentView.addSubview(characterImage)
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        contentView.addSubview(characterTitle)
        NSLayoutConstraint.activate([
            characterTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            characterTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configureCell(image: UIImage?, title: String) {
        characterImage.image = image
        characterTitle.text = title
    }
}
