//
//  SummeryTableViewCell.swift
//  CricketInfo
//
//  Created by SarathKumar Sekar on 25/01/24.
//

import UIKit

class SummeryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var matchTitleLabel: UILabel!
    @IBOutlet weak var teamANameLabel: UILabel!
    @IBOutlet weak var teamBNameLabel: UILabel!
    @IBOutlet weak var teamAScoreLabel: UILabel!
    @IBOutlet weak var teamBScoreLabel: UILabel!
    @IBOutlet weak var tossLabel: UILabel!
    @IBOutlet weak var wonMatchLabel: UILabel!
    @IBOutlet weak var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.defaultLayer()
    }
    
    func configureCell(teamA: TeamDetail?, teamB: TeamDetail?, toss: String, winnerResult: String) {
        guard let teamA = teamA, let teamB = teamB else { return }
        matchTitleLabel.text = "MATCH T5"
        teamANameLabel.text = teamA.name ?? ""
        let teamAScoreData = "\(teamA.score ?? "") / \(teamA.wickets ?? "")  (\(teamA.overs ?? ""))"
        let teamBScoreData = "\(teamB.score ?? "") / \(teamB.wickets ?? "")  (\(teamB.overs ?? ""))"
        teamAScoreLabel.text = teamAScoreData
        teamBScoreLabel.text = teamBScoreData
        tossLabel.text = toss
        wonMatchLabel.text = winnerResult
    }

}
