//
//  MatchSummeryViewModel.swift
//  CricketInfo
//
//  Created by SarathKumar Sekar on 24/01/24.
//

import Foundation

enum Teams: Int, CaseIterable {
    case teamA
    case teamB
}

class MatchDetailsViewModel {
    
    // MARK: - Properties
    var matchDetails: MatchDetails?
    
    // MARK: - MetchDetails Feed
    func fetchData(completion: @escaping () -> Void) {
           DispatchQueue.global().async {
               if let path = Bundle.main.path(forResource: "status", ofType: "json") {
                   do {
                       let data = try Data(contentsOf: URL(fileURLWithPath: path))
                       print(String(data: data, encoding: .utf8) ?? "Unable to print JSON data")
                       
                       let decoder = JSONDecoder()
                       decoder.keyDecodingStrategy = .convertFromSnakeCase
                      let result = try decoder.decode(Match.self, from: data)
                       self.matchDetails = result.matchDetails
                       DispatchQueue.main.async {
                           completion()
                       }
                   } catch {
                       print("Error reading or decoding JSON file: \(error)")
                       if let dataString = String(data: (error as! DecodingError).failureReason!.data(using: .utf8)!, encoding: .utf8) {
                           print("Decoding error details: \(dataString)")
                       }
                   }
               } else {
                   print("JSON file not found in the bundle.")
               }
           }
       }
    
    // MARK: - Get Team Details
    func getTeamDetails(forTeam team: Teams) -> Team? {
        guard let teams = matchDetails?.teams, team.rawValue < teams.count else {
            return nil
        }
        return teams[team.rawValue]
    }
    
    // MARK: - Get total Score of each team
    func getTeamScore(forTeam team: Teams) -> Int {
        guard let teams = matchDetails?.teams, team.rawValue < teams.count else {
            return 0
        }
        let selectedTeam = teams[team.rawValue]
        let totalRuns = selectedTeam.players?.reduce(0) { $0 + ($1.runs ?? 0)} ?? 0
        return totalRuns
    }
    
    // MARK: - Get total overs played
    func getTeamFacedOvers(forTeam team: Teams) -> Double {
        guard let teams = matchDetails?.teams, team.rawValue < teams.count else {
            return 0
        }
        let selectedTeam = teams[team.rawValue]
        let totalRuns = selectedTeam.bowlers?.reduce(0) { $0 + ($1.overs ?? 0)} ?? 0
        return Double(totalRuns)
    }
    
    // MARK: - Get Wickets fell down each team
    func getTeamWickets(forTeam team: Teams) -> Int {
        guard let teams = matchDetails?.teams, team.rawValue < teams.count else {
            return 0
        }
        let selectedTeam = teams[team.rawValue]
        let wicketsCount = selectedTeam.players?.compactMap { $0.dismissal }.count ?? 0
        return wicketsCount
    }
    
    // MARK: - Get Team Object
    
    func getTeamInfo(forTeam team: Teams) -> TeamDetail? {
        if let myTeam = getTeamDetails(forTeam: team) {
            let name = myTeam.name ?? ""
            let score = getTeamScore(forTeam: team) 
            let wickets = getTeamWickets(forTeam: team) 
            let overs = getTeamFacedOvers(forTeam: team)
            
            return TeamDetail(name: name, score: String(score), wickets: String(wickets), overs: String(overs))
        }
        
        return TeamDetail(name: "", score: "", wickets: "", overs: "")
    }
    
    func getTossData() -> String {
        return "Toss won by \(matchDetails?.toss ?? "") and choose \(matchDetails?.tossDecision ?? "")"
    }
    
    func getWinnerResult() -> String {
        let teamAScore = getTeamScore(forTeam: Teams.teamA)
        let teamBScore = getTeamScore(forTeam: Teams.teamB)
        let scoreDifference = abs(teamAScore - teamBScore)
        let teamAName = getTeamDetails(forTeam: Teams.teamA)?.name ?? ""
        let teamBName = getTeamDetails(forTeam: Teams.teamB)?.name ?? ""
        
        let winnerTeam = checkWinnerTeam()
        
        if winnerTeam == .teamA {
            if matchDetails?.tossDecision ?? "" == "Bat first" {
                return "\(teamAName) won by \(scoreDifference) runs"
            } else {
                let getTeamWickets = getTeamWickets(forTeam: .teamA)
                let wonbyWickets = abs(getTeamWickets - (getTeamDetails(forTeam: .teamA)?.players?.count ?? 0))
                return "\(teamAName) won by \(wonbyWickets) wickets"
            }
        } else {
            if matchDetails?.tossDecision ?? "" == "Bat first" {
                return "\(teamBName) won by \(scoreDifference) runs"
            } else {
                let getTeamWickets = getTeamWickets(forTeam: .teamB)
                let wonbyWickets = abs(getTeamWickets - (getTeamDetails(forTeam: .teamB)?.players?.count ?? 0))
                return "\(teamBName) won by \(wonbyWickets) wickets"
            }
        }
        
    }
    
    func checkWinnerTeam() -> Teams {
        let teamAScore = getTeamScore(forTeam: Teams.teamA)
        let teamBScore = getTeamScore(forTeam: Teams.teamB)
        if teamAScore > teamBScore {
            return Teams.teamA
        } else {
            return Teams.teamB
        }
    }
    
}

struct TeamDetail {
    var name: String?
    var score: String?
    var wickets: String?
    var overs: String?
}
