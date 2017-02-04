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
    var alreadyAskedQuestion: Bool = true
    var alreadyAskedQuestionArray: [Int] = []
    
    var gameSound: SystemSoundID = 0
    
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
        while alreadyAskedQuestion
        {
            questionNumber = newGame.getQuestionNumber()
            
            alreadyAskedQuestion = false
            
            for questionsAsked in alreadyAskedQuestionArray
            {
                if questionsAsked == questionNumber
                {
                    alreadyAskedQuestion = true
                }
            }
        }
        
        alreadyAskedQuestionArray.append(questionNumber)
        alreadyAskedQuestion = true
        
        questionField.text = newGame.getQuestion(questionNumber: questionNumber)
        
        questionOptions = newGame.getOptions(questionNumber: questionNumber)
        
        playAgainButton.isHidden = true
        
        Option1Button.setTitle(questionOptions[0], for: UIControlState.normal)
        Option2Button.setTitle(questionOptions[1], for: UIControlState.normal)
        Option3Button.setTitle(questionOptions[2], for: UIControlState.normal)
        Option4Button.setTitle(questionOptions[3], for: UIControlState.normal)
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
            }
            else
            {
                questionField.text = "Sorry, wrong answer!"
            }
        case Option2Button:
            if newGame.getAnswer(questionNumber: questionNumber) == "2"
            {
                newGame.incrementCorrectAnswer()
                questionField.text = "Correct!"
            }
            else
            {
                questionField.text = "Sorry, wrong answer!"
            }
        case Option3Button:
            if newGame.getAnswer(questionNumber: questionNumber) == "3"
            {
                newGame.incrementCorrectAnswer()
                questionField.text = "Correct!"
            }
            else
            {
                questionField.text = "Sorry, wrong answer!"
            }
        case Option4Button:
            if newGame.getAnswer(questionNumber: questionNumber) == "4"
            {
                newGame.incrementCorrectAnswer()
                questionField.text = "Correct!"
            }
            else
            {
                questionField.text = "Sorry, wrong answer!"
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
        alreadyAskedQuestionArray = []
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

