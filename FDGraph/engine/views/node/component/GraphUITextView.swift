//
//  GraphTextView.swift
//  FDGraph
//
//  Created by Hevi on 27/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

public class GraphUITextView: UITextView, UITextViewDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    public func setup(text: String, fontSize: CGFloat, baseHeight: Int, textFieldWidth: Int, textFieldHeight: Int) {
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.delegate = self
    
//        self.frame = CGRect(x: 0, y: baseHeight / 2 + Int(radius), width: textFieldWidth, height: textFieldHeight)
        self.frame = CGRect(x: 0, y: baseHeight / 2, width: textFieldWidth, height: textFieldHeight)
        self.textColor = UIColor.lightGray
        self.backgroundColor = nil
        self.text = text
        self.textAlignment = .center
        self.isEditable = false
        self.isSelectable = false
        
        
        
        let toolbar = createToolBar()
        
        self.inputAccessoryView = toolbar
        
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
        fatalError("Not implemented")
    }
    
    @objc func cancelButtonAction() {
        self.endEditing(true)
    }
}
