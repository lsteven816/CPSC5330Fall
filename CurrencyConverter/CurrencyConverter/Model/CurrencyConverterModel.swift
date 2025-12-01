//
//  CurrencyConverterModel.swift
//  CurrencyConverter
//
//  Created by LaToya Stevens on 12/1/25.
//
import Foundation

struct Currency {
    let code: String
    let name: String
    let rateToUSD: Double 
}

final class CurrencyConverterModel {

    let currencies: [Currency] = [
        Currency(code: "EUR", name: "Euro",         rateToUSD: 0.92),
        Currency(code: "JPY", name: "Japanese Yen", rateToUSD: 147.3),
        Currency(code: "GBP", name: "British Pound",rateToUSD: 0.79),
        Currency(code: "CAD", name: "Canadian Dollar", rateToUSD: 1.37)
    ]

    func convert(usd: Int, for indices: [Int]) -> [(Currency, Double)] {
        indices.compactMap { index in
            guard currencies.indices.contains(index) else { return nil }
            let currency = currencies[index]
            let amount   = Double(usd) * currency.rateToUSD
            return (currency, amount)
        }
    }
}

