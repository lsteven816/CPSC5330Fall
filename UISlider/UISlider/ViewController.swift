//
//  ViewController.swift
//  UISlider
//
//  Created by LaToya Stevens on 11/16/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var moodSlider: UISlider!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var savedLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        moodSlider.value = 50   // Neutral
        updateMoodLabel()
        savedLabel.text = ""
    }

        // Update label in real-time as slider moves
        @IBAction func moodSliderChanged(_ sender: UISlider) {
        updateMoodLabel()
    }

        // Save mood button tapped
        @IBAction func saveMoodTapped(_ sender: UIButton) {
        let moodEmoji = currentMoodEmoji(for: Int(moodSlider.value))
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"   // e.g. "Feb 1, 2025"
        let dateString = formatter.string(from: datePicker.date)

        savedLabel.text = "On \(dateString), you felt \(moodEmoji)"
    }

        // MARK: - Helper methods

        private func updateMoodLabel() {
        let value = Int(moodSlider.value)
        let (description, emoji) = moodDescription(for: value)
        moodLabel.text = "Feeling: \(description) \(emoji)"
    }

        private func moodDescription(for value: Int) -> (String, String) {
            switch value {
            case 0...20:
                return ("Very Sad", "😢")
            case 21...40:
                return ("Sad", "🙁")
            case 41...60:
                return ("Neutral", "😐")
            case 61...80:
                return ("Happy", "🙂")
            default: // 81...100
                return ("Very Happy", "😄")
            }
        }

        private func currentMoodEmoji(for value: Int) -> String {
               return moodDescription(for: value).1
        }
    }

