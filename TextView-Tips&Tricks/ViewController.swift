//
//  ViewController.swift
//  TextView-Tips&Tricks
//
//  Created by ESS Mac Pro on 3/28/17.
//  Copyright © 2017 NGA Group Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lblCount: UILabel!
    @IBOutlet var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
//        self.view.endEditing(true)
        self.textView.resignFirstResponder()
        
    }
    
    func updateTextView(notification:Notification) {
        
        let userInfo = notification.userInfo!
        
        let keyBoardEndFrameCoordinates = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let keyBoardEndFrame = self.view.convert(keyBoardEndFrameCoordinates, to: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            textView.contentInset = UIEdgeInsets.zero
        }else{
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardEndFrame.height, right: 0)
            
//            textView.scrollIndicatorInsets = textView.contentInset
        }
        
        textView.scrollRangeToVisible(textView.selectedRange)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.textView.backgroundColor = UIColor.green
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.textView.backgroundColor = UIColor.clear
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        lblCount.text = "\(textView.text.characters.count)"
        
        return textView.text.characters.count + (text.characters.count - range.length) <= 1000
        
    }
}
