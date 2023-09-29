//
//  GameTableCell.swift
//  Sam-Sample-App
//
//  Created by Samantha Cattani on 2023-09-17.
//

import Foundation
import UIKit

class GameTableCell: UITableViewCell {
    var cellModel: GameCellViewModel?
    
    @IBOutlet weak var team1ImageView: UIImageView!
    @IBOutlet weak var team2ImageView: UIImageView!
    @IBOutlet weak var team1Score: UILabel!
    @IBOutlet weak var team2Score: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var team1NameLabel: UILabel!
    @IBOutlet weak var team2NameLabel: UILabel!
    @IBOutlet weak var blueLine: UIView!
    @IBOutlet weak var greenLine: UIView!
    
    // method to update the view to the values in the model
    func configure(model: GameCellViewModel, shouldShowLines: Bool = false) {
        
        if !shouldShowLines {
            blueLine.isHidden = true
            greenLine.isHidden = true
        }
        
        cellModel = model
        
        team1Score.text = model.team1Score
        team2Score.text = model.team2Score
        team1NameLabel.text = model.team1Name
        team2NameLabel.text = model.team2Name
        
        timeLabel.text = "\(model.gameTime)\'"
        leagueLabel.text = model.league
        countryLabel.text = model.country
        
        // need to load data on background thread and then add image to imageView on main thread
        if let url = URL(string: model.team1Logo) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async { [self] in
                        self.team1ImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        // need to load data on background thread and then add image to imageView on main thread
        if let url = URL(string: model.team2Logo) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async { [self] in
                        self.team2ImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(viewWasTapped))
        )
    }
    
    @objc func viewWasTapped() {
        guard let model = cellModel else {
            return
        }
        
        model.didTapCell(model.matchId, model)
    }
}
