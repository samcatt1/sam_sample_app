//
//  GameDetailPageViewController.swift
//  Sam-Sample-App
//
//  Created by Samantha Cattani on 2023-09-17.
//

import Foundation
import UIKit

class GameDetailPageViewController: UIViewController {
    
    private var tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(GameDetailCellView.self, forCellReuseIdentifier: String(describing: GameDetailCellView.self))
        tableView.register(
            UINib(nibName: "GameTableCell", bundle: nil),
            forCellReuseIdentifier: "GameTableCell"
        )
        
        self.view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(
            equalTo: self.view.leadingAnchor
        ).isActive = true
        tableView.trailingAnchor.constraint(
            equalTo: self.view.trailingAnchor
        ).isActive = true
        tableView.topAnchor.constraint(
            equalTo: self.view.topAnchor
        ).isActive = true
        tableView.bottomAnchor.constraint(
            equalTo: self.view.bottomAnchor
        ).isActive = true
        
        API.getMatchDetails()
    }
    
}

extension GameDetailPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return indexPath.row == 0 && indexPath.section == 0 ?
        tableView.dequeueReusableCell(
            withIdentifier: "GameTableCell",
            for: indexPath
        ) : tableView.dequeueReusableCell(
            withIdentifier: String(describing: GameDetailCellView.self),
            for: indexPath
        )
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 && indexPath.section == 0 ? 159.0 : UITableView.automaticDimension
    }
}
