//
//  AdventureModel.swift
//  MyAdventure
//
//  Created by LaToya Stevens on 11/23/25.
//

import Foundation

struct AdventureChoice {
    let title: String
    let destinationID: String
}

struct AdventureNode {
    let id: String
    let text: String
    let choices: [AdventureChoice]
    let endingMessage: String?
    let isSuccess: Bool?
}

final class AdventureModel {

    private(set) var nodes: [String: AdventureNode] = [:]
    private(set) var startNodeID: String = "start"

    init() {
        buildAdventure()
    }

    private func buildAdventure() {

        nodes["start"] = AdventureNode(
            id: "start",
            text: "You arrive at Cloudfall Gate holding a faded map. How will you begin?",
            choices: [
                AdventureChoice(title: "Enter the Jungle Trail", destinationID: "jungle"),
                AdventureChoice(title: "Climb the Mountain Pass", destinationID: "mountain"),
                AdventureChoice(title: "Follow the River Caves", destinationID: "river")
            ],
            endingMessage: nil,
            isSuccess: nil
        )

        
        nodes["jungle"] = AdventureNode(
            id: "jungle",
            text: "Deep in the jungle, you find a fork guarded by colorful parrots.",
            choices: [
                AdventureChoice(title: "Talk to the Parrots", destinationID: "jungle_success"),
                AdventureChoice(title: "Cut Through Vines", destinationID: "jungle_fail")
            ],
            endingMessage: nil,
            isSuccess: nil
        )

        nodes["mountain"] = AdventureNode(
            id: "mountain",
            text: "The mountain air grows thin. A storm approaches fast.",
            choices: [
                AdventureChoice(title: "Take the Rope Bridge", destinationID: "mountain_success"),
                AdventureChoice(title: "Shelter in the Old Cabin", destinationID: "mountain_fail")
            ],
            endingMessage: nil,
            isSuccess: nil
        )

        nodes["river"] = AdventureNode(
            id: "river",
            text: "The river caves echo loudly. Something glimmers inside.",
            choices: [
                AdventureChoice(title: "Light a Torch & Go In", destinationID: "river_success"),
                AdventureChoice(title: "Swim the Narrow Tunnel", destinationID: "river_fail")
            ],
            endingMessage: nil,
            isSuccess: nil
        )

       
        nodes["jungle_success"] = AdventureNode(
            id: "jungle_success",
            text: "The parrots guide you to a hidden temple full of golden relics.",
            choices: [],
            endingMessage: "You found the Lost City! 😄",
            isSuccess: true
        )

        nodes["jungle_fail"] = AdventureNode(
            id: "jungle_fail",
            text: "The vines trap you. You lose your gear and can’t continue.",
            choices: [],
            endingMessage: "Your adventure ends here. 😢",
            isSuccess: false
        )

        nodes["mountain_success"] = AdventureNode(
            id: "mountain_success",
            text: "The bridge sways, but you cross safely to the sky ruins.",
            choices: [],
            endingMessage: "You conquered Cloudfall! 😄",
            isSuccess: true
        )

        nodes["mountain_fail"] = AdventureNode(
            id: "mountain_fail",
            text: "The cabin collapses in the storm.",
            choices: [],
            endingMessage: "You didn’t make it. 😢",
            isSuccess: false
        )

        nodes["river_success"] = AdventureNode(
            id: "river_success",
            text: "Your torch reveals an ancient vault overflowing with treasures.",
            choices: [],
            endingMessage: "You win the adventure! 😄",
            isSuccess: true
        )

        nodes["river_fail"] = AdventureNode(
            id: "river_fail",
            text: "The tunnel floods before you reach the exit.",
            choices: [],
            endingMessage: "You’re forced to turn back. 😢",
            isSuccess: false
        )
    }

    func node(for id: String) -> AdventureNode? {
        nodes[id]
    }
}

