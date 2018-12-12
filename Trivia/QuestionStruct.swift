//
//  QuestionStruct.swift
//  Trivia
//
//  Created by Brian van de Velde on 10-12-18.
//  Copyright © 2018 Brian van de Velde. All rights reserved.
//

import UIKit

struct QuestionStruct: Codable
{
    var category: String
    var type: String
    var difficulty: String
    var question: String
    var correct_answer: String
    var incorrect_answers: [String]
}

struct ResultStruct: Codable
{
    let results: [QuestionStruct]
}
