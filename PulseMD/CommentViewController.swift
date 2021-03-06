//
//  CommentViewController.swift
//  PulseMD
//
//  Created by Joseph Richardson on 10/11/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var userCommentText : UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        print( "loading the comment question" )
        setupComment()
        // Do any additional setup after loading the view.
    }
    
    func setupComment() -> () {
        nc.post(name:Notification.Name(rawValue:"nextButtonFadeIn"),
                object: nil)
    }

    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        
        
        textView.resignFirstResponder()
        
        return true;
    }
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        textView.text = ""
        textView.textColor = UIColor.black
        textView.becomeFirstResponder()
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        print( text )
        print( textView.text )
        if( text == "\n")
        {
            textView.resignFirstResponder()
        }
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
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
