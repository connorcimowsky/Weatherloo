//
//  StatusBarButtonItem.swift
//  Weatherloo
//
//  Created by Connor Cimowsky on 12/18/14.
//  Copyright (c) 2014 Connor Cimowsky. All rights reserved.
//

import UIKit

class StatusBarButtonItem: UIBarButtonItem {
    var label: UILabel
    var text: String? {
        get {
            return self.label.text
        }
        
        set {
            self.label.text = newValue
            self.label.sizeToFit()
        }
    }
    
    // MARK: - Lifecycle
    
    required init(coder aDecoder: NSCoder) {
        self.label = UILabel()
        self.label.font = UIFont.systemFontOfSize(UIFont.systemFontSize())
        
        super.init(coder: aDecoder)
        
        self.customView = self.label
    }
}
