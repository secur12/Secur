//
//  SSAddCardViewController.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit
import Foundation

class AddCardViewController: BaseViewController {

    var presenter: AddCardPresenterProtocol!
    private var topSeparator: UIView = UIView()

    private var cardNumberLabel: UILabel = UILabel()
    private var cardNumberTextField: SSTextField = SSTextField(placeholder: "Card number...", type: .decimalPad)

    private var expiryDateLabel: UILabel = UILabel()
    private var expiryDateTextField: SSTextField = SSTextField(placeholder: "MM/YY", type: .decimalPad)

    private var cvvCodeLabel: UILabel = UILabel()
    private var cvvCodeTextField: SSTextField = SSTextField(placeholder: "123", type: .decimalPad)

    private var paymentSystemLogo: UIImageView = UIImageView()
    private var paymentSystemString: String = "card-1"

    private var cardHolderLabel: UILabel = UILabel()
    private var cardHolderField: SSTextField = SSTextField(placeholder: "Card holder name...", type: .default)
    //private var countryPicker = UIPickerView()

    private var cardTypeLabel: UILabel = UILabel()
    private var cardTypePickerField: SSTextField = SSTextField(placeholder: "DEBIT", type: .default)
    private var cardTypePicker = UIPickerView()

    private var bankNameLabel: UILabel = UILabel()
    private var bankNameTextField: SSTextField = SSTextField(placeholder: "Bank name...", type: .default)

    private var actionButton: UIButton = UIButton()
    var countryData = [String]()
    var cardTypeData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.hideKeyboardWhenTappedAround()
    }

    private func createUI() {

        view.backgroundColor = UIColor.white
        title = "Add card"

        view.addSubview(topSeparator)
        view.addSubview(cardNumberLabel)
        view.addSubview(cardNumberTextField)
        view.addSubview(expiryDateLabel)
        view.addSubview(expiryDateTextField)
        view.addSubview(cvvCodeLabel)
        view.addSubview(cvvCodeTextField)
        view.addSubview(paymentSystemLogo)
        view.addSubview(cardHolderLabel)
        view.addSubview(cardHolderField)
        view.addSubview(cardTypeLabel)
        view.addSubview(cardTypePickerField)
        view.addSubview(bankNameLabel)
        view.addSubview(bankNameTextField)
        view.addSubview(actionButton)

        topSeparator.backgroundColor = Colors.lightGrey
        topSeparator.snp.makeConstraints { (make) in
             make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
             make.left.equalToSuperview().offset(20.withRatio())
             make.height.equalTo(0.3.withRatio())
             make.right.equalToSuperview()
        }

        cardNumberLabel.text = "Card number"
        cardNumberLabel.font = UIFont.systemFont(ofSize: 16.withRatio(), weight: .semibold)
        cardNumberLabel.snp.makeConstraints { (make) in
            make.left.equalTo(topSeparator.snp.left)
            make.top.equalTo(topSeparator.snp.bottom).offset(8.withRatio())
        }

        cardNumberTextField.addTarget(self, action: #selector(cardTextFieldDidChanged(_:)), for: UIControl.Event.editingChanged)
        cardNumberTextField.delegate = self
        cardNumberTextField.snp.makeConstraints { (make) in
            make.left.equalTo(cardNumberLabel.snp.left)
            make.top.equalTo(cardNumberLabel.snp.bottom).offset(8.withRatio())
            make.right.equalToSuperview().offset(-20.withRatio())
            make.height.equalTo(43.withRatio())
        }

        expiryDateLabel.text = "Expiry date"
        expiryDateLabel.font = UIFont.systemFont(ofSize: 16.withRatio(), weight: .semibold)
        expiryDateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(topSeparator.snp.left)
            make.top.equalTo(cardNumberTextField.snp.bottom).offset(10.withRatio())
        }

        expiryDateTextField.delegate = self
        expiryDateTextField.snp.makeConstraints { (make) in
            make.left.equalTo(expiryDateLabel.snp.left)
            make.top.equalTo(expiryDateLabel.snp.bottom).offset(8.withRatio())
            make.width.equalTo(94.withRatio())
            make.height.equalTo(43.withRatio())
        }

        cvvCodeLabel.text = "CVV"
        cvvCodeLabel.font = UIFont.systemFont(ofSize: 16.withRatio(), weight: .semibold)
        cvvCodeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(expiryDateTextField.snp.right).offset(25.withRatio())
            make.top.equalTo(cardNumberTextField.snp.bottom).offset(10.withRatio())
        }

        cvvCodeTextField.delegate = self
        cvvCodeTextField.snp.makeConstraints { (make) in
            make.left.equalTo(expiryDateLabel.snp.right).offset(25.withRatio())
            make.top.equalTo(cvvCodeLabel.snp.bottom).offset(8.withRatio())
            make.width.equalTo(61.withRatio())
            make.height.equalTo(43.withRatio())
        }

        paymentSystemLogo.contentMode = .scaleAspectFit
        paymentSystemLogo.snp.makeConstraints { (make) in
            make.left.equalTo(cvvCodeTextField.snp.right).offset(60.withRatio())
            make.height.equalTo(50.withRatio())
            make.width.equalTo(65.withRatio())
            make.bottom.equalTo(cvvCodeTextField.snp.bottom)
        }

        cardHolderLabel.text = "Card holder name"
        cardHolderLabel.font = UIFont.systemFont(ofSize: 16.withRatio(), weight: .semibold)
        cardHolderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(expiryDateTextField.snp.left)
            make.top.equalTo(expiryDateTextField.snp.bottom).offset(10.withRatio())
        }

