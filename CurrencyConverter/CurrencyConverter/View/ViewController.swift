//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by LaToya Stevens on 11/30/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usdTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    @IBOutlet weak var currency1Switch: UISwitch!
    @IBOutlet weak var currency2Switch: UISwitch!
    @IBOutlet weak var currency3Switch: UISwitch!
    @IBOutlet weak var currency4Switch: UISwitch!

    @IBOutlet weak var convertButton: UIButton!

    private let model = CurrencyConverterModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        usdTextField.keyboardType = .numberPad

        errorLabel.textColor = .systemRed
        errorLabel.text = ""

        // Optional button styling (iOS 15+ style)
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        config.title = "CONVERT"
        convertButton.configuration = config
    }

    // MARK: - Validation

    private func validatedUSD() -> Int? {
        errorLabel.text = ""

        guard let text = usdTextField.text, !text.isEmpty else {
            errorLabel.text = "Please enter an amount in USD."
            return nil
        }

        if let value = Int(text), value >= 0 {
            return value
        } else {
            errorLabel.text = "Invalid input. Please enter a non-negative whole number."
            return nil
        }
    }

    private func selectedCurrencyIndices() -> [Int] {
        var indices: [Int] = []
        if currency1Switch.isOn { indices.append(0) }
        if currency2Switch.isOn { indices.append(1) }
        if currency3Switch.isOn { indices.append(2) }
        if currency4Switch.isOn { indices.append(3) }
        return indices
    }

    // MARK: - Actions

    @IBAction func convertTapped(_ sender: UIButton) {
        // Just trigger segue. Actual validation and data setup will happen in prepare(for:).
        performSegue(withIdentifier: "showResults", sender: self)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults",
           let destination = segue.destination as? ResultsViewController {

            guard let usdAmount = validatedUSD() else {
                // Stop segue if input invalid
                segue.destination.dismiss(animated: false)
                return
            }

            let indices = selectedCurrencyIndices()
            if indices.isEmpty {
                errorLabel.text = "Please turn on at least one currency."
                segue.destination.dismiss(animated: false)
                return
            }

            let results = model.convert(usd: usdAmount, for: indices)
            destination.usdAmount = usdAmount
            destination.conversionResults = results
        }
    }
}


