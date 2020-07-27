//
//  CollectionViewCell.swift
//  3. SearchItuneAPi
//
//  Created by Huy on 7/27/20.
//  Copyright © 2020 Huy. All rights reserved.
//

import UIKit

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var apiData: Item? {
        didSet {
            if let data = apiData {
                nameLabel.text = data.trackName
                
                guard let url = URL(string: data.artworkUrl100 ?? "") else { return }
                do {
                    let dataImage = try Data(contentsOf: url)
                    bookImageView.image = UIImage(data: dataImage)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "", size: 14)
        return label
    }()
    
    var bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(contentsOfFile: "")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        
        addComponent()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addComponent() {
        self.addSubview(bookImageView)
        self.addSubview(nameLabel)
    }
    
    func setupLayout() {
        bookImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        bookImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        bookImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        bookImageView.heightAnchor.constraint(equalTo: bookImageView.widthAnchor, multiplier: 1).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: bookImageView.trailingAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    
    
}
