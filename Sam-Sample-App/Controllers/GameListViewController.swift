//
//  ViewController.swift
//  Sam-Sample-App
//
//  Created by Samantha Cattani on 2023-09-14.
//

import UIKit

class GameListViewController: UIViewController {
    
    var cellModels: [GameCellViewModel] = []
    var hasLoaded = false
    var api = API()
    var gameTable = UITableView()
    var hasError = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        setUpTableView()
        setTable()
    }
    
    func setUpTableView() {
        gameTable.dataSource = self
        gameTable.delegate = self
        gameTable.rowHeight = UITableView.automaticDimension
        gameTable.separatorStyle = .none
        gameTable.translatesAutoresizingMaskIntoConstraints = false
        
        gameTable.register(
            UINib(nibName: String(describing: GameTableCell.self), bundle: nil),
            forCellReuseIdentifier: String(describing: GameTableCell.self)
        )
        gameTable.register(LoadingTableCell.self,
                           forCellReuseIdentifier: String(describing: LoadingTableCell.self)
        )
        gameTable.register(MessageCell.self,
                           forCellReuseIdentifier: String(describing: MessageCell.self)
        )
        
        self.view.addSubview(gameTable)
        
        gameTable.leadingAnchor.constraint(
            equalTo: self.view.leadingAnchor
        ).isActive = true
        gameTable.trailingAnchor.constraint(
            equalTo: self.view.trailingAnchor
        ).isActive = true
        gameTable.topAnchor.constraint(
            equalTo: self.view.topAnchor
        ).isActive = true
        gameTable.bottomAnchor.constraint(
            equalTo: self.view.bottomAnchor
        ).isActive = true
    }
    
    func setTable() {
        api.getMatches(buttonAction: onMatchPress) { models, hasError in
            if hasError {
                self.hasError = true
            }
            
            self.cellModels = models
            self.hasLoaded = true
            
            DispatchQueue.main.async {
                if !self.hasError {
                    self.gameTable.separatorStyle = .singleLine
                }
                self.gameTable.reloadData()
            }
        }
    }
    
    func onMatchPress(matchId: Int, model: GameCellViewModel) {
        self.navigationController?.pushViewController(
            GameDetailPageViewController(gameModel: model, matchId: matchId),
            animated: true
        )
    }
    
}

extension GameListViewController: UITableViewDataSource, UITableViewDelegate {
    // if the games have not loaded we still want to show 1 cell (loading cell)
    // if there are no games we still want to show 1 cell (message)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hasLoaded ? (cellModels.count == 0 ? 1 : cellModels.count) : 1
    }
    
    // when we are waiting for the API to return the matches played, show loading cell
    // when there is an error, show the message cell with an error message
    // when we have loaded the data and when there are no games being played, show message cell with a description of this
    // when we have loaded the data and there are games, show all of the games using game cells
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
            if cellModels.count == 0 {
                if let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: MessageCell.self),
                    for: indexPath
                ) as? MessageCell {
                    cell.configure(message: "There are currently no games to display")
                    return cell
                }
            }
            
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: GameTableCell.self),
                for: indexPath
            ) as? GameTableCell {
                cell.configure(model: cellModels[indexPath.row])
                return cell
            }
        }
        
        return tableView.dequeueReusableCell(
            withIdentifier: String(describing: LoadingTableCell.self),
            for: indexPath
        )
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 159.0
    }
}
