//
//  NextQuestion.swift
//  TrueFalseStarter
//
//  Created by Alan Longcoy on 2/3/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import GameKit

struct TriviaGame
{
    let trivia: [[String]]
    let questionsPerRound: Int
    var questionsAsked: Int
    var correctAnswers: Int
    var alreadyAskedQuestion: Bool
    var alreadyAskedQuestionArray: [Int]
    
    init()
    {
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
        
        questionsPerRound = 10
        questionsAsked = 0
        correctAnswers = 0
        alreadyAskedQuestion = true
        alreadyAskedQuestionArray = []
    }

    
    mutating func getQuestionNumber() -> Int
    {
        var questionNumber: Int = 0
        
        while alreadyAskedQuestion
        {
            questionNumber = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
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
        
        return questionNumber
    }
    
    func getQuestion(questionNumber: Int) -> String
    {
        
        return trivia[questionNumber][0]
    }
    
    func getOptions(questionNumber: Int) -> [String]
    {
        return [trivia[questionNumber][1],trivia[questionNumber][2],trivia[questionNumber][3],trivia[questionNumber][4]]
    }
    
    func getAnswer(questionNumber: Int) -> String
    {
        
        return trivia[questionNumber][5]
    }
    
    func getCorrectAnswers() -> Int
    {
        return correctAnswers
    }
    
    func getQuestionsPerRound() -> Int
    {
        return questionsPerRound
    }
    
    func getQuestionsAsked() -> Int
    {
        return questionsAsked
    }
    
    mutating func incrementCorrectAnswer()
    {
        correctAnswers = correctAnswers + 1
    }
    
    mutating func incrementQuestionsAsked()
    {
        questionsAsked = questionsAsked + 1
    }

}
