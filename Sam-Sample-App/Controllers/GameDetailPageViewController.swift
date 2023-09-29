//
//  GameDetailPageViewController.swift
//  Sam-Sample-App
//
//  Created by Samantha Cattani on 2023-09-17.
//

import Foundation
import UIKit

class GameDetailPageViewController: UIViewController {
    
    var tableView = UITableView()
    var gameStatsModels: [GameDetailStatModel] = []
    var gameModel: GameCellViewModel?
    var matchId: Int = 0
    var hasLoaded = false
    var api = API()
    var hasError = false
    
    init(gameModel: GameCellViewModel? = nil, matchId: Int? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.gameModel = gameModel
        self.matchId = matchId ?? 0
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        setUpTableView()
        setTable()
    }
    
    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        tableView.register(GameDetailCellView.self,
                           forCellReuseIdentifier: String(describing: GameDetailCellView.self)
        )
        tableView.register(MessageCell.self,
                           forCellReuseIdentifier: String(describing: MessageCell.self)
        )
        tableView.register(
            UINib(nibName: String(describing: GameTableCell.self), bundle: nil),
            forCellReuseIdentifier: String(describing: GameTableCell.self)
        )
        tableView.register(LoadingTableCell.self,
                           forCellReuseIdentifier: String(describing: LoadingTableCell.self)
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
    }
    
    func setTable() {
        api.getMatchDetails(fixtureId: matchId) { models, hasError in
            self.hasError = hasError
            self.gameStatsModels = models
            self.hasLoaded = true
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension GameDetailPageViewController: UITableViewDelegate, UITableViewDataSource {
    // if the games have not loaded we still want to show 1 cell (loading cell)
    // if there are no stats we still want to show 2 cell (message & game cell)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hasLoaded ? (gameStatsModels.count == 0 ? 2 : gameStatsModels.count) : 1
    }
    
    // when we are waiting for the API to return the matches played, show loading cell
    // when there is an error, show the message cell with an error message
    // when we have loaded the data and when there are no stats for this game, show message cell with a description of this
    // when we have loaded the data and there are stats, show all of the stats using stat cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if hasError {
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: MessageCell.self),
                for: indexPath
            ) as? MessageCell {
                cell.configure(message: "The API is currently experiencing issues. Please try again later.")
                return cell
            }
        }
        if hasLoaded {
            if indexPath.row == 0 && indexPath.section == 0 {
                if let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: GameTableCell.self),
                    for: indexPath
                ) as? GameTableCell,
                   let model = gameModel {
                    cell.configure(model: model, shouldShowLines: true)
                    return cell
                }
            }

            if gameStatsModels.count == 0 {
                if let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: MessageCell.self),
                    for: indexPath
                ) as? MessageCell {
                    cell.configure(message: "There are no statistics available for this match.")
                    return cell
                }
            }
            
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: GameDetailCellView.self),
                for: indexPath
            ) as? GameDetailCellView {
                cell.configure(model: gameStatsModels[indexPath.row])
                return cell
            }
        }
        
        return tableView.dequeueReusableCell(
            withIdentifier: String(describing: LoadingTableCell.self),
            for: indexPath
        )
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 && indexPath.section == 0 ? 159.0 : UITableView.automaticDimension
    }
}
