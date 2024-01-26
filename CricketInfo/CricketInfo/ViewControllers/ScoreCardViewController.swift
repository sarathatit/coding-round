//
//  ScoreCardViewController.swift
//  CricketInfo
//
//  Created by SarathKumar Sekar on 24/01/24.
//

import UIKit

class ScoreCardViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ScoreCardViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScoreCardTableViewCell.nib(),
                           forCellReuseIdentifier:ScoreCardTableViewCell.reuseIdentifier())
    }
    
}

extension ScoreCardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Teams.allCases.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ScoreCardTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if indexPath.row == Teams.teamA.rawValue {
            cell.configureCell(matchDetails: viewModel?.matchDetails, teamDetail: viewModel?.teamADetail,team: .teamA)
        } else {
            cell.configureCell(matchDetails: viewModel?.matchDetails, teamDetail: viewModel?.teamBDetail,team: .teamB)
        }
        return cell
    }
    
    
}
