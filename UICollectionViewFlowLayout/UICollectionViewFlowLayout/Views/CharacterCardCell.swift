//
//  CharacterCardCell.swift
//  UICollectionViewFlowLayout
//
//  Created by Emin Dağ on 29.04.2023.
//

import UIKit

final class CharacterCardCell: UICollectionViewCell {
    
    static let resuseIdentifier = String(describing: CharacterCardCell.self)
    
    private let characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return imageView
    }()
    
    private let characterTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
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
        super.prepareForReuse()
        characterImage.image = nil
        characterTitle.text = nil
    }
    
    private func prepareCell() {
        contentView.backgroundColor = .systemCyan
        contentView.layer.cornerRadius = 12
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 5
        contentView.clipsToBounds = true
        
        contentView.addSubview(characterImage)
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        contentView.addSubview(characterTitle)
        NSLayoutConstraint.activate([
            characterTitle.topAnchor.constraint(equalTo: characterImage.bottomAnchor),
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
