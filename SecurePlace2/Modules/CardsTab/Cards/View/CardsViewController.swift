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
    private var cardsTable: UITableView = UITableView()
    private var emptyImage: UIImageView = UIImageView()
    private var emptyLabel: UILabel = UILabel()

    private var dataSource: CardsDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.presenter.viewLoaded(segment: segmentedControl.selectedSegmentIndex)
        for family: String in UIFont.familyNames
              {
                  print(family)
                  for names: String in UIFont.fontNames(forFamilyName: family)
                  {
                      print("== \(names)")
                  }
              }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.presenter.viewLoaded(segment: segmentedControl.selectedSegmentIndex)
    }

    private func createUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Cards"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Add +", style: .plain, target: self, action: #selector(self.didClickAddCardButton))

        let segments = ["Credit", "Debit"]
        self.segmentedControl = UISegmentedControl(items: segments)
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.addTarget(self, action: #selector(changeTable), for: .valueChanged)

        self.dataSource = CardsDataSource()
        self.dataSource.delegate = self

        self.cardsTable.allowsSelection = true
        self.cardsTable.isUserInteractionEnabled = true
        self.cardsTable.delegate = self
        self.cardsTable.dataSource = self
        self.cardsTable.separatorStyle = .none
        self.cardsTable.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        self.cardsTable.register(CardCell.self, forCellReuseIdentifier: "CardCell")
        self.cardsTable.register(CardCell.self, forCellReuseIdentifier: "CardCell")


        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.cardsTable)
        self.view.addSubview(self.emptyLabel)
        self.view.addSubview(self.emptyImage)

        self.segmentedControl.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5.withRatio())
            make.left.equalToSuperview().offset(20.withRatio())
            make.right.equalToSuperview().offset(-20.withRatio())
            make.centerX.equalToSuperview()
        }

        self.cardsTable.snp.makeConstraints { (make) in
            make.top.equalTo(self.segmentedControl.snp.bottom).offset(5.withRatio())
            make.left.right.bottom.equalToSuperview()
        }

        self.emptyImage.isHidden = true
        self.emptyImage.image = UIImage(named: "empty")
        self.emptyImage.contentMode = .scaleAspectFit
        self.emptyImage.snp.makeConstraints { (make) in
            make.left.equalTo(self.emptyLabel.snp.left)
            make.bottom.equalTo(self.emptyLabel.snp.top).offset(-12.withRatio())
            make.height.width.equalTo(50.withRatio())
        }

        self.emptyLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        self.emptyLabel.text = "Sorry, you haven't cards yet. \nAdd cards by clicking Add button."
        self.emptyLabel.isHidden = true
        self.emptyLabel.numberOfLines = 0
        self.emptyLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
        }

    }
    
    @objc func didClickAddCardButton() {
        self.presenter.didClickAddCardButton()
    }

    @objc private func changeTable(sender: UISegmentedControl) {
        self.presenter.reloadData(segment: sender.selectedSegmentIndex)
    }
}

extension CardsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.getNumberOfSections()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215.withRatio()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.dataSource.getNumberOfItems(in: section) > 0) {
            self.emptyLabel.isHidden = true
            self.emptyImage.isHidden = true
            return self.dataSource.getNumberOfItems(in: section)
        } else {
            self.emptyImage.isHidden = false
            self.emptyLabel.isHidden = false
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.dataSource.getCell(for: tableView, indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if let model = self.dataSource.getModelBy(index: indexPath.row) {
                self.presenter.deleteCard(model: model, segment: segmentedControl.selectedSegmentIndex)
            }
        }
    }
}

extension CardsViewController: CardsViewProtocol {
    func insertCreditCurrencies(models: [CardModel]) {
        self.dataSource.changeDataSourceType(.credit)
        self.dataSource.insertCreditCards(models)
    }

    func insertDebitCurrencies(models: [CardModel]) {
        self.dataSource.changeDataSourceType(.debit)
        self.dataSource.insertDebitCards(models)
    }
}

extension CardsViewController: CardsDataSourceDelegate {

    func reloadData() {
        DispatchQueue.main.async {
            self.cardsTable.reloadData()
        }
    }
}

