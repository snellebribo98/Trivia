//
//  ResultsStruct.swift
//  Trivia
//
//  Created by Brian van de Velde on 11-12-18.
//  Copyright © 2018 Brian van de Velde. All rights reserved.
//

import UIKit

struct Score: Codable
{
    var id: Int
    var name: String
    var score: String
}

struct Scores: Codable
{
    let scores: [Score]
}
