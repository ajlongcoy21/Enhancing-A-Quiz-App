//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    var newGame = TriviaGame()
    var questionNumber: Int = 0
    var questionOptions: [String] = []
    
    var gameSound: SystemSoundID = 0
    var correctAnswerSound: SystemSoundID = 0
    var wrongAnswerSound: SystemSoundID = 0
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var Option1Button: UIButton!
    @IBOutlet weak var Option2Button: UIButton!
    @IBOutlet weak var Option3Button: UIButton!
    @IBOutlet weak var Option4Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadGameStartSound()
        
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion()
    {

        questionNumber = newGame.getQuestionNumber()
        
        questionField.text = newGame.getQuestion(questionNumber: questionNumber)
        
        questionOptions = newGame.getOptions(questionNumber: questionNumber)
        
        Option1Button.setTitle(questionOptions[0], for: UIControlState.normal)
        Option2Button.setTitle(questionOptions[1], for: UIControlState.normal)
        Option3Button.setTitle(questionOptions[2], for: UIControlState.normal)
        Option4Button.setTitle(questionOptions[3], for: UIControlState.normal)
        
        playAgainButton.isHidden = true
        
        
    }
    
    func displayScore()
    {
        // Hide the answer buttons
        Option1Button.isHidden = true
        Option2Button.isHidden = true
        Option3Button.isHidden = true
        Option4Button.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(newGame.getCorrectAnswers()) out of \(newGame.getQuestionsPerRound()) correct!"
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton)
    {
        // Increment the questions asked counter
        newGame.incrementQuestionsAsked()
        
        switch sender
        {
        case Option1Button:
            if newGame.getAnswer(questionNumber: questionNumber) == "1"
            {
                newGame.incrementCorrectAnswer()
                questionField.text = "Correct!"
                playCorrectAnswerSound()
            }
            else
            {
                questionField.text = "Sorry, wrong answer!"
                playWrongAnswerSound()
            }
        case Option2Button:
            if newGame.getAnswer(questionNumber: questionNumber) == "2"
            {
                newGame.incrementCorrectAnswer()
                questionField.text = "Correct!"
                playCorrectAnswerSound()
            }
            else
            {
                questionField.text = "Sorry, wrong answer!"
                playWrongAnswerSound()
            }
        case Option3Button:
            if newGame.getAnswer(questionNumber: questionNumber) == "3"
            {
                newGame.incrementCorrectAnswer()
                questionField.text = "Correct!"
                playCorrectAnswerSound()
            }
            else
            {
                questionField.text = "Sorry, wrong answer!"
                playWrongAnswerSound()
            }
        case Option4Button:
            if newGame.getAnswer(questionNumber: questionNumber) == "4"
            {
                newGame.incrementCorrectAnswer()
                questionField.text = "Correct!"
                playCorrectAnswerSound()
            }
            else
            {
                questionField.text = "Sorry, wrong answer!"
                playWrongAnswerSound()
            }
        default:
            break
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound()
    {
        if newGame.getQuestionsAsked() == newGame.getQuestionsPerRound()
        {
            // Game is over
            displayScore()
        }
        else
        {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain()
    {
        // Show the answer buttons
        Option1Button.isHidden = false
        Option2Button.isHidden = false
        Option3Button.isHidden = false
        Option4Button.isHidden = false
        
        newGame = TriviaGame()
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int)
    {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime)
        {
            self.nextRound()
        }
    }
    
    func loadGameStartSound()
    {
        var pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        var soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
        
        pathToSoundFile = Bundle.main.path(forResource: "CorrectAnswer", ofType: "wav")
        soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &correctAnswerSound)
        
        pathToSoundFile = Bundle.main.path(forResource: "WrongAnswer", ofType: "wav")
        soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &wrongAnswerSound)
    }
    
    func playGameStartSound()
    {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func playCorrectAnswerSound()
    {
        AudioServicesPlaySystemSound(correctAnswerSound)
    }
    
    func playWrongAnswerSound()
    {
        AudioServicesPlaySystemSound(wrongAnswerSound)
    }
}

