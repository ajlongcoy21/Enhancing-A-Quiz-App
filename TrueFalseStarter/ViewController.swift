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
    
    var gameSound: SystemSoundID = 0
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
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
        playAgainButton.isHidden = true
    }
    
    func displayScore()
    {
        // Hide the answer buttons
        trueButton.isHidden = true
        falseButton.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(newGame.getCorrectAnswers()) out of \(newGame.getQuestionsPerRound()) correct!"
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton)
    {
        // Increment the questions asked counter
        newGame.incrementQuestionsAsked()
        
        if (sender === trueButton &&  newGame.getAnswer(questionNumber: questionNumber) == "True") || (sender === falseButton && newGame.getAnswer(questionNumber: questionNumber) == "False")
        {
            newGame.incrementCorrectAnswer()
            questionField.text = "Correct!"
        }
        else
        {
            questionField.text = "Sorry, wrong answer!"
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
        trueButton.isHidden = false
        falseButton.isHidden = false
        
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
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound()
    {
        AudioServicesPlaySystemSound(gameSound)
    }
}

