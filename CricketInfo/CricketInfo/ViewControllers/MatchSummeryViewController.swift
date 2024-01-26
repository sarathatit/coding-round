//
//  MatchSummeryViewController.swift
//  CricketInfo
//
//  Created by SarathKumar Sekar on 24/01/24.
//

import UIKit

class MatchSummeryViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel = MatchDetailsViewModel()
    let matchDetailsCount = 1

    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        fetchMatchDetails()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SummeryTableViewCell.nib(),
                           forCellReuseIdentifier:SummeryTableViewCell.reuseIdentifier())
    }
    
    private func fetchMatchDetails() {
        viewModel.fetchData(completion: { [weak self] in
            if let matchDetails = self?.viewModel.matchDetails {
                print(matchDetails)
            }
        })
    }

}

//MARK: - UITableView Delegate and DataSource

extension MatchSummeryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchDetailsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let teamA = viewModel.getTeamInfo(forTeam: Teams.teamA)
        let teamB = viewModel.getTeamInfo(forTeam: Teams.teamB)
        
        let cell: SummeryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let toss = viewModel.getTossData()
        let winnerResult = viewModel.getWinnerResult()
        cell.configureCell(teamA: teamA, teamB: teamB, toss: toss, winnerResult: winnerResult)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ScoreCardViewController") as! ScoreCardViewController
        nextViewController.viewModel = ScoreCardViewModel()
        nextViewController.viewModel?.teamADetail = viewModel.getTeamInfo(forTeam: Teams.teamA)
        nextViewController.viewModel?.teamBDetail = viewModel.getTeamInfo(forTeam: Teams.teamB)
        nextViewController.viewModel?.matchDetails = viewModel.matchDetails
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

}
