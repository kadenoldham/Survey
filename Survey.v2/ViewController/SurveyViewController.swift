//
//  SurveyViewController.swift
//  Survey.v2
//
//  Created by Kaden Oldham on 10/5/17.
//  Copyright © 2017 Kaden Oldham. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, let emoji = emojiTextField.text, name != "", !emoji.isEmpty else { return }
        
        SurveyController.shared.putSurvey(with: name, emoji: emoji) { (success) in
            guard success else { return }
            
            DispatchQueue.main.async {
                // Clears out the textFields
                self.nameTextField.text = ""
                self.emojiTextField.text = ""
            }
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emojiTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
