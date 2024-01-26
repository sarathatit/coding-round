//
//  ScoreCardTableViewCell.swift
//  CricketInfo
//
//  Created by SarathKumar Sekar on 25/01/24.
//

import UIKit

class ScoreCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var batterStackView: UIStackView!
    @IBOutlet weak var bowlerStackView: UIStackView!
    @IBOutlet weak var batterStackHeight: NSLayoutConstraint!
    @IBOutlet weak var bowlerStackHeight: NSLayoutConstraint!
    
    let playerViewHeight = 63

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(matchDetails: MatchDetails?, teamDetail: TeamDetail?, team: Teams) {
        guard let teamDetail = teamDetail else { return }
        teamNameLabel.text = teamDetail.name ?? ""
        let teamScoreData = "\(teamDetail.score ?? "") / \(teamDetail.wickets ?? "")  (\(teamDetail.overs ?? ""))"
        scoreLabel.text = teamScoreData
        
        let players = getPlayersDetails(matchDetails: matchDetails, team: team)
        let bowler = getBowlerDetails(matchDetails: matchDetails, team: team)
        
        configurePlayerStackView(players: players)
        configureBowlerStackView(bowlers: bowler)
    }
    
    func configurePlayerStackView(players: [Player]) {
        for subview in batterStackView.arrangedSubviews {
            batterStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        for player in players {
            let view = PlayerScoringView()
            view.configurePlayerView(player: player)
            batterStackView.addArrangedSubview(view)
        }
        batterStackView.layoutIfNeeded()
                
        batterStackHeight.constant = CGFloat(playerViewHeight * players.count)

    }
    
    func configureBowlerStackView(bowlers: [Bowler]) {
        for subview in bowlerStackView.arrangedSubviews {
            bowlerStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        for bowler in bowlers {
            let view = PlayerScoringView()
            view.configureBowlerView(bowler: bowler)
            bowlerStackView.addArrangedSubview(view)
        }
        bowlerStackView.layoutIfNeeded()
                
        bowlerStackHeight.constant = CGFloat(playerViewHeight * bowlers.count)
    }
    
    func getPlayersDetails(matchDetails: MatchDetails?, team: Teams) -> [Player] {
        guard let matchDetails = matchDetails else { return [] }
        
        return matchDetails.teams?[team.rawValue].players ?? []
    }
    
    func getBowlerDetails(matchDetails: MatchDetails?, team: Teams) -> [Bowler] {
        guard let matchDetails = matchDetails else { return [] }
        
        return matchDetails.teams?[team.rawValue].bowlers ?? []
    }
    
}
