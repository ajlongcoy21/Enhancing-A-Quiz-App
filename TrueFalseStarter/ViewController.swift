//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
//

/*--------------------------------------------------------------------------
 Import kits and toolboxes
 --------------------------------------------------------------------------*/

import UIKit
import GameKit
import AudioToolbox

/*--------------------------------------------------------------------------
 Class ViewController
 
 Controls the view part of the application
 --------------------------------------------------------------------------*/

class ViewController: UIViewController
{
    /*--------------------------------------------------------------------------
     Define local variables that are used to control the trivia game display
    --------------------------------------------------------------------------*/
    
    var newGame = TriviaGame()                     // Create a TriviaGame instance
    var questionNumber: Int = 0                    // QuestionNumber - used to identify which question and answer pair needs to be displayed
    var questionOptions: [String] = []             // questionOptions - An array of strings used to show the answer options for each question
    
    /*--------------------------------------------------------------------------
     Define local variables that are used for sound throughout the game
    --------------------------------------------------------------------------*/
    
    var gameSound: SystemSoundID = 0
    var correctAnswerSound: SystemSoundID = 0
    var wrongAnswerSound: SystemSoundID = 0
    
    /*--------------------------------------------------------------------------
     Create a connection between the screen labels and buttons and the 
     viewController.
    --------------------------------------------------------------------------*/
    
    @IBOutlet weak var questionField: UILabel!       //Label to display the question
    @IBOutlet weak var answerField: UILabel!         //Label to display if the answer was correct or not
    @IBOutlet weak var Option1Button: UIButton!      //Button to display answer option 1 to the question
    @IBOutlet weak var Option2Button: UIButton!      //Button to display answer option 2 to the question
    @IBOutlet weak var Option3Button: UIButton!      //Button to display answer option 3 to the question
    @IBOutlet weak var Option4Button: UIButton!      //Button to display answer option 4 to the question
    @IBOutlet weak var playAgainButton: UIButton!    //Button to determine if the player wants to play again
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Play game starting sound
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

        questionNumber = newGame.getQuestionNumber()  //Get a question number from the trivia game
        
        answerField.isHidden = true  // Hide the answer field until an answer is selected
        
        questionField.text = newGame.getQuestion(questionNumber: questionNumber)  // Display the question of the triviaGame
        
        questionOptions = newGame.getOptions(questionNumber: questionNumber)  // Obtain the answer options related to the question
        
        // Setup Buttons attributes to the starting condition for the question
        
        Option1Button.setTitleColor(UIColor.white, for: UIControlState.normal)
        Option2Button.setTitleColor(UIColor.white, for: UIControlState.normal)
        Option3Button.setTitleColor(UIColor.white, for: UIControlState.normal)
        Option4Button.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        // Display the answer options in the text field of the buttons
        
        Option1Button.setTitle(questionOptions[0], for: UIControlState.normal)
        Option2Button.setTitle(questionOptions[1], for: UIControlState.normal)
        Option3Button.setTitle(questionOptions[2], for: UIControlState.normal)
        Option4Button.setTitle(questionOptions[3], for: UIControlState.normal)
        
        // Hide the play again button until the game is finished
        
