//
//  UserInfoVC.swift
//  TechMahindra Demo
//
//  Created by Subba Reddy on 8/4/20.
//  Copyright © 2020 Subba Reddy. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let userInfoTableView = UITableView()
    var viewModel:UserViewModel?
    private let refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserViewModel(delegate: self)
        viewModel?.getDataFromServer()
        userInfoTableView.refreshControl = refreshControl
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        view.backgroundColor = .white
        view.addSubview(userInfoTableView)
        configureTableView()
        userInfoTableView.dataSource = self
        userInfoTableView.delegate = self
        userInfoTableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: "userInfoCell")
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        viewModel?.getDataFromServer()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    func configureTableView() {
        userInfoTableView.translatesAutoresizingMaskIntoConstraints = false
        userInfoTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        userInfoTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        userInfoTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        userInfoTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
extension UserInfoVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.userInfoArray?.rows?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath) as! UserInfoTableViewCell
        if let userinfo = viewModel?.userInfoArray?.rows?[indexPath.row]{
            cell.updateCellData(userInfo: userinfo)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension UserInfoVC:UserViewModelDelegate{
    func updateTableViewData() {
        DispatchQueue.main.async { [weak self] in
            self?.userInfoTableView.reloadData()
            self?.navigationItem.title = self?.viewModel?.userInfoArray?.title ?? ""
            self?.refreshControl.endRefreshing()
        }
    }
    
    
}
