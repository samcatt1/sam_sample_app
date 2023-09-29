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
    
    private lazy var statName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var bar: UIProgressView = {
        let bar = UIProgressView(progressViewStyle: .bar)
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.center = contentView.center
        bar.setProgress(0.5, animated: false)
        bar.trackTintColor = .green
        bar.tintColor = .blue
        return bar
    }()
    
    private lazy var team1Stat: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var team2Stat: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(statName)
        contentView.addSubview(team1Stat)
        contentView.addSubview(bar)
        contentView.addSubview(team2Stat)
        layout()
    }

    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
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

    func configure(model: GameDetailStatModel) {
        statName.text = model.statName.uppercased()
        team1Stat.text = model.team1Stat
        team2Stat.text = model.team2Stat
        
        // kick off any % signs
        if model.isPercentage && model.team1Stat.contains("%") {
            model.team1Stat.removeLast()
            model.team2Stat.removeLast()
        }
        
        let team1Int = Int(model.team1Stat) ?? 1
        let team2Int = Int(model.team2Stat) ?? 1
        let total = team1Int + team2Int
        let percentTeam1 = CGFloat(team1Int) / CGFloat(total)
        bar.setProgress(Float(percentTeam1), animated: false)
    }
}