//        countryPicker.dataSource = self
//        countryPicker.delegate = self
        //cardHolderField.inputView = countryPicker
        cardHolderField.delegate = self
        cardHolderField.snp.makeConstraints { (make) in
            make.left.equalTo(cardHolderLabel.snp.left)
            make.top.equalTo(cardHolderLabel.snp.bottom).offset(8.withRatio())
            make.right.equalToSuperview().offset(-20.withRatio())
            make.height.equalTo(43.withRatio())
        }

        cardTypeLabel.text = "Type"
        cardTypeLabel.font = UIFont.systemFont(ofSize: 16.withRatio(), weight: .semibold)
        cardTypeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(cardHolderLabel.snp.left)
            make.top.equalTo(cardHolderField.snp.bottom).offset(10.withRatio())
        }

        cardTypePicker.dataSource = self
        cardTypePicker.delegate = self
        cardTypePickerField.inputView = cardTypePicker
        cardTypePickerField.snp.makeConstraints { (make) in
            make.left.equalTo(cardTypeLabel.snp.left)
            make.top.equalTo(cardTypeLabel.snp.bottom).offset(8.withRatio())
            make.height.equalTo(43.withRatio())
            make.width.equalTo(96.withRatio())
        }

        bankNameLabel.text = "Bank"
        bankNameLabel.font = UIFont.systemFont(ofSize: 16.withRatio(), weight: .semibold)
        bankNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(cardTypePickerField.snp.right).offset(24.withRatio())
            make.top.equalTo(cardHolderField.snp.bottom).offset(10.withRatio())
        }

        bankNameTextField.delegate = self
        bankNameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(bankNameLabel.snp.left)
            make.top.equalTo(bankNameLabel.snp.bottom).offset(8.withRatio())
            make.right.equalToSuperview().offset(-20.withRatio())
            make.height.equalTo(43.withRatio())
        }

        self.actionButton.backgroundColor = Colors.brandBlue
        self.actionButton.setTitle("Add", for: .normal)
        self.actionButton.layer.cornerRadius = 8.withRatio()
        self.actionButton.addTarget(self, action: #selector(didClickActionButton), for: .touchUpInside)
        self.actionButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-28.withRatio())
            make.left.equalToSuperview().offset(16.withRatio())
            make.right.equalToSuperview().offset(-16.withRatio())
            make.height.equalTo(46.withRatio())
        }

        for code in NSLocale.isoCountryCodes  {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countryData.append(name)
        }

        cardTypeData.append("Credit")
        cardTypeData.append("Debit")
    }

    @objc func cardTextFieldDidChanged(_ textField: UITextField) {
        let (type, formatted, valid) = checkCardNumber(input: textField.text ?? "")
        textField.text = formatted
        if type == .MasterCard {
            self.paymentSystemLogo.image = UIImage(named: "mastercard")
            self.paymentSystemString = "mastercard"
        } else if type == .Visa {
            self.paymentSystemLogo.image = UIImage(named: "visa")
            self.paymentSystemString = "visa"
        } else if type == .UnionPay {
            self.paymentSystemLogo.image = UIImage(named: "unionpay")
            self.paymentSystemString = "unionpay"
        } else {
            self.paymentSystemLogo.image = UIImage()
            self.paymentSystemString = ""
        }
    }

    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension AddCardViewController: AddCardViewProtocol {

    @objc func didClickActionButton() {
        if ((self.cardNumberTextField.text?.count ?? 0) < 19) {
            self.showOkAlertController(title: "Error", message: "Card number must have at least 19 characters", callback: nil)
        } else if ((self.cvvCodeTextField.text?.count ?? 0) < 3) {
            self.showOkAlertController(title: "Error", message: "CVV have at least 3 characters", callback: nil)
        } else if (self.cardTypePickerField.text?.isEmpty == true) {
            self.showOkAlertController(title: "Error", message: "You must choose card type", callback: nil)
        } else if ((self.expiryDateTextField.text?.count ?? 0) < 5) {
            self.showOkAlertController(title: "Error", message: "You must type expiry date", callback: nil)
        } else if ((self.cardHolderField.text?.count ?? 0) < 1) {
            self.showOkAlertController(title: "Error", message: "Card holder name must be at least 1 symbols", callback: nil)
        } else if (self.paymentSystemString.isEmpty) {
            self.showOkAlertController(title: "Error", message: "Please, enter valid card number", callback: nil)
        } else {
            self.presenter.didClickActionButton(cardNumber: cardNumberTextField.text ?? "", expiryDate: expiryDateTextField.text ?? "", cvvCode: cvvCodeTextField.text ?? "", cardHolder: cardHolderField.text!, type: cardTypePickerField.text ?? "", bankName: bankNameTextField.text ?? "", paymentSystemString: paymentSystemString)
        }
    }

    func configureForEdit(cardNumber: String, expiryDate: String, cvvCode: String, cardHolder: String, type: String, bankName: String, paymentSystemLogoName: String) {
        self.cardNumberTextField.text = cardNumber
        self.expiryDateTextField.text = expiryDate
        self.cvvCodeTextField.text = cvvCode
        self.cardHolderField.text = cardHolder
        self.cardTypePickerField.text = type
        self.bankNameTextField.text = bankName
        self.paymentSystemLogo.image = UIImage(named: paymentSystemLogoName)
        self.actionButton.setTitle("Edit", for: .normal)
    }
}

