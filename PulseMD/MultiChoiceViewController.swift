//
//  MultiChoiceViewController.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/11/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit

class MultiChoiceViewController: UIViewController {

    @IBOutlet weak var multiChoiceTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMultiChoiceAnswers()
        // Do any additional setup after loading the view.
    }

    func setUpMultiChoiceAnswers()
    {
        multiChoiceAvalableAnswers = deployedSurveyQuestions?[currentSurveyQuestionIndex]["multi"] as! [String]
        multiChoiceTableView.reloadData()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return multiChoiceAvalableAnswers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell : MultiChoiceTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "multiChoice") as? MultiChoiceTableViewCell!)!
        cell.multiChoice.text = multiChoiceAvalableAnswers[(indexPath as NSIndexPath).row]
        cell.backgroundColor = UIColor.clear
        
        
        let backgroundView = UIView()
        //backgroundView.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 131.0, blue: 195.0, alpha: 0.3)
        backgroundView.backgroundColor = UIColor(red: 10.0, green: 10.0, blue: 10.0, alpha: 0.3)
        
        cell.selectedBackgroundView = backgroundView
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath)
    {
        multichoiceSelection = multiChoiceAvalableAnswers[(indexPath as NSIndexPath).row]
        let cell = tableView.cellForRow(at: indexPath)
        //cell!.textLabel!.backgroundColor = UIColor.whiteColor()
        print( multichoiceSelection )
        cell!.textLabel!.textColor = UIColor.black
        cell?.textLabel?.tintColor = self.view.tintColor

        nc.post(name:Notification.Name(rawValue:"surveyAnswerCreation"),
                object: nil)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAtIndexPath indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)
        cell!.textLabel!.backgroundColor = UIColor.clear
        cell!.textLabel!.textColor = UIColor.white
        
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
