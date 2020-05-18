//
//  SSCredentialsViewController.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class CredentialsViewController: BaseViewController {

    var presenter: CredentialsPresenterProtocol!
    private var topSeparator: UIView = UIView()
    private var credentialsTable: UITableView = UITableView()
    private var emptyImage: UIImageView = UIImageView()
    private var emptyLabel: UILabel = UILabel()

    private var dataSource: CredentialsDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.presenter.reloadData()
    }

    private func createUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Accounts"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Add +", style: .plain, target: self, action: #selector(self.didClickAddCredentialsButton))

        self.dataSource = CredentialsDataSource()
        self.dataSource.delegate = self

        self.credentialsTable.isUserInteractionEnabled = true
        self.credentialsTable.delegate = self
        self.credentialsTable.dataSource = self
        self.credentialsTable.separatorStyle = .none
        self.credentialsTable.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        self.credentialsTable.register(CredentialCell.self, forCellReuseIdentifier: "CredentialCell")

        self.view.addSubview(self.topSeparator)
        self.view.addSubview(self.credentialsTable)
        self.view.addSubview(self.emptyImage)
        self.view.addSubview(self.emptyLabel)

        topSeparator.backgroundColor = Colors.lightGrey
        topSeparator.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(20.withRatio())
            make.height.equalTo(0.3.withRatio())
            make.right.equalToSuperview()
        }

        self.credentialsTable.snp.makeConstraints { (make) in
            make.top.equalTo(self.topSeparator.snp.bottom).offset(5.withRatio())
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
        self.emptyLabel.text = "Sorry, you haven't saved accounts yet. \n\nAdd first account by clicking Add button."
        self.emptyLabel.isHidden = true
        self.emptyLabel.numberOfLines = 0
        self.emptyLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
        }

        self.credentialsTable.reloadData()
    }

    @objc func didClickAddCredentialsButton() {
        self.presenter.didClickAddCredentialsButton()
    }
}

extension CredentialsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.getNumberOfSections()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.withRatio()
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = dataSource.getModelBy(index: indexPath.row) else { return }
        self.presenter.showCredentialDetailsWith(model: model)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if let model = self.dataSource.getModelBy(index: indexPath.row) {
                self.presenter.deleteCredential(model: model)
            }
        }
    }
}

extension CredentialsViewController: CredentialsViewProtocol {
    func insertCredentials(models: [CredentialModel]) {
        self.dataSource.insertCredentials(models)
    }
}

extension CredentialsViewController: CredentialsDataSourceDelegate {

    func reloadData() {
         DispatchQueue.main.async {
             self.credentialsTable.reloadData()
         }
     }
}
