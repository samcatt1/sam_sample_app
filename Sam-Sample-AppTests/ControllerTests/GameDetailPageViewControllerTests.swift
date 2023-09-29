//
//  GameDetailPageViewControllerTests.swift
//  Sam-Sample-AppTests
//
//  Created by Samantha Cattani on 2023-09-24.
//

import XCTest
@testable import Sam_Sample_App

final class GameDetailPageViewControllerTests: XCTestCase {
    
    var gameDetailPageViewController: GameDetailPageViewController?
    var gameModel: GameCellViewModel?
    func testDidTapCell(testInt: Int, testModel: GameCellViewModel) { }
    
    override func setUpWithError() throws {
        gameModel = GameCellViewModel(
            matchId: 2,
            gameTime: "30",
            league: "Premier League",
            country: "England",
            team1Score: "2",
            team1Logo: "http://samplelogo.com",
            team2Score: "2",
            team2Logo: "http://samplelogo.com",
            team1Name: "Wolverhampton",
            team2Name: "Liverpool",
            didTapCell: testDidTapCell
        )
        
        guard let gameModel = gameModel else {
            XCTFail("GameCellViewModel cannot be initialized")
            return
        }
        
        gameDetailPageViewController = GameDetailPageViewController(
            gameModel: gameModel,
            matchId: gameModel.matchId
        )
        
        guard let gameDetailPageViewController = gameDetailPageViewController else {
            XCTFail("GameDetailPageViewController cannot be initialized")
            return
        }
        
        gameDetailPageViewController.api = MockAPI()
    }
    
    override func tearDownWithError() throws {
        gameDetailPageViewController = nil
        gameModel = nil
    }
    
    func testInit() throws {
        guard let gameDetailPageViewController = gameDetailPageViewController, let gameModel = gameModel else {
            XCTFail("GameDetailPageViewController cannot be initialized")
            return
        }
        
        XCTAssertNotNil(gameDetailPageViewController.tableView)
        XCTAssertTrue(gameDetailPageViewController.gameStatsModels.isEmpty)
        XCTAssertFalse(gameDetailPageViewController.hasLoaded)
        XCTAssertNotNil(gameDetailPageViewController.api)
        XCTAssertIdentical(gameDetailPageViewController.gameModel, gameModel)
        XCTAssertTrue(gameDetailPageViewController.matchId == gameModel.matchId)
        XCTAssertFalse(gameDetailPageViewController.hasError)
    }
    
    func testRequiredInit() throws {
        let coder = NSCoder()
        let gameDetailPageViewController = GameDetailPageViewController(coder: coder)
        
        XCTAssertNil(gameDetailPageViewController)
    }
    
