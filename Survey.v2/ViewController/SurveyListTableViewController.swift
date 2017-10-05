//
//  SurveyListTableViewController.swift
//  Survey.v2
//
//  Created by Kaden Oldham on 10/5/17.
//  Copyright © 2017 Kaden Oldham. All rights reserved.
//

import UIKit

class SurveyListTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SurveyController.shared.fetchEmoji {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SurveyController.shared.surveys.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath)

        let survey = SurveyController.shared.surveys[indexPath.row]
        
        cell.textLabel?.text = survey.name
        cell.detailTextLabel?.text = survey.emoji

        return cell
    }
 


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 




}
