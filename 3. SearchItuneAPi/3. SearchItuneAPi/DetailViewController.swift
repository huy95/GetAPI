//
//  DetailViewController.swift
//  3. SearchItuneAPi
//
//  Created by Huy on 7/27/20.
//  Copyright © 2020 Huy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailData: Item? {
        didSet {
            if let data = detailData {
                nameLabel.text! += data.trackName ?? ""
                priceLabel.text! += data.trackPrice?.description ?? ""
                collectionLabel.text! += data.collectionName ?? ""
                
                guard let url = URL(string: data.artworkUrl100 ?? "") else { return }
                do {
                    let dataImage = try Data(contentsOf: url)
                    trailerImageView.image = UIImage(data: dataImage)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name: "
        label.numberOfLines = 0
        return label
    }()
    
    var trailerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(contentsOfFile: "")
        return imageView
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Price: "
        return label
    }()
    
    var collectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Collection: "
        return label
    }()
    
    var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemPink, for: .highlighted)
        button.backgroundColor = .clear
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addComponent()
        setupLayout()
        setupButton()
        setNavi()
    }
    func setNavi(){
    
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(cancelPress))
        // đổi màu button trên thanh navigationBar
        cancelButton.tintColor = UIColor.orange
        navigationItem.leftBarButtonItem = cancelButton
    }
    @objc func cancelPress(){
        dismiss(animated: true, completion: nil)
    }
    func addComponent() {
        view.addSubview(nameLabel)
        view.addSubview(trailerImageView)
        view.addSubview(collectionLabel)
        view.addSubview(priceLabel)
        view.addSubview(playButton)
    }
    
    func setupLayout() {
        [trailerImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
         trailerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
         trailerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
         trailerImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
            ].map { (anchor) in anchor.isActive = true }
        
        [nameLabel.topAnchor.constraint(equalTo: trailerImageView.bottomAnchor, constant: 8),
         nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
         nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
         nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)].map({(anchor) in anchor.isActive = true})
        
        [collectionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
         collectionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
         collectionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
         collectionLabel.heightAnchor.constraint(equalToConstant: 24)].map { (anchor) in anchor.isActive = true}
        
        [priceLabel.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor, constant: 8),
         priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
         priceLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
         priceLabel.heightAnchor.constraint(equalToConstant: 24)].map { (anchor) in anchor.isActive = true}
        
        [playButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
         playButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
         playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         playButton.heightAnchor.constraint(equalToConstant: 48)].map { (anchor) in anchor.isActive = true}
    }
    
    func setupButton() {
        playButton.addTarget(self, action: #selector(routeToVideoVC), for: .touchUpInside)
    }
    
    @objc func routeToVideoVC() {
        let destinationVC = VideoViewController()
        destinationVC.previewUrl = detailData?.previewUrl
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

