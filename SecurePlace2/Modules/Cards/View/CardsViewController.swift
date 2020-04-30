//
//  SSCardsViewController.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class CardsViewController: BaseViewController {

    var presenter: CardsPresenterProtocol!
    private var topSeparator: UIView = UIView()
    private var segmentedControl: UISegmentedControl!
    private var currenciesTable: UITableView = UITableView()
    //private var dataSource: CardsDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        //self.presenter.viewLoaded(segment: segmentedControl.selectedSegmentIndex)
    }

    private func createUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Cards"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Add +", style: .plain, target: self, action: #selector(self.didClickAddCardButton))
    }
    
    @objc func didClickAddCardButton() {
        
    }
}
extension CardsViewController: CardsViewProtocol { }