        playAgainButton.isHidden = true
    }
    
    func displayScore()
    {
        // Hide the answer buttons and field
        
        Option1Button.isHidden = true
        Option2Button.isHidden = true
        Option3Button.isHidden = true
        Option4Button.isHidden = true
        answerField.isHidden = true
        
        // Display play again button
        
        playAgainButton.isHidden = false
        
        // Display the score of the player
        
        questionField.text = "Way to go!\nYou got \(newGame.getCorrectAnswers()) out of \(newGame.getQuestionsPerRound()) correct!"
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton)
    {
        // Increment the questions asked counter
        
        newGame.incrementQuestionsAsked()
        
        // Check which button option was clicked
        
        switch sender
        {
        case Option1Button: // Player selected answer 1
            
            // If answer is correct 
            
            if newGame.getAnswer(questionNumber: questionNumber) == "1"
            {
                // Increase correct answer count by 1
                
                newGame.incrementCorrectAnswer()
                
                // Display that the answer the player chose is correct
                
                answerField.isHidden = false
                answerField.text = "Correct!"
                answerField.textColor = UIColor.cyan
                
                // Play correct sound noise
                
                playCorrectAnswerSound()
                
                unhighlightAnswers()
                
                Option1Button.setTitleColor(UIColor.white, for: UIControlState.normal)

            }
            else
            {
                // Play wrong sound noise
                
                playWrongAnswerSound()
                
                // Display that the answer the player chose is incorrect
                
                answerField.isHidden = false
                answerField.text = "Sorry, that's not it."
                answerField.textColor = UIColor.orange
                
                unhighlightAnswers()
                highlightCorrectAnswer()
                
                Option1Button.setTitleColor(UIColor.white, for: UIControlState.normal)
            }
        case Option2Button: // Player selected answer 2
            
            // If answer is correct
            
            if newGame.getAnswer(questionNumber: questionNumber) == "2"
            {
                // Increase correct answer count by 1
                
                newGame.incrementCorrectAnswer()
                
                // Display that the answer the player chose is correct
                
                answerField.isHidden = false
                answerField.text = "Correct!"
                answerField.textColor = UIColor.cyan
                
                // Play correct answer sound
                
                playCorrectAnswerSound()
                
                unhighlightAnswers()
                
                Option2Button.setTitleColor(UIColor.white, for: UIControlState.normal)
                
            }
            else
            {
                // Play wrong answer sound
                
                playWrongAnswerSound()
                
                // Display that the answer the player chose is incorrect
                
                answerField.isHidden = false
                answerField.text = "Sorry, that's not it."
                answerField.textColor = UIColor.orange
                
                unhighlightAnswers()
                highlightCorrectAnswer()
                
                Option2Button.setTitleColor(UIColor.white, for: UIControlState.normal)
                
            }
        case Option3Button: // Player selected answer 2
            
            // If answer is correct
            if newGame.getAnswer(questionNumber: questionNumber) == "3"
            {
                // Increase correct answer count by 1
                newGame.incrementCorrectAnswer()
                
                // Display that the answer the player chose is correct
                
                answerField.isHidden = false
                answerField.text = "Correct!"
                answerField.textColor = UIColor.cyan
                
                // Play correct answer sound
                
                playCorrectAnswerSound()
                
                unhighlightAnswers()
                
                Option3Button.setTitleColor(UIColor.white, for: UIControlState.normal)
            }
            else
            {
                // Play incorrect answer sound
                
                playWrongAnswerSound()
                
                // Display that the answer the player chose is incorrect
                
                answerField.isHidden = false
                answerField.text = "Sorry, that's not it."
                answerField.textColor = UIColor.orange
                
                unhighlightAnswers()
                highlightCorrectAnswer()
                
                Option3Button.setTitleColor(UIColor.white, for: UIControlState.normal)
                
            }
        case Option4Button: // Player selected answer 2
            
            // If answer is correct
            if newGame.getAnswer(questionNumber: questionNumber) == "4"
            {
                // Increase correct answer count by 1
                
                newGame.incrementCorrectAnswer()
                
                // Display that the answer the player chose is correct
                
                answerField.isHidden = false
                answerField.text = "Correct!"
                answerField.textColor = UIColor.cyan
                
                // Play correct answer sound
                
                playCorrectAnswerSound()
                
                unhighlightAnswers()
                
                Option4Button.setTitleColor(UIColor.white, for: UIControlState.normal)
            }
            else
            {
                // Play incorrect answer sound
                
                playWrongAnswerSound()
                
                // Display that the answer the player chose is incorrect
                
                answerField.isHidden = false
                answerField.text = "Sorry, that's not it."
                answerField.textColor = UIColor.orange
                
                unhighlightAnswers()
                highlightCorrectAnswer()
                
                Option4Button.setTitleColor(UIColor.white, for: UIControlState.normal)
            }
            
        default:
            
            break
        }
        
        // Delay the trivia game to allow the player to read the changes
        
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
    
    /*------------------------------------------------------------------------------
     unhighlightAnswers
     
     Arguments: None
     Returns: None
     
     unhighlights the answers showing the selection that the player chose
     ------------------------------------------------------------------------------*/
    
    func unhighlightAnswers()
    {
        // Make less visible the other options the user did not choose
        
        Option1Button.setTitleColor(UIColor.init(red: 0.0, green: 255.0, blue: 255.0, alpha: 0.2), for: UIControlState.normal)
        Option2Button.setTitleColor(UIColor.init(red: 0.0, green: 255.0, blue: 255.0, alpha: 0.2), for: UIControlState.normal)
        Option3Button.setTitleColor(UIColor.init(red: 0.0, green: 255.0, blue: 255.0, alpha: 0.2), for: UIControlState.normal)
        Option4Button.setTitleColor(UIColor.init(red: 0.0, green: 255.0, blue: 255.0, alpha: 0.2), for: UIControlState.normal)
    }
    
    /*------------------------------------------------------------------------------
     highlightCorrectAnswer
     
     Arguments: None
     Returns: None
     
     highlights the correct answer if the player answered incorrectly
     ------------------------------------------------------------------------------*/

    func highlightCorrectAnswer()
    {
        let correctAnswer = newGame.getAnswer(questionNumber: questionNumber)
        
        switch correctAnswer
        {
            case "1": Option1Button.setTitleColor(UIColor.init(red: 255.0, green: 0.0, blue: 0.0, alpha: 1.0), for: UIControlState.normal)
            
            case "2": Option2Button.setTitleColor(UIColor.init(red: 255.0, green: 0.0, blue: 0.0, alpha: 1.0), for: UIControlState.normal)
            
            case "3": Option3Button.setTitleColor(UIColor.init(red: 255.0, green: 0.0, blue: 0.0, alpha: 1.0), for: UIControlState.normal)
            
            case "4": Option4Button.setTitleColor(UIColor.init(red: 255.0, green: 0.0, blue: 0.0, alpha: 1.0), for: UIControlState.normal)
            
        default:
            break
            
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

