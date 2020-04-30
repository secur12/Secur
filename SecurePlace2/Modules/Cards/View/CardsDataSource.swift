////
////  CardsDataSource.swift
////  QponyTestowe
////
////  Created by Oleksandr Bambulyak on 14/03/2020.
////  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//protocol CurrenciesDataSourceDelegate: class {
//    func reloadData()
//}
//
//class CurrenciesDataSource {
//
//    private var dataSourceType: TableType? = TableType(rawValue: "credit")
//    private var creditCards = [CurrencyAB_Model]()
//    private var C_currencies = [CurrencyC_Model]()
//
//    weak var delegate: CurrenciesDataSourceDelegate?
//
//    func changeDataSourceType(_ type: TableType) {
//        self.dataSourceType = type
//    }
//
//    func getModelBy(index: Int) -> CurrencyBaseModel? {
//        if(dataSourceType == .a || dataSourceType == .b) {
//            return AB_currencies[index]
//        } else if (dataSourceType == .c) {
//            return C_currencies[index]
//        }
//        return nil
//    }
//
//    func getNumberOfSections() -> Int {
//        return 1
//    }
//
//    func getNumberOfItems(in section: Int) -> Int {
//        switch (dataSourceType) {
//          case .a:
//            return self.AB_currencies.count
//          case .b:
//            return self.AB_currencies.count
//          case .c:
//            return self.C_currencies.count
//         default:
//            return 0
//        }
//    }
//
//    func insertABItems(_ items: [CurrencyAB_Model]) {
//        self.updateWith_ABItems(items)
//    }
//
//    func insertCItems(_ items: [CurrencyC_Model]) {
//        self.updateWith_CItems(items)
//    }
//
//    func getCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        switch (dataSourceType) {
//            case .a:
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyABTableCell", for: indexPath) as? CurrencyAB_TableCell else { return UITableViewCell() }
//                cell.display(self.AB_currencies[indexPath.row])
//                return cell
//            case .b:
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyABTableCell", for: indexPath) as? CurrencyAB_TableCell else { return UITableViewCell() }
//                cell.display(self.AB_currencies[indexPath.row])
//                return cell
//            case .c:
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCTableCell", for: indexPath) as? CurrencyC_TableCell else { return UITableViewCell() }
//                cell.display(self.C_currencies[indexPath.row])
//                return cell
//            default:
//                return UITableViewCell()
//        }
//    }
//
//    private func updateWith_ABItems(_ items: [CurrencyAB_Model]) {
//        self.AB_currencies = items
//        DispatchQueue.main.async {
//           self.delegate?.reloadData()
//       }
//    }
//
//    private func updateWith_CItems(_ items: [CurrencyC_Model]) {
//        self.C_currencies = items
//        DispatchQueue.main.async {
//           self.delegate?.reloadData()
//       }
//    }
//}
