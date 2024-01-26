//
//  MatchSummeryTests.swift
//  CricketInfoTests
//
//  Created by SarathKumar Sekar on 25/01/24.
//

import Foundation
import XCTest
@testable import CricketInfo

final class matchSummeryViewModelTest: XCTestCase {
    
    var viewModel: MatchDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MatchDetailsViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchDataSuccess() {
            // Given
            let expectation = XCTestExpectation(description: "Fetch data successful")

            // When
            viewModel.fetchData {
                // Then
                XCTAssertNotNil(self.viewModel.matchDetails, "details should not be nil")
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 3.0)
        }
        
    func createSampleMatchDetails() -> MatchDetails {
            let team1 = Team(name: "Team A", players: [Player(name: "batsMan1", runs: 2, balls: 2, fours: 0, sixes: 0, dismissal: Dismissal(type: "catch", fielder: "fileder A", bowler: "bowlerA"))], bowlers: [Bowler(name: "bowlerA", overs: 1, runsConceded: 2, wickets: 1)])
            let team2 = Team(name: "Team B", players: [Player(name: "batsMan2", runs: 2, balls: 2, fours: 0, sixes: 0, dismissal: Dismissal(type: "catch", fielder: "fileder A", bowler: "bowlerB"))], bowlers: [Bowler(name: "bowlerB", overs: 1, runsConceded: 2, wickets: 1)])
        return MatchDetails(format: "T5", toss: "Team A", tossDecision: "Bat", teams: [team1, team2], fallOfWickets: [FallOfWicket(team: "TeamA", wickets: [Wicket(player: "", score: 1, overs: 1.1, dismissal: Dismissal(type: "catch", fielder: "fileder A", bowler: "bowlerB"))])])
        }

    func testGetTeamDetailsForTeamA() {
        let teamA = Teams.teamA
        viewModel.matchDetails = createSampleMatchDetails()
        let teamDetails = viewModel.getTeamDetails(forTeam: teamA)
        XCTAssertNotNil(teamDetails, "Team details should not be nil for Team A")
        XCTAssertEqual(teamDetails?.name, "Team A", "Team name should match for Team A")
        XCTAssertEqual(teamDetails?.players?.count, 1, "Team A should have one player")
        XCTAssertEqual(teamDetails?.bowlers?.count, 1, "Team A should have one bowler")
    }

    
    func testGetTeamScoreForTeamA() {
        let teamA = Teams.teamA
        viewModel.matchDetails = createSampleMatchDetails()
        let teamScore = viewModel.getTeamScore(forTeam: teamA)
        XCTAssertEqual(teamScore, 2, "Team A total score should be 2")
    }

    func testGetTeamScoreForTeamB() {
        let teamB = Teams.teamB
        viewModel.matchDetails = createSampleMatchDetails()
        let teamScore = viewModel.getTeamScore(forTeam: teamB)
        XCTAssertEqual(teamScore, 2, "Team B total score should be 2")
    }

    func testGetTeamFacedOversForTeamA() {
        let teamA = Teams.teamA
        viewModel.matchDetails = createSampleMatchDetails()
        let teamFacedOvers = viewModel.getTeamFacedOvers(forTeam: teamA)
        XCTAssertEqual(teamFacedOvers, 1.0, "Team A total overs faced should be 1.0")
    }

    func testGetTeamFacedOversForTeamB() {
        let teamB = Teams.teamB
        viewModel.matchDetails = createSampleMatchDetails()
        let teamFacedOvers = viewModel.getTeamFacedOvers(forTeam: teamB)
        XCTAssertEqual(teamFacedOvers, 1.0, "Team B total overs faced should be 1.0")
    }

    func testGetTeamWicketsForTeamA() {
        let teamA = Teams.teamA
        viewModel.matchDetails = createSampleMatchDetails()
        let teamWickets = viewModel.getTeamWickets(forTeam: teamA)
        XCTAssertEqual(teamWickets, 1, "Team A total wickets should be 1")
    }

    func testGetTeamWicketsForTeamB() {
        let teamB = Teams.teamB
        viewModel.matchDetails = createSampleMatchDetails()
        let teamWickets = viewModel.getTeamWickets(forTeam: teamB)
        XCTAssertEqual(teamWickets, 1, "Team B total wickets should be 1")
    }

}