extension AddCardViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if (pickerView == countryPicker) {
//            return countryData.count
//        } else
        if (pickerView == cardTypePicker) {
            return cardTypeData.count
        } else {
            return 0
        }
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//      if (pickerView == countryPicker) {
//          return countryData[row]
//      } else
        if (pickerView == cardTypePicker) {
          return cardTypeData[row]
      } else {
          return nil
      }
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if (pickerView == countryPicker) {
//            countryPickerField.text = countryData[row]
//        } else
        if (pickerView == cardTypePicker) {
            cardTypePickerField.text = cardTypeData[row]
        }
    }
}
extension AddCardViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count

        if textField == expiryDateTextField {
             guard let text = textField.text, let textRange = Range(range, in: text) else {
                   return false
               }
               var updatedText = text.replacingCharacters(in: textRange, with: string)
               updatedText.removeAll(where: {$0 == "/"})
               let finalLength = updatedText.count + updatedText.count/2 - 1
               if finalLength > 5 {
                   return false
               }
               for i in stride(from: 2, to: finalLength, by: 3) {
                   let index = updatedText.index(updatedText.startIndex, offsetBy: i)
                   updatedText.insert("/", at: index)
               }
               textField.text = updatedText
               return false
        }

        switch textField {
            case cardNumberTextField:
                return count <= 19
            case expiryDateTextField:
                return count <= 5
            case cvvCodeTextField:
                return count <= 3
            case bankNameTextField:
                return count <= 20
            case cardHolderField:
                return count <= 36
            default:
                return true
        }
    }
}

extension AddCardViewController {
    func checkCardNumber(input: String) -> (type: CardType, formatted: String, valid: Bool) {
        // Get only numbers from the input string
        let numberOnly = input.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)

        var type: CardType = .Unknown
        var formatted = ""
        var valid = false

        // detect card type
        for card in CardType.allCards {
            if (matchesRegex(regex: card.regex, text: numberOnly)) {
                type = card
                break
            }
        }

        // check validity
        valid = luhnCheck(number: numberOnly)

        // format
        var formatted4 = ""
        for character in numberOnly.characters {
            if formatted4.characters.count == 4 {
                formatted += formatted4 + " "
                formatted4 = ""
            }
            formatted4.append(character)
        }

        formatted += formatted4 // the rest

        // return the tuple
        return (type, formatted, valid)
    }

    enum CardType: String {
        case Unknown, Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay

        static let allCards = [Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay]

        var regex : String {
            switch self {
            case .Amex:
                return "^3[47][0-9]{5,}$"
            case .Visa:
                return "^4[0-9]{6,}([0-9]{3})?$"
            case .MasterCard:
                return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
            case .Diners:
                return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
            case .Discover:
                return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
            case .JCB:
                return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
            case .UnionPay:
                return "^(62|88)[0-9]{5,}$"
            case .Hipercard:
                return "^(606282|3841)[0-9]{5,}$"
            case .Elo:
                return "^((((636368)|(438935)|(504175)|(451416)|(636297))[0-9]{0,10})|((5067)|(4576)|(4011))[0-9]{0,12})$"
            default:
                return ""
            }
        }
    }

    func matchesRegex(regex: String!, text: String!) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let nsString = text as NSString
            let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        } catch {
            return false
        }
    }

    func luhnCheck(number: String) -> Bool {
        return true
    }
}

extension AddCardViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

