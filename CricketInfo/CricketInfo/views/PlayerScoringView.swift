//
//  PlayerScoringView.swift
//  CricketInfo
//
//  Created by SarathKumar Sekar on 25/01/24.
//

import Foundation
import UIKit

final class PlayerScoringView: BaseNib {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerOutLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var forthLabel: UILabel!
    @IBOutlet weak var fifthLabel: UILabel!
    
    func configurePlayerView(player: Player) {
        playerNameLabel.text = player.name
        playerOutLabel.text = "\(player.dismissal?.type ?? "") \(player.dismissal?.fielder ?? "")   b \(player.dismissal?.bowler ?? "")"
        firstLabel.text = "\(player.runs ?? 0)"
        secondLabel.text = "\(player.balls ?? 0)"
        thirdLabel.text = "\(player.fours ?? 0)"
        forthLabel.text = "\(player.sixes ?? 0)"
        
        if let runs = player.runs, let balls = player.balls, balls > 0 {
            let strikeRate = Double(runs) / Double(balls) * 100.0
            fifthLabel.text = String(format: "%.2f", strikeRate)
        } else {
            fifthLabel.text = "N/A"
        }
    }
    
    func configureBowlerView(bowler: Bowler) {
        playerNameLabel.text = bowler.name
        playerOutLabel.isHidden = true
        firstLabel.text = "\(bowler.overs ?? 0)"
        secondLabel.text = "0"
        thirdLabel.text = "\(bowler.runsConceded ?? 0)"
        forthLabel.text = "\(bowler.wickets ?? 0)"
        
        if let oversBowled = bowler.overs, oversBowled > 0 {
            let economyRate = Double(bowler.runsConceded ?? 0) / Double(oversBowled)
            fifthLabel.text = String(format: "%.2f", economyRate)
        } else {
            fifthLabel.text = "N/A"
        }
    }
}
