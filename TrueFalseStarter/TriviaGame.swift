//
//  NextQuestion.swift
//  TrueFalseStarter
//
//  Created by Alan Longcoy on 2/3/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import GameKit

struct TriviaGame
{
    let trivia: [[String : String]] =
        [
        ["Question": "Only female koalas can whistle", "Answer": "False"],
        ["Question": "Blue whales are technically whales", "Answer": "True"],
        ["Question": "Camels are cannibalistic", "Answer": "False"],
        ["Question": "All ducks are birds", "Answer": "True"]
        ]
    
    let questionsPerRound: Int = 4
    var questionsAsked: Int = 0
    var correctAnswers: Int = 0

    
    func getQuestionNumber() -> Int
    {
        return GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
    }
    
    func getQuestion(questionNumber: Int) -> String
    {
        
        return trivia[questionNumber]["Question"]!
    }
    
    func getAnswer(questionNumber: Int) -> String
    {
        
        return trivia[questionNumber]["Answer"]!
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
