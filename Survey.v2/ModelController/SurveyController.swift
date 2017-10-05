//
//  EmojiController.swift
//  Survey.v2
//
//  Created by Kaden Oldham on 10/5/17.
//  Copyright © 2017 Kaden Oldham. All rights reserved.
//

import Foundation

class SurveyController {
    
    static let shared = SurveyController()
    
    //MARK: - Source of truth
    var surveys: [Survey] = []
    
    /*
     The empty completion is a great way to notify the called of the function that you are done running your code. You can complete with an object or an array of objects with the caller needs to access them. Both options give you the benifit of knowing exactly when that func id done running. This is always nice when you are running async code. because you dont know HOW LONG IT WILL TAKE!
     */
    
    //MARK: - baseURL
    private let baseURL = URL(string: "https://favemoji-76c04.firebaseio.com/")
    
    func putSurvey(with name: String, emoji: String, completion: @escaping (_ success: Bool) -> Void) {
        
        // Create an instance of SURVEY
        let survey = Survey(name: name, emoji: emoji)
        
        guard let url = baseURL else { fatalError("BAD URL")}
        
        // Build the URL
        let requestURL = url.appendingPathComponent(survey.identifier.uuidString).appendingPathExtension("json")
        
        
        // Create the request
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        request.httpBody = survey.jsonData
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            var success = false
            
            defer { completion(success) }
            
            // some super duper handeling
            if let error = error {
                NSLog("Brian broke out request \(error.localizedDescription) \(#function)")
            }
            
            guard let data = data, // resonceDataString is only for developer
                let responseDataString = String(data: data, encoding: .utf8) else { return }
            if let error = error {
                print("Error: \(error.localizedDescription) \(#function)")
            } else {
                print("Successfully saved data to endpoint \(responseDataString)")
            }
            // add survey to our source of truer
            self.surveys.append(survey)
            
            success = true
            
        }.resume()
        
    }
    
    func fetchEmoji(completion: @escaping () -> Void) {
        
        guard let url = baseURL?.appendingPathExtension("json") else {
            print("Bad baseURL")
            completion()
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("Error fetching \(error.localizedDescription) \(#function) \(#file)")
                completion()
                return
            }
            
            guard let data = data else { print("No data returned from data task"); completion (); return}
            
            guard let surveyDictionaries = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String: [String: String]]) else {
                print(" Fetching from JSONObject")
                completion()
                return
            }
            
            guard let surveys = surveyDictionaries?.flatMap({ Survey(dictionary: $0.value, identifier: $0.key)}) else { return }
            
            self.surveys = surveys
            completion()
        }.resume()
        
        
    }
}
















