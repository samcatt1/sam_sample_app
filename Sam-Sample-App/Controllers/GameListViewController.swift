//
//  ViewController.swift
//  Sam-Sample-App
//
//  Created by Samantha Cattani on 2023-09-14.
//

import UIKit

class GameListViewController: UIViewController {

    @IBOutlet weak var gameTable: UITableView!
    private var cellModels: [GameCellViewModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        gameTable.register(
            UINib(nibName: "GameTableCell", bundle: nil),
            forCellReuseIdentifier: "GameTableCell"
        )
        gameTable.dataSource = self
        gameTable.delegate = self
        gameTable.rowHeight = UITableView.automaticDimension
        gameTable.separatorStyle = .none
        
        setModels()
    }

    private func setModels() {
        // do api call
        
        cellModels = API.getMatches()
    }

}

extension GameListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: "GameTableCell",
            for: indexPath
        ) as? GameTableCell, let model = cellModels?[indexPath.row] {
            cell.configure(model: model)
            return cell
        }
        
        // if something goes wrong return default cell
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 159.0
    }
}
