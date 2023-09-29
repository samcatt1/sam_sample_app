//
//  GameListViewControllerTests.swift
//  Sam-Sample-AppTests
//
//  Created by Samantha Cattani on 2023-09-22.
//

import XCTest
@testable import Sam_Sample_App

final class GameListViewControllerTests: XCTestCase {
    
    var gameListViewController: GameListViewController?
    func testDidTapCell(testInt: Int, testModel: GameCellViewModel) { }
    
    override func setUpWithError() throws {
        gameListViewController = GameListViewController()
        
        guard let gameListViewController = gameListViewController else {
            XCTFail("GameListPageViewController cannot be initialized")
            return
        }
        
        gameListViewController.api = MockAPI()
    }
    
    override func tearDownWithError() throws {
        gameListViewController = nil
    }
    
    func testInit() throws {
        guard let gameListViewController = gameListViewController else {
            XCTFail("GameListViewController cannot be initialized")
            return
        }
        
        XCTAssertNotNil(gameListViewController.gameTable)
        XCTAssertTrue(gameListViewController.cellModels.isEmpty)
        XCTAssertFalse(gameListViewController.hasLoaded)
        XCTAssertNotNil(gameListViewController.api)
        XCTAssertFalse(gameListViewController.hasError)
    }
    

    func testSetUpTableView() throws {
        guard let gameListViewController = gameListViewController else {
            XCTFail("GameListPageViewController cannot be initialized")
            return
        }

        gameListViewController.setUpTableView()
        XCTAssertTrue(gameListViewController.gameTable.rowHeight == UITableView.automaticDimension)
        XCTAssertTrue(gameListViewController.gameTable.separatorStyle == .none)
        XCTAssertTrue(gameListViewController.view.subviews.contains(gameListViewController.gameTable))
        XCTAssertFalse(gameListViewController.gameTable.translatesAutoresizingMaskIntoConstraints)

        let contentViewConstraints = gameListViewController.view.constraints

        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UITableView == gameListViewController.gameTable &&
            constraint.firstAnchor == gameListViewController.gameTable.leadingAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UITableView == gameListViewController.gameTable &&
            constraint.firstAnchor == gameListViewController.gameTable.trailingAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UITableView == gameListViewController.gameTable &&
            constraint.firstAnchor == gameListViewController.gameTable.topAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UITableView == gameListViewController.gameTable &&
            constraint.firstAnchor == gameListViewController.gameTable.bottomAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.isActive == true
        }))
    }

    func testSetTable() throws {
        guard let gameListViewController = gameListViewController else {
            XCTFail("GameListPageViewController cannot be initialized")
            return
        }

        gameListViewController.setTable()

        for i in 0...2 {
            XCTAssertTrue(gameListViewController.cellModels[i].matchId == i)
            XCTAssertTrue(gameListViewController.cellModels[i].gameTime == String(i))
            XCTAssertTrue(gameListViewController.cellModels[i].league == "League \(i)")
            XCTAssertTrue(gameListViewController.cellModels[i].country == "Country \(i)")
            XCTAssertTrue(gameListViewController.cellModels[i].team1Score == String(i))
            XCTAssertTrue(gameListViewController.cellModels[i].team1Logo == "Logo Team1 \(i)")
            XCTAssertTrue(gameListViewController.cellModels[i].team2Score == String(i))
            XCTAssertTrue(gameListViewController.cellModels[i].team2Logo == "Logo Team2 \(i)")
            XCTAssertTrue(gameListViewController.cellModels[i].team1Name == "Name Team1 \(i)")
            XCTAssertTrue(gameListViewController.cellModels[i].team2Name == "Name Team2 \(i)")
        }

        XCTAssertTrue(gameListViewController.hasLoaded)
    }
    
    func testOnMatchPress() throws {
        guard let gameListViewController = gameListViewController else {
            XCTFail("GameListPageViewController cannot be initialized")
            return
        }

        let navigationController = UINavigationController()
        navigationController.pushViewController(gameListViewController, animated: true)
        gameListViewController.setUpTableView()
        gameListViewController.setTable()
        
        gameListViewController.onMatchPress(matchId: gameListViewController.cellModels[0].matchId, model: gameListViewController.cellModels[0])
    }
    
    func testNumberOfRowsInSectionLoaded() throws {
        guard let gameListViewController = gameListViewController else {
            XCTFail("GameListPageViewController cannot be initialized")
            return
        }

        gameListViewController.setUpTableView()
        gameListViewController.setTable()
        let numRows = gameListViewController.tableView(gameListViewController.gameTable, numberOfRowsInSection: 0)

        XCTAssertEqual(numRows, gameListViewController.cellModels.count)

    }

    func testNumberOfRowsInSectionNotLoaded() throws {
        guard let gameListViewController = gameListViewController else {
            XCTFail("GameListPageViewController cannot be initialized")
            return
        }
        
        gameListViewController.hasLoaded = false
        let numRows = gameListViewController.tableView(gameListViewController.gameTable, numberOfRowsInSection: 0)

        XCTAssertEqual(numRows, 1)
    }

    func testCellForRowAtGameCell() throws {
        guard let gameListViewController = gameListViewController else {
            XCTFail("GameListPageViewController cannot be initialized")
            return
        }

        let indexPath = IndexPath(row: 0, section: 0)
        gameListViewController.hasLoaded = true
        gameListViewController.setUpTableView()
        let cell = gameListViewController.tableView(gameListViewController.gameTable, cellForRowAt: indexPath)

        XCTAssert(cell is GameTableCell)
    }

    func testCellForRowAtLoadingCell() throws {
        guard let gameListViewController = gameListViewController else {
            XCTFail("GameListPageViewController cannot be initialized")
            return
        }

        let indexPath = IndexPath(row: 0, section: 0)
        gameListViewController.setUpTableView()
        gameListViewController.hasLoaded = false
        let cell = gameListViewController.tableView(gameListViewController.gameTable, cellForRowAt: indexPath)

        XCTAssert(cell is LoadingTableCell)
    }

    func testCellForRowAtMessageCell() throws {
        guard let gameListViewController = gameListViewController else {
            XCTFail("GameListPageViewController cannot be initialized")
            return
        }

        let indexPath = IndexPath(row: 0, section: 0)
        gameListViewController.setUpTableView()
        gameListViewController.hasLoaded = true
        gameListViewController.hasError = true
        let cell = gameListViewController.tableView(gameListViewController.gameTable, cellForRowAt: indexPath)

        XCTAssert(cell is MessageCell)
    }

    func getHeightDetailCellTest() throws {
        guard let gameListViewController = gameListViewController else {
            XCTFail("GameListPageViewController cannot be initialized")
            return
        }

        let indexPath = IndexPath(row: 0, section: 0)
        let height = gameListViewController.tableView(gameListViewController.gameTable, heightForRowAt: indexPath)

        XCTAssertEqual(height, 159.0)
    }
}
