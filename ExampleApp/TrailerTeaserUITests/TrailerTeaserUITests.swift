//
//  TrailerTeaserUITests.swift
//  TrailerTeaserUITests
//
//  Created by Wesley on 5/17/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

import WireMockTest
import XCTest

class TrailerTeaserUITests: XCTestCase {
    
    var wireMock: WireMockTest!
    var wireMockApi: WireMockApi!
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        // Configure WireMockTest and WireMockApi with appropriate WireMock server information
        let port = "8080"
        let configuration = WireMockConfiguration(port: port)
        wireMock = WireMockTest(configuration: configuration)
        wireMockApi = WireMockApi(configuration: configuration)
        
        // Initialize WireMockTest session
        try wireMock.initializeSession()
        
        app = XCUIApplication()
        app.launchArguments.append("useMockService")
        app.launchEnvironment["mockServicePort"] = port
        app.launch()
    }

    override func tearDownWithError() throws {
        wireMockApi.resetMappings()
    }
    
    func testTvShows() {
        testTvShows_noVideos()
        testTvShows_noTvShows()
        testTvShows_oneTvShow()
        testTvShows_twoTvShows()
    }

    // Use WireMockApi to update mapping response with Codable object
    private func testTvShows_noVideos() {
        guard var getVideosMapping = wireMockApi.getMapping(.getVideos, responseType: ShowListResponse.self) else {
            return XCTFail("GET /videos mapping does not exist.")
        }
        
        // Update mapping
        let mockGetVideosResponse = ShowListResponse(result: [])
        getVideosMapping.response.jsonBody = mockGetVideosResponse
        wireMockApi.updateMapping(getVideosMapping)
        
        // Select TV Shows button
        XCTAssertTrue(app.descendants(matching: .any).matching(identifier: AccessibilityKey.LandingViewController.root).element(boundBy: 0).isVisible)
        app.buttons[AccessibilityKey.LandingViewController.tvShowButton].tap()
        
        // Validate table view
        XCTAssertTrue(app.descendants(matching: .any).matching(identifier: AccessibilityKey.ShowListViewController.root).element(boundBy: 0).isVisible)
        XCTAssertEqual(0, app.tables[AccessibilityKey.ShowListViewController.tableView].cells.count)
        
        // Navigate back
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    // Use WireMockApi to update mapping response with JSON file
    private func testTvShows_noTvShows() {
        guard var getVideosMapping = wireMockApi.getMapping(.getVideos, responseType: ShowListResponse.self) else {
            return XCTFail("GET /videos mapping does not exist.")
        }
        
        // Update mapping
        getVideosMapping.response.bodyFileName = "getVideos-noTv.json"
        wireMockApi.updateMapping(getVideosMapping)
        
        // Select TV Shows button
        XCTAssertTrue(app.descendants(matching: .any).matching(identifier: AccessibilityKey.LandingViewController.root).element(boundBy: 0).isVisible)
        app.buttons[AccessibilityKey.LandingViewController.tvShowButton].tap()
        
        // Validate table view
        XCTAssertTrue(app.descendants(matching: .any).matching(identifier: AccessibilityKey.ShowListViewController.root).element(boundBy: 0).isVisible)
        XCTAssertEqual(0, app.tables[AccessibilityKey.ShowListViewController.tableView].cells.count)
        
        // Navigate back
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    // Use WireMockApi to update mapping response with Codable object
    private func testTvShows_oneTvShow() {
        guard var getVideosMapping = wireMockApi.getMapping(.getVideos, responseType: ShowListResponse.self) else {
            return XCTFail("GET /videos mapping does not exist.")
        }
        
        // Update mapping
        let mockShow = Show(id: 1, type: .tv, title: "Mock TV Show", date: Date(), description: nil, category: nil, thumbnail: nil, siteUrl: nil)
        let mockGetVideosResponse = ShowListResponse(result: [mockShow])
        getVideosMapping.response = WireMockResponse(response: mockGetVideosResponse)
        wireMockApi.updateMapping(getVideosMapping)
        
        // Select TV Shows button
        XCTAssertTrue(app.descendants(matching: .any).matching(identifier: AccessibilityKey.LandingViewController.root).element(boundBy: 0).isVisible)
        app.buttons[AccessibilityKey.LandingViewController.tvShowButton].tap()
        
        // Validate table view
        XCTAssertTrue(app.descendants(matching: .any).matching(identifier: AccessibilityKey.ShowListViewController.root).element(boundBy: 0).isVisible)
        let tableView = app.tables[AccessibilityKey.ShowListViewController.tableView]
        XCTAssertEqual(1, tableView.cells.count)
        
        // Validate shows
        let showCell0 = tableView.cells.element(boundBy: 0)
        XCTAssertEqual("Mock TV Show", showCell0.staticTexts[AccessibilityKey.ShowTableViewCell.nameLabel].label)
        
        // Navigate back
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    // Use WireMockTest to stub a new mapping.
    private func testTvShows_twoTvShows() {
        // Remove any existing GET /videos mapping to ensure there are no collisions when adding a new mapping
        wireMockApi.deleteMapping(.getVideos)

        // Create mapping
        let mockShow1 = Show(id: 1, type: .tv, title: "Mock TV Show 1", date: Date(), description: nil, category: nil, thumbnail: nil, siteUrl: nil)
        let mockShow2 = Show(id: 2, type: .tv, title: "Mock TV Show 2", date: Date(), description: nil, category: nil, thumbnail: nil, siteUrl: nil)
        let mockGetVideosResponse = ShowListResponse(result: [mockShow1, mockShow2])
        
        wireMock.stub(RapidApi.Path.videos.rawValue)
            .forHttpMethod(.get)
            .andReturn(mockGetVideosResponse)

        // Select TV Shows button
        XCTAssertTrue(app.descendants(matching: .any).matching(identifier: AccessibilityKey.LandingViewController.root).element(boundBy: 0).isVisible)
        app.buttons[AccessibilityKey.LandingViewController.tvShowButton].tap()

        // Validate table view
        XCTAssertTrue(app.descendants(matching: .any).matching(identifier: AccessibilityKey.ShowListViewController.root).element(boundBy: 0).isVisible)
        let tableView = app.tables[AccessibilityKey.ShowListViewController.tableView]
        XCTAssertEqual(2, tableView.cells.count)

        // Validate shows
        let showCell0 = tableView.cells.element(boundBy: 0)
        XCTAssertEqual("Mock TV Show 1", showCell0.staticTexts[AccessibilityKey.ShowTableViewCell.nameLabel].label)
        
        let showCell1 = tableView.cells.element(boundBy: 1)
        XCTAssertEqual("Mock TV Show 2", showCell1.staticTexts[AccessibilityKey.ShowTableViewCell.nameLabel].label)

        // Navigate back
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        // Reset stubs
        wireMock.resetStubs()
    }
}

extension XCUIElement {
    
    var isVisible: Bool {
        return exists && isHittable
    }
}
