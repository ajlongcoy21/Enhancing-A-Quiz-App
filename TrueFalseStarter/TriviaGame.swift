//
//  NextQuestion.swift
//  TrueFalseStarter
//
//  Created by Alan Longcoy on 2/3/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import GameKit

/*------------------------------------------------------------------------------
 TriviaGame Struct
 
 Contains many variables and methods to run the trivia game app.
------------------------------------------------------------------------------*/

struct TriviaGame
{
    let trivia: [[String]]                  // Array of strings to hold the questions, answer options, and correct answer value
    let questionsPerRound: Int              // Determines how many unique questions there are for the game
    var questionsAsked: Int                 // Used to store how many questions have already been asked during the game
    var correctAnswers: Int                 // Used to track how many answer were correct by the player
    var alreadyAskedQuestion: Bool          // Used to make sure there are no questions asked twice
    var alreadyAskedQuestionArray: [Int]    // Used to keep track of which questions have been already asked
    
    init()
    {
        
        // Setup questions for the trivia game
        
        trivia =
            [
                ["This was the only US President to serve more than two consecutive terms.", "George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson", "2"],
                ["Which of the following countries has the most residents?", "Nigeria", "Russia", "Iran", "Vietnam", "1"],
                ["In what year was the United Nations founded?", "1918", "1919", "1945", "1954", "3"],
                ["The Titanic departed from the United Kingdom, where was it supposed to arrive?", "Paris", "Washington D.C.", "New York City", "Boston", "3"],
                ["Which nation produces the most oil?", "Iran", "Iraq", "Brazil", "Canada", "4"],
                ["Which country has most recently won consecutive World Cups in Soccer?", "Italy", "Brazil", "Argentina", "Spain", "2"],
                ["Which of the following rivers is longest?", "Yangtze", "Mississippi", "Congo", "Mekong", "2"],
                ["Which city is the oldest?", "Mexico City", "Cape Town", "San Juan", "Sydney", "1"],
                ["Which country was the first to allow women to vote in national elections?", "Poland", "United States", "Sweden", "Senegal", "1"],
                ["Which of these countries won the most medals in the 2012 Summer Games?", "France", "Germany", "Japan", "Great Britian", "4"]
        ]
        
        questionsPerRound = trivia.count   // Determine the amount of questions to be asked
        questionsAsked = 0                 // Initialize the questions asked to 0
        correctAnswers = 0                 // Initialize the correct answers to 0
        alreadyAskedQuestion = true        // Initialize to true to work with the while loop
        alreadyAskedQuestionArray = []     // Set as blank array
    }

    /*------------------------------------------------------------------------------
     get QuestionNumber
     
     Arguments: None
     Returns: Integer
     
     generates a random number to determine a question to be asked. The function
     will make sure that a duplicate question will not be asked.
    ------------------------------------------------------------------------------*/
    mutating func getQuestionNumber() -> Int
    {
        var questionNumber: Int = 0     // used to hold a question number until it is determined the question has not been asked
        
        // Loop until we find a question that has not been asked
        
        while alreadyAskedQuestion
        {
            questionNumber = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
            alreadyAskedQuestion = false
            
            // Loop through questions already asked in array to see if the current question # has been asked
            
            for questionsAsked in alreadyAskedQuestionArray
            {
                if questionsAsked == questionNumber
                {
                    alreadyAskedQuestion = true
                }
            }
        }
        
        alreadyAskedQuestionArray.append(questionNumber)  //Add question to array
        alreadyAskedQuestion = true
        
        return questionNumber // Return the current question number
    }
    
    /*------------------------------------------------------------------------------
     get Question
     
     Arguments: Integer
     Returns: String
     
     returns the string of the question
     ------------------------------------------------------------------------------*/
    
    func getQuestion(questionNumber: Int) -> String
    {
        
        return trivia[questionNumber][0]
    }
    
    /*------------------------------------------------------------------------------
     getOptions
     
     Arguments: Integer
     Returns: Array of Strings
     
     returns question answer options
     ------------------------------------------------------------------------------*/
    
    func getOptions(questionNumber: Int) -> [String]
    {
        return [trivia[questionNumber][1],trivia[questionNumber][2],trivia[questionNumber][3],trivia[questionNumber][4]]
    }
    
    /*------------------------------------------------------------------------------
     getAnswer
     
     Arguments: Integer
     Returns: String
     
     returns question answer
     ------------------------------------------------------------------------------*/
    
    func getAnswer(questionNumber: Int) -> String
    {
        
        return trivia[questionNumber][5]
    }
    
    /*------------------------------------------------------------------------------
     getCorrectAnswers
     
     Arguments: None
     Returns: Int
     
     returns # of correct answers
     ------------------------------------------------------------------------------*/
    
    func getCorrectAnswers() -> Int
    {
        return correctAnswers
    }
    
    /*------------------------------------------------------------------------------
     getQuestionsPerRound
     
     Arguments: None
     Returns: Int
     
     returns # of questions per round
     ------------------------------------------------------------------------------*/
    
    func getQuestionsPerRound() -> Int
    {
        return questionsPerRound
    }
    
    /*------------------------------------------------------------------------------
     getQuestionsAsked
     
     Arguments: None
     Returns: Int
     
     returns # of questions asked
     ------------------------------------------------------------------------------*/
    
    func getQuestionsAsked() -> Int
    {
        return questionsAsked
    }
    
    /*------------------------------------------------------------------------------
     incrementCorrectAnswer
     
     Arguments: None
     Returns: None
     
     increments correctAnswer by 1
     ------------------------------------------------------------------------------*/
    
    mutating func incrementCorrectAnswer()
    {
        correctAnswers = correctAnswers + 1
    }
    
    /*------------------------------------------------------------------------------
     incrmentQuestionsAsked
     
     Arguments: None
     Returns: None
     
     increments questionsAsked by 1
     ------------------------------------------------------------------------------*/
    
    mutating func incrementQuestionsAsked()
    {
        questionsAsked = questionsAsked + 1
    }

}
