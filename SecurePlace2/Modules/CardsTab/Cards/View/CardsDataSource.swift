//
//  CardsDataSource.swift
//  QponyTestowe
//
//  Created by Oleksandr Bambulyak on 14/03/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import UIKit

protocol CardsDataSourceDelegate: class {
    func reloadData()
}

class CardsDataSource {

    private var dataSourceType: TableType? = TableType(rawValue: "credit")
    private var creditCards = [CardModel]()
    private var debitCards = [CardModel]()

    weak var delegate: CardsDataSourceDelegate?

    func changeDataSourceType(_ type: TableType) {
        self.dataSourceType = type
    }

    func getModelBy(index: Int) -> CardModel? {
        if(dataSourceType == .credit) {
            return creditCards[index]
        } else if (dataSourceType == .debit) {
            return debitCards[index]
        }
        return nil
    }

    func getNumberOfSections() -> Int {
        return 1
    }

    func getNumberOfItems(in section: Int) -> Int {
        switch (dataSourceType) {
          case .credit:
            return self.creditCards.count
          case .debit:
            return self.debitCards.count
         default:
            return 0
        }
    }

    func insertCreditCards(_ items: [CardModel]) {
        self.updateCreditCards(items)
    }

    func insertDebitCards(_ items: [CardModel]) {
         self.updateDebitCards(items)
     }

    func getCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch (dataSourceType) {
            case .debit:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as? CardCell else { return UITableViewCell() }
                cell.display(self.debitCards[indexPath.row])
                return cell
            case .credit:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as? CardCell else { return UITableViewCell() }
                cell.display(self.creditCards[indexPath.row])
                return cell
            default:
                return UITableViewCell()
        }
    }

    private func updateDebitCards(_ items: [CardModel]) {
        self.debitCards = items
        self.delegate?.reloadData()
    }

    private func updateCreditCards(_ items: [CardModel]) {
        self.creditCards = items
        self.delegate?.reloadData()
    }
}
