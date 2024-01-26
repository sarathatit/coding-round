//
//  MatchDetails.swift
//  CricketInfo
//
//  Created by SarathKumar Sekar on 24/01/24.
//

import Foundation

// MARK: - Welcome
struct Match: Codable {
    let matchDetails: MatchDetails?
}

// MARK: - MatchDetails
struct MatchDetails: Codable {
    let format: String?
    let toss: String?
    let tossDecision: String?
    let teams: [Team]?
    let fallOfWickets: [FallOfWicket]?
}

// MARK: - FallOfWicket
struct FallOfWicket: Codable {
    let team: String?
    let wickets: [Wicket]?
}

// MARK: - Wicket
struct Wicket: Codable {
    let player: String?
    let score: Int?
    let overs: Double?
    let dismissal: Dismissal?
}

// MARK: - Dismissal
struct Dismissal: Codable {
    let type: String?
    let fielder: String?
    let bowler: String?
}

// MARK: - Team
struct Team: Codable {
    let name: String?
    let players: [Player]?
    let bowlers: [Bowler]?
}

// MARK: - Bowler
struct Bowler: Codable {
    let name: String?
    let overs: Int?
    let runsConceded: Int?
    let wickets: Int?
}

// MARK: - Player
struct Player: Codable {
    let name: String?
    let runs: Int?
    let balls: Int?
    let fours: Int?
    let sixes: Int?
    let dismissal: Dismissal?
}
