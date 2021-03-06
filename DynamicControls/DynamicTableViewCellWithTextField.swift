//
//  DynamicTableViewCellWithTextField.swift
//  Dynamic Controls
//
//  Created by Joseph Duffy on 04/11/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit

public class DynamicTableViewCellWithTextField: DynamicTableViewCell {
    
    private var label: DynamicTypeLabel!
    private(set) public var textField: DynamicTypeTextField!
    override public var textLabel: UILabel {
        get {
            return self.label
        }
    }
    private var didUpdateConstraints = false
    
    override public func setup() {
        
        self.selectionStyle = .None
        
        self.label = DynamicTypeLabel()
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        self.textField = DynamicTypeTextField()
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField.borderStyle = .None
        self.textField.textAlignment = .Right
        // Setting this allows the text field to fill the space left by the label
        self.textField.setContentHuggingPriority(self.label.contentHuggingPriorityForAxis(.Horizontal) - 1, forAxis: .Horizontal)
        
        self.contentView.addSubview(self.label)
        self.contentView.addSubview(self.textField)
    }
    
    private func addConstraints() {
        self.contentView.addConstraints([
            // Label constraints
            NSLayoutConstraint(item: self.label, attribute: .Top, relatedBy: .GreaterThanOrEqual, toItem: self.contentView, attribute: .Top, multiplier: 1, constant: self.verticleOffset),
            NSLayoutConstraint(item: self.label, attribute: .Leading, relatedBy: .Equal, toItem: self.contentView, attribute: .Leading, multiplier: 1, constant: self.horizontalOffset),
            NSLayoutConstraint(item: self.label, attribute: .Bottom, relatedBy: .Equal, toItem: self.contentView, attribute: .Bottom, multiplier: 1, constant: -self.verticleOffset),
            // Text field constraints
            NSLayoutConstraint(item: self.textField, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.textField, attribute: .Leading, relatedBy: .Equal, toItem: self.label, attribute: .Trailing, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: self.textField, attribute: .Trailing, relatedBy: .Equal, toItem: self.contentView, attribute: .Trailing, multiplier: 1, constant: -self.horizontalOffset)
            ])
    }
    
    override public func updateConstraints() {
        if !self.didUpdateConstraints {
            self.addConstraints()            
            
            self.didUpdateConstraints = true
        }
        
        super.updateConstraints()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.label.preferredMaxLayoutWidth = CGRectGetWidth(self.label.frame)
        
        if !self.didUpdateConstraints {
            self.addConstraints()
        }
    }

    override public func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.textField.becomeFirstResponder()
        }
    }

}
