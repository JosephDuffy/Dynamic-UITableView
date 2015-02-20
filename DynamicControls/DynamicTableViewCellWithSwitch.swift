//
//  DynamicTableViewCellWithSwitch.swift
//  Dynamic Controls
//
//  Created by Joseph Duffy on 08/10/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit

public class DynamicTableViewCellWithSwitch: DynamicTableViewCell {
    private(set) public var rowSwitch: UISwitch!
    private var didUpdateConstraints = false
    
    override public func setup() {
        self.style = .Default
        self.forceUpdateDefaultLabels = true
        
        self.selectionStyle = .None
        
        self.rowSwitch = UISwitch()
        self.rowSwitch.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentView.addSubview(self.rowSwitch)
        
        super.setup()
    }
    
    private func addConstraints() {
        
        self.contentView.addConstraints([
            // Switch constraints
            NSLayoutConstraint(item: self.rowSwitch, attribute: .CenterY, relatedBy: .Equal, toItem: self.textLabel, attribute: .CenterY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.rowSwitch, attribute: .Leading, relatedBy: .Equal, toItem: self.textLabel, attribute: .Trailing, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: self.rowSwitch, attribute: .Trailing, relatedBy: .Equal, toItem: self.contentView, attribute: .Trailing, multiplier: 1, constant: -self.horizontalOffset)
            ])
        
        self.didUpdateConstraints = true
    }
    
    override public func updateConstraints() {
        if !self.didUpdateConstraints {
            self.addConstraints()
        }
        
        super.updateConstraints()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.didUpdateConstraints {
            self.addConstraints()
        }
    }
    
    override public func configureForContent(content: [String : AnyObject]) {
        super.configureForContent(content)
        if let switchOn = content["switchOn"] as? Bool {
            self.rowSwitch.on = switchOn
        }
    }
    
}
