//
//  GameTableCellTests.swift
//  Sam-Sample-AppTests
//
//  Created by Samantha Cattani on 2023-09-24.
//

@testable import Sam_Sample_App
import XCTest

final class GameTableCellTests: XCTestCase {
    var cell: GameTableCell?
    var model: GameCellViewModel?
    func didTapCell(i: Int, model: GameCellViewModel) {
        cellWasTapped = true
    }
    var cellWasTapped = false
    
    override func setUpWithError() throws {
        let bundle = Bundle(for: GameTableCell.self)
        let nibs = bundle.loadNibNamed(String(describing: GameTableCell.self), owner: nil)
        
        guard let cellNib = nibs?[0] as? GameTableCell else {
            XCTFail("Cell and/or model was not initialized")
            return
        }
        
        cell = cellNib
        model = GameCellViewModel(matchId: 2,
                                  gameTime: "45",
                                  league: "La Liga",
                                  country: "Spain",
                                  team1Score: "0",
                                  team1Logo: "https://media-4.api-sports.io/football/teams/9900.png",
                                  team2Score: "0",
                                  team2Logo: "https://media-4.api-sports.io/football/teams/9902.png",
                                  team1Name: "Barcelona",
                                  team2Name: "Real Madrid",
                                  didTapCell: didTapCell
        )
        
        
    }

    override func tearDownWithError() throws {
        cell = nil
        model = nil
    }

    func testConfigureWithNotShouldShowLines() throws {
        guard let cell = cell, let model = model else {
            XCTFail("Cell and/or model was not initialized")
            return
        }

        cell.configure(model: model, shouldShowLines: false)

        XCTAssertTrue(cell.blueLine.isHidden)
        XCTAssertTrue(cell.greenLine.isHidden)
        XCTAssertIdentical(cell.cellModel, model)
        XCTAssertEqual(cell.team1Score.text, model.team1Score)
        XCTAssertEqual(cell.team1NameLabel.text, model.team1Name)
        XCTAssertEqual(cell.team2Score.text, model.team2Score)
        XCTAssertEqual(cell.team2NameLabel.text, model.team2Name)
        XCTAssertEqual(cell.timeLabel.text, "\(model.gameTime)'")
        XCTAssertEqual(cell.leagueLabel.text, model.league)
        XCTAssertEqual(cell.countryLabel.text, model.country)

        XCTAssertTrue(cell.gestureRecognizers?.count == 1)

    }
    
    func testConfigureWithShouldShowLines() throws {
        guard let cell = cell, let model = model else {
            XCTFail("Cell and/or model was not initialized")
            return
        }
        
        cell.configure(model: model, shouldShowLines: true)

        XCTAssertFalse(cell.blueLine.isHidden)
        XCTAssertFalse(cell.greenLine.isHidden)
        XCTAssertIdentical(cell.cellModel, model)
        XCTAssertEqual(cell.team1Score.text, model.team1Score)
        XCTAssertEqual(cell.team1NameLabel.text, model.team1Name)
        XCTAssertEqual(cell.team2Score.text, model.team2Score)
        XCTAssertEqual(cell.team2NameLabel.text, model.team2Name)
        XCTAssertEqual(cell.timeLabel.text, "\(model.gameTime)'")
        XCTAssertEqual(cell.leagueLabel.text, model.league)
        XCTAssertEqual(cell.countryLabel.text, model.country)

        XCTAssertTrue(cell.gestureRecognizers?.count == 1)
    }
    
    func testViewWasTapped() {
        guard let cell = cell, let model = model else {
            XCTFail("Cell and/or model was not initialized")
            return
        }
        
        cell.cellModel = model
        cell.viewWasTapped()
        XCTAssertTrue(cellWasTapped)
    }
    
    func testViewWasTappedModelNil() {
        guard let cell = cell else {
            XCTFail("Cell and/or model was not initialized")
            return
        }
        
        cell.viewWasTapped()
        XCTAssertFalse(cellWasTapped)
    }
}
