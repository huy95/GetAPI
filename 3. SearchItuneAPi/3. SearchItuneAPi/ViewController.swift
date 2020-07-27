//
//  ViewController.swift
//  3. SearchItuneAPi
//
//  Created by Huy on 7/27/20.
//  Copyright © 2020 Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var apiData: [Item]?
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collection.backgroundColor = .white
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.addComponent()
        self.setupLayout()
        self.configCollectionView()
        self.configSearchBar()
        self.fetchRequest("")
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func addComponent() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    func setupLayout() {
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
    }
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configSearchBar() {
        searchBar.delegate = self
    }
    
    func fetchRequest(_ name: String) {
        
        let url = String(format: "https://itunes.apple.com/search?term=%@&limit=20", name)
        
        // Trả về bộ ký tự cho các ký tự được phép trong thành phần URL truy vấn.
        guard let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let urlRequest = URL(string: urlString) else {
                return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse else { return }
            guard let strongSelf = self else { return }
            print(response.statusCode)
            
            if response.statusCode == 200 {
                do {
                    let recieveData = try JSONDecoder().decode(Result.self, from: data)
                    DispatchQueue.main.async {
                        strongSelf.apiData = recieveData.results
                        strongSelf.collectionView.reloadData()
                    }
                } catch {
                    print("error: \(error)")
                }
            }
        }
        dataTask.resume()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.apiData = apiData?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = ((collectionView.frame.size.width - 1 - 8) / 2)
        return CGSize(width: size, height: size * 3 / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    // hàm trả về khoảng cách giữa 2 item (tương tự 2 cột)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = DetailViewController()
        destinationVC.detailData = apiData![indexPath.row]
//        navigationController?.pushViewController(destinationVC, animated: true)
        let navigation = UINavigationController(rootViewController: destinationVC)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true, completion: nil)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.fetchRequest(searchText)
        self.collectionView.reloadData()
    }
}

