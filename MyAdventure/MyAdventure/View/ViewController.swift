//
//  ViewController.swift
//  MyAdventure
//
//  Created by LaToya Stevens on 11/23/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    @IBOutlet weak var choiceButton1: UIButton!
    @IBOutlet weak var choiceButton2: UIButton!
    @IBOutlet weak var choiceButton3: UIButton!

    private let model = AdventureModel()
    private var currentNodeID: String = "start"

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0x8A/255.0,
                                       green: 0xC0/255.0,
                                       blue: 0xB7/255.0,
                                       alpha: 1.0)

        storyLabel.numberOfLines = 0
        storyLabel.textAlignment = .center
        storyLabel.font = .systemFont(ofSize: 20)

        statusLabel.numberOfLines = 0
        statusLabel.textAlignment = .center
        statusLabel.font = .systemFont(ofSize: 18, weight: .semibold)

        let buttons = [choiceButton1, choiceButton2, choiceButton3]
        buttons.forEach { button in
            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = UIColor(red: 0x46/255.0,
                                                 green: 0xA7/255.0,
                                                 blue: 0xC8/255.0,
                                                 alpha: 1.0)
            config.baseForegroundColor = .white
            config.cornerStyle = .medium
            config.titleTextAttributesTransformer =
                UIConfigurationTextAttributesTransformer { incoming in
                    var outgoing = incoming
                    outgoing.font = .systemFont(ofSize: 20, weight: .semibold)
                    return outgoing
                }
            button?.configuration = config
        }

        showNode(id: model.startNodeID)
    }


    private func showNode(id: String) {
        guard let node = model.node(for: id) else { return }
        currentNodeID = id

        storyLabel.text = node.text

        // Ending?
        if let ending = node.endingMessage, let success = node.isSuccess {
            statusLabel.text = ending
            statusLabel.textColor = success ? .systemGreen : .systemRed

            // Put "Restart" on button 1, hide others
            configureButtons(titles: ["Restart Adventure"], hidden: [false, true, true])
            return
        }

        statusLabel.text = ""
        statusLabel.textColor = .label

        let titles = node.choices.map { $0.title }
        configureButtons(titles: titles, hidden: [false, false, titles.count < 3])
    }

    private func configureButtons(titles: [String], hidden: [Bool]) {
        let buttons = [choiceButton1, choiceButton2, choiceButton3]

        for i in 0..<buttons.count {
            buttons[i]?.isHidden = hidden[i]
            if i < titles.count {
                buttons[i]?.setTitle(titles[i], for: .normal)
            }
        }
    }

    @IBAction func choiceTapped(_ sender: UIButton) {
        print("Tapped:", sender.currentTitle ?? "no title")

        guard let node = model.node(for: currentNodeID) else { return }

        if sender == choiceButton1, node.choices.isEmpty {
            showNode(id: model.startNodeID)
            return
        }

        let buttons = [choiceButton1, choiceButton2, choiceButton3]
        guard let index = buttons.firstIndex(of: sender),
              index < node.choices.count else { return }

        let nextID = node.choices[index].destinationID
        showNode(id: nextID)
    }

}


