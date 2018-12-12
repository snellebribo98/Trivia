//
//  Fetch.swift
//  Trivia
//
//  Created by Brian van de Velde on 12-12-18.
//  Copyright © 2018 Brian van de Velde. All rights reserved.
//

import UIKit

class fetch
{
    func fetchQuestion(completion: @escaping ([QuestionStruct]?) -> Void)
    {
        let baseURL = URL(string: "https://opentdb.com/api.php?amount=10&type=multiple")!
        let task = URLSession.shared.dataTask(with: baseURL)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let questions2 = try? jsonDecoder.decode(ResultStruct.self, from: data)
            {
                completion(questions2.results)
            }
            else
            {
                completion(nil)
            }
            
        }
        task.resume()
    }
    
    func fetchResult(completion: @escaping ([[String:Any]]?) -> Void)
    {
        let url = URL(string: "https://ide50-brianvdvelde.cs50.io:8080/results")!
        let task = URLSession.shared.dataTask(with: url)
        { (data, response, error) in
            if let data = data,
                let test = try? JSONSerialization.jsonObject(with: data) as? [[String:Any]] {
                completion(test)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func submitResults(name: String?, score: Int?)
    {
        let url = URL(string: "https://ide50-brianvdvelde.cs50.io:8080/results")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "name=\(name!)&score=\(score!)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            guard let data = data, error == nil else
            {
                print("error=\(error!)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {    
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")
        }
        task.resume()
    }
}
