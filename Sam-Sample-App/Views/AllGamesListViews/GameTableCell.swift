//
//  GameTableCell.swift
//  Sam-Sample-App
//
//  Created by Samantha Cattani on 2023-09-17.
//

import Foundation
import UIKit

class GameTableCell: UITableViewCell {
    private var cellModel: GameCellViewModel?
    
    @IBOutlet weak var team1ImageView: UIImageView!
    @IBOutlet weak var team2ImageView: UIImageView!
    @IBOutlet weak var team1Score: UILabel!
    @IBOutlet weak var team2Score: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var team1NameLabel: UILabel!
    @IBOutlet weak var team2NameLabel: UILabel!
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
        // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
        // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
        // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
        // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        contentView.addGestureRecognizer(
//            UITapGestureRecognizer(target: self, action: #selector(viewWasTapped))
//        )
        configure(model: nil)
    }
    
    func configure(model: GameCellViewModel?) {
        guard let model = model else {
            return
        }
        
        cellModel = model
        
        team1Score.text = model.team1Score
        team2Score.text = model.team2Score
        team1NameLabel.text = model.team1Name
        team2NameLabel.text = model.team2Name
        
        timeLabel.text = "\(model.gameTime)\'"
        leagueLabel.text = model.league
        countryLabel.text = model.country
        
        if let url = URL(string: model.team1Logo) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async { [self] in
                        self.team1ImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        if let url = URL(string: model.team2Logo) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async { [self] in
                        self.team2ImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        contentView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(viewWasTapped))
        )
    }
    
    @objc private func viewWasTapped() {
        guard let model = cellModel else {
            return
        }
        
        model.didTapCell(model.matchId, model)
    }
}
