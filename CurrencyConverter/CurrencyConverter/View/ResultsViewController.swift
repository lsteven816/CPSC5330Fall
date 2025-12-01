//
//  ResultsViewController.swift
//  CurrencyConverter
//
//  Created by LaToya Stevens on 12/1/25.
//


import UIKit

class ResultsViewController: UIViewController {

    
    var usdAmount: Int = 0
    var conversionResults: [(Currency, Double)] = []

    @IBOutlet weak var usdSummaryLabel: UILabel!

    @IBOutlet weak var row1Stack: UIStackView!
    @IBOutlet weak var row1NameLabel: UILabel!
    @IBOutlet weak var row1AmountLabel: UILabel!

    @IBOutlet weak var row2Stack: UIStackView!
    @IBOutlet weak var row2NameLabel: UILabel!
    @IBOutlet weak var row2AmountLabel: UILabel!

    @IBOutlet weak var row3Stack: UIStackView!
    @IBOutlet weak var row3NameLabel: UILabel!
    @IBOutlet weak var row3AmountLabel: UILabel!

    @IBOutlet weak var row4Stack: UIStackView!
    @IBOutlet weak var row4NameLabel: UILabel!
    @IBOutlet weak var row4AmountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        usdSummaryLabel.textColor = .systemRed
        usdSummaryLabel.textAlignment = .center

        row1AmountLabel.textColor = .systemRed
        row2AmountLabel.textColor = .systemRed
        row3AmountLabel.textColor = .systemRed
        row4AmountLabel.textColor = .systemRed

        configureView()
    }

    private func configureView() {
        usdSummaryLabel.text = "Amount in USD: \(usdAmount)"

        let rows = [
            (row1Stack, row1NameLabel, row1AmountLabel),
            (row2Stack, row2NameLabel, row2AmountLabel),
            (row3Stack, row3NameLabel, row3AmountLabel),
            (row4Stack, row4NameLabel, row4AmountLabel)
        ]

        for (index, row) in rows.enumerated() {
            if index < conversionResults.count {
                let (currency, amount) = conversionResults[index]
                row.0?.isHidden = false
                row.1?.text = "\(currency.name) (\(currency.code))"
                row.2?.text = String(format: "%.2f", amount)
            } else {
                row.0?.isHidden = true
            }
        }
    }

    @IBAction func doneTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
