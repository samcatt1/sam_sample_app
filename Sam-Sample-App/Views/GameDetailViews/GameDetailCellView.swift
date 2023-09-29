//
//  GameDetailCellView.swift
//  Sam-Sample-App
//
//  Created by Samantha Cattani on 2023-09-17.
//

import Foundation
import UIKit

class GameDetailCellView: UITableViewCell {
    
    struct Constants {
        static let padding: CGFloat = 15
    }
    
    // set up view elements
    lazy var statName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.accessibilityIdentifier = "Stat Name"
        return label
    }()
    
    lazy var bar: UIProgressView = {
        let bar = UIProgressView(progressViewStyle: .bar)
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.center = contentView.center
        bar.trackTintColor = .green
        bar.tintColor = .blue
        bar.accessibilityIdentifier = "Stat Visual Comparison"
        return bar
    }()
    
    lazy var team1Stat: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.accessibilityIdentifier = "Away Team Stat Value"
        return label
    }()
    
    lazy var team2Stat: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.accessibilityIdentifier = "Home Team Stat Value"
        return label
    }()

    // initialize cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        accessibilityIdentifier = "Game Stat Cell"
        
        contentView.addSubview(statName)
        contentView.addSubview(team1Stat)
        contentView.addSubview(bar)
        contentView.addSubview(team2Stat)
        
        layout()
    }

    required init?(coder _: NSCoder) {
        return nil
    }
    
    // layout subviews with constraints
    func layout() {
        statName.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: Constants.padding
        ).isActive = true
        statName.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -Constants.padding
        ).isActive = true
        statName.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: Constants.padding * 2
        ).isActive = true
        
        team1Stat.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: Constants.padding
        ).isActive = true
        team1Stat.topAnchor.constraint(
            equalTo: statName.bottomAnchor,
            constant: Constants.padding
        ).isActive = true
        team1Stat.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -Constants.padding
        ).isActive = true
        
        team2Stat.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -Constants.padding
        ).isActive = true
        team2Stat.topAnchor.constraint(
            equalTo: statName.bottomAnchor,
            constant: Constants.padding
        ).isActive = true
        team2Stat.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -Constants.padding
        ).isActive = true
        
        bar.leadingAnchor.constraint(
            equalTo: team1Stat.trailingAnchor,
            constant: Constants.padding
        ).isActive = true
        bar.topAnchor.constraint(
            equalTo: statName.bottomAnchor,
            constant: Constants.padding
        ).isActive = true
        bar.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -Constants.padding
        ).isActive = true
        bar.trailingAnchor.constraint(
            equalTo: team2Stat.leadingAnchor,
            constant: -Constants.padding
        ).isActive = true
    }

    // method to update the view to the values in the model
    func configure(model: GameDetailStatModel) {
        statName.text = model.statName.uppercased().replacing("_", with: " ")
        team1Stat.text = model.team1Stat
        team2Stat.text = model.team2Stat
        
        // kick off any % signs
        if model.isPercentage && model.team1Stat.contains("%") {
            model.team1Stat.removeLast()
            model.team2Stat.removeLast()
        }
        
        if model.team1Stat == "0" && model.team2Stat == "0" {
            bar.setProgress(0, animated: false)
            bar.tintColor = .lightGray
            bar.trackTintColor = .lightGray
        } else {
            let team1Int = Double(model.team1Stat) ?? 1
            let team2Int = Double(model.team2Stat) ?? 1
            let total = team1Int + team2Int
            let percentTeam1 = team1Int / total
            bar.setProgress(Float(percentTeam1), animated: false)
            bar.trackTintColor = .green
            bar.tintColor = .blue
        }
    }
}
