//
//  ViewController.swift
//  URLSection+Alamofire
//
//  Created by Huy on 7/27/20.
//  Copyright © 2020 Huy. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var tableView : UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableCell.self, forCellReuseIdentifier: "APICell")
        return tableView
    }()
    var apiData : [Item] = []
    override func viewDidLoad() {
        title = "URLSection"
        super.viewDidLoad()
        setupLayout()
        reciveData()
    }
    func setupLayout(){
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    func reciveData(){
        let url = "https://api.stackexchange.com/2.2/questions?order=desc&sort=votes&site=stackoverflow"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { [weak self] (response) in
            print("Response: \(response.result)")
            guard let data = response.data, let strongSelf = self else {
                return
            }

            strongSelf.apiData = Items.parseData(data)
            strongSelf.tableView.reloadData()
        }
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "APICell", for: indexPath) as! TableCell
        cell.titleContentLabel.text = apiData[indexPath.row].title
        cell.tagsContentLabel.text = "\(apiData[indexPath.row].tags)"
        cell.answerCountContentLabel.text = "\(apiData[indexPath.row].answer_count)"
        cell.scoreContentLabel.text = "\(apiData[indexPath.row].score)"
        cell.linkContentLabel.text = apiData[indexPath.row].link
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    
}
