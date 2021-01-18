//
//  GraphTextView.swift
//  FDGraph
//
//  Created by Hevi on 27/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

public protocol GraphUITextDelegate {
    func shouldSave(text: String)
    func shouldCancel()
}

public class GraphUITextView: UITextView, UITextViewDelegate {

    public var graphUITextdelegate: GraphUITextDelegate?
    
    private var maxTextFieldHeight: CGFloat!
    
    public func setup(graphUITextdelegate: GraphUITextDelegate, text: String, fontSize: CGFloat, textFieldWidth: Int, textFieldHeight: Int) {
        
        self.graphUITextdelegate = graphUITextdelegate
        self.maxTextFieldHeight = CGFloat(textFieldHeight)
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.delegate = self
    
        self.frame = CGRect(x: -textFieldWidth / 2, y: 0, width: textFieldWidth, height: 0)
        self.textColor = UIColor.lightGray
        self.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 0.2008775685)
        self.text = text
        self.textAlignment = .center
        self.isEditable = true
        self.isSelectable = true
        
        let toolbar = createToolBar()
        
        self.inputAccessoryView = toolbar
        
        self.sizeToFit()
        
    }

    private func createToolBar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 30)))
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        toolbar.setItems([cancelButton, flexSpace, doneButton], animated: false)
        toolbar.sizeToFit()
        return toolbar
    }

    @objc func doneButtonAction() {
        self.endEditing(true)
//        self.resignFirstResponder()
        graphUITextdelegate?.shouldSave(text: self.text)
    }
    
    @objc func cancelButtonAction() {
        self.endEditing(true)
        graphUITextdelegate?.shouldCancel()
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            print("enter pressed")
            graphUITextdelegate?.shouldSave(text: textView.text)
            self.endEditing(true)
            self.setContentOffset(.zero, animated: true)
            return false
        }
        
        if textView.frame.height < maxTextFieldHeight {
            self.sizeToFit()
        }
        return true
    }
    
    override public func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        var didHandleEvent = false
        for press in presses {
            guard let key = press.key else { continue }

            if key.modifierFlags == .command {
                print("command pressed")
                didHandleEvent = true
            }
        }

        if didHandleEvent == false {
            super.pressesBegan(presses, with: event)
        }
    }
}
