//
//  ViewController.swift
//  Terapeut
//
//  Created by Neel Redkar on 4/28/19.
//  Copyright © 2019 hackathon. All rights reserved.
//

import UIKit
import Foundation
class ViewController: UIViewController {
    @IBOutlet weak var textinput: UITextField!
    @IBOutlet weak var label: UITextView!
    @IBAction func button(_ sender: Any) {
        view.endEditing(true)
        if (textinput.text == "") {
        } else {
        let headers = [
            "authorization": "Bearer a30e831429d4461c9c0fc8adf84de4cc",
            "content-type": "application/json"
        ]
        let parameters = [
            "contexts": ["shop"],
            "lang": "en",
            "query": textinput.text!,
            "sessionId": "1234",
            "timezone": "America/New_York"
            ] as [String : Any]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        var request = URLRequest(url: URL(string: "https://api.dialogflow.com/v1/query?v=20150910")!)
        
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        request.httpMethod = "POST"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                var json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                json = (json?.value(forKey: "result") as! NSDictionary)
                json = (json?.value(forKey: "fulfillment") as! NSDictionary)
                print(json?["speech"] as Any)
                DispatchQueue.main.async {self.label.text = (json?["speech"] as! String);(json?["speech"] as! String)}
            }
        })
            task.resume()
            
        }
            
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
}