    func testSetUpTableView() throws {
        guard let gameDetailPageViewController = gameDetailPageViewController else {
            XCTFail("GameDetailPageViewController cannot be initialized")
            return
        }
        
        gameDetailPageViewController.setUpTableView()
        XCTAssertTrue(gameDetailPageViewController.tableView.rowHeight == UITableView.automaticDimension)
        XCTAssertTrue(gameDetailPageViewController.tableView.separatorStyle == .none)
        XCTAssertTrue(gameDetailPageViewController.view.subviews.contains(gameDetailPageViewController.tableView))
        XCTAssertFalse(gameDetailPageViewController.tableView.translatesAutoresizingMaskIntoConstraints)
        
        let contentViewConstraints = gameDetailPageViewController.view.constraints
        
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UITableView == gameDetailPageViewController.tableView &&
            constraint.firstAnchor == gameDetailPageViewController.tableView.leadingAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UITableView == gameDetailPageViewController.tableView &&
            constraint.firstAnchor == gameDetailPageViewController.tableView.trailingAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UITableView == gameDetailPageViewController.tableView &&
            constraint.firstAnchor == gameDetailPageViewController.tableView.topAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UITableView == gameDetailPageViewController.tableView &&
            constraint.firstAnchor == gameDetailPageViewController.tableView.bottomAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.isActive == true
        }))
    }
    
    func testSetTable() throws {
        guard let gameDetailPageViewController = gameDetailPageViewController else {
            XCTFail("GameDetailPageViewController cannot be initialized")
            return
        }
        
        gameDetailPageViewController.setTable()
        
        for i in 0...2 {
            XCTAssertTrue(gameDetailPageViewController.gameStatsModels[i].statName == "Stat \(i)")
            XCTAssertTrue(gameDetailPageViewController.gameStatsModels[i].team1Stat ==
                          (i % 2 == 0 ? "Team1 Stat \(i)" : "Team1 Stat \(i)%"))
            XCTAssertTrue(gameDetailPageViewController.gameStatsModels[i].team2Stat ==
                          (i % 2 == 0 ? "Team2 Stat \(i)" : "Team2 Stat \(i)%"))
            XCTAssertTrue(gameDetailPageViewController.gameStatsModels[i].isPercentage == (i % 2 != 0))
        }
        
        XCTAssertTrue(gameDetailPageViewController.hasLoaded)
    }
    
    func testNumberOfRowsInSectionLoaded() throws {
        guard let gameDetailPageViewController = gameDetailPageViewController else {
            XCTFail("GameDetailPageViewController cannot be initialized")
            return
        }
        
        gameDetailPageViewController.setUpTableView()
        gameDetailPageViewController.setTable()
        
        let numRows = gameDetailPageViewController.tableView(gameDetailPageViewController.tableView, numberOfRowsInSection: 0)
        
        XCTAssertEqual(numRows, gameDetailPageViewController.gameStatsModels.count)
        
    }
    
    func testNumberOfRowsInSectionLoadedNoDetails() throws {
        guard let gameDetailPageViewController = gameDetailPageViewController else {
            XCTFail("GameDetailPageViewController cannot be initialized")
            return
        }
        
        gameDetailPageViewController.setUpTableView()
        gameDetailPageViewController.setTable()
        gameDetailPageViewController.gameStatsModels = []
        
        let numRows = gameDetailPageViewController.tableView(gameDetailPageViewController.tableView, numberOfRowsInSection: 0)
        
        XCTAssertEqual(numRows, 2)
    }
    
    func testNumberOfRowsInSectionNotLoaded() throws {
        guard let gameDetailPageViewController = gameDetailPageViewController else {
            XCTFail("GameDetailPageViewController cannot be initialized")
            return
        }
        
        let numRows = gameDetailPageViewController.tableView(gameDetailPageViewController.tableView, numberOfRowsInSection: 0)
        
        XCTAssertEqual(numRows, 1)
    }
    
    func testCellForRowAtGameCell() throws {
        guard let gameDetailPageViewController = gameDetailPageViewController else {
            XCTFail("GameDetailPageViewController cannot be initialized")
            return
        }
        
        let indexPath = IndexPath(row: 0, section: 0)
        gameDetailPageViewController.hasLoaded = true
        gameDetailPageViewController.setUpTableView()
        let cell = gameDetailPageViewController.tableView(gameDetailPageViewController.tableView, cellForRowAt: indexPath)
        
        XCTAssert(cell is GameTableCell)
    }
    
    func testCellForRowAtEmptyCell() throws {
        guard let gameDetailPageViewController = gameDetailPageViewController else {
            XCTFail("GameDetailPageViewController cannot be initialized")
            return
        }
        
        let indexPath = IndexPath(row: 0, section: 2)
        gameDetailPageViewController.hasLoaded = true
        gameDetailPageViewController.setUpTableView()
        gameDetailPageViewController.gameStatsModels = []
        let cell = gameDetailPageViewController.tableView(gameDetailPageViewController.tableView, cellForRowAt: indexPath)
        
        XCTAssert(cell is MessageCell)
    }
    
    func testCellForRowAtDetailCell() throws {
        guard let gameDetailPageViewController = gameDetailPageViewController else {
            XCTFail("GameDetailPageViewController cannot be initialized")
            return
        }
        
        let indexPath = IndexPath(row: 0, section: 2)
        gameDetailPageViewController.hasLoaded = true
        gameDetailPageViewController.setUpTableView()
        let cell = gameDetailPageViewController.tableView(gameDetailPageViewController.tableView, cellForRowAt: indexPath)
        
        XCTAssert(cell is GameDetailCellView)
    }
    
    func testCellForRowAtLoadingCell() throws {
        guard let gameDetailPageViewController = gameDetailPageViewController else {
            XCTFail("GameDetailPageViewController cannot be initialized")
            return
        }
        
        let indexPath = IndexPath(row: 0, section: 0)
        gameDetailPageViewController.setUpTableView()
        gameDetailPageViewController.hasLoaded = false
        let cell = gameDetailPageViewController.tableView(gameDetailPageViewController.tableView, cellForRowAt: indexPath)
        
        XCTAssert(cell is LoadingTableCell)
    }
    
    func testCellForRowAtMessageCell() throws {
        guard let gameDetailPageViewController = gameDetailPageViewController else {
            XCTFail("GameDetailPageViewController cannot be initialized")
            return
        }
        
        let indexPath = IndexPath(row: 0, section: 0)
        gameDetailPageViewController.setUpTableView()
        gameDetailPageViewController.hasLoaded = true
        gameDetailPageViewController.hasError = true
        let cell = gameDetailPageViewController.tableView(gameDetailPageViewController.tableView, cellForRowAt: indexPath)
        
        XCTAssert(cell is MessageCell)
    }
    
    func getHeightDetailCellTest() throws {
        guard let gameDetailPageViewController = gameDetailPageViewController else {
            XCTFail("GameDetailPageViewController cannot be initialized")
            return
        }
        
        let indexPath = IndexPath(row: 0, section: 0)
        let height = gameDetailPageViewController.tableView(gameDetailPageViewController.tableView, heightForRowAt: indexPath)
        
        XCTAssertEqual(height, 159.0)
    }
    
    func getHeightDetailGameTest() throws {
        guard let gameDetailPageViewController = gameDetailPageViewController else {
            XCTFail("GameDetailPageViewController cannot be initialized")
            return
        }
        
        let indexPath = IndexPath(row: 0, section: 2)
        let height = gameDetailPageViewController.tableView(gameDetailPageViewController.tableView, heightForRowAt: indexPath)
        
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
}
