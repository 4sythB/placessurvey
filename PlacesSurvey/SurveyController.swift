//
//  SurveyController.swift
//  PlacesSurvey
//
//  Created by Brad on 7/21/16.
//  Copyright © 2016 Brad Forsyth. All rights reserved.
//

import Foundation

class SurveyController {
    
    static let baseURL = NSURL(string: "https://placessurvey-fe487.firebaseio.com/api")
    
    static func putSurveyIntoAPI(name: String, response: String) {
        let survey = Survey(name: name, response: response)
        
        guard let url = survey.endpoint else { return }
        
        NetworkController.performRequestForURL(url, httpMethod: .Put, body: survey.jsonData) { (data, error) in
            guard let data = data, responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else { return }
            
            if error != nil {
                print("Error: \(error?.localizedDescription)")
            } else if responseDataString.containsString("error") {
                print("Error: \n\(responseDataString)")
            } else {
                print("Success! \n\(responseDataString)")
            }
        }
    }
    
    static let getterEndpoint = baseURL?.URLByAppendingPathExtension("json")
    
    static func getSurvey(completion: (surveys: [Survey]) -> Void) {
        guard let url = getterEndpoint else { return }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            guard let data = data, responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else { return }
            
            guard let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String : [String : AnyObject]] else {
                print("Unable to serialize JSON. \(responseDataString)")
                completion(surveys: [])
                return
            }
            
            let surveys = jsonDictionary.flatMap { Survey(identifier: $0.0, dictionary: $0.1) }
            
            dispatch_async(dispatch_get_main_queue()) {
                completion(surveys: surveys)
                
            }
        }
    }
}