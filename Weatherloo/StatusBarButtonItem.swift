//
//  StatusBarButtonItem.swift
//  Weatherloo
//
//  Created by Connor Cimowsky on 12/18/14.
//  Copyright (c) 2014 Connor Cimowsky. All rights reserved.
//

import UIKit

class ContainerView: UIView {
    var label: UILabel {
        didSet {
            self.label.alpha = 0.0
            self.addSubview(self.label)
            
            UIView.animateWithDuration(0.3, delay: 0.0, options: .BeginFromCurrentState, animations: {
                oldValue.alpha = 0.0
                self.label.alpha = 1.0
            }, completion: { finished in
                oldValue.removeFromSuperview()
            })
        }
    }
    
    required override init() {
        self.label = UILabel()
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        self.label = UILabel()
        super.init(coder: aDecoder)
    }
    
    required override init(frame: CGRect) {
        self.label = UILabel()
        super.init(frame: frame)
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        return label.sizeThatFits(size)
    }
}

class StatusBarButtonItem: UIBarButtonItem {
    
    var containerView = ContainerView()
    var text: String? {
        get {
            return self.containerView.label.text
        }
        
        set {
            let newLabel = UILabel()
            newLabel.text = newValue
            newLabel.sizeToFit()
            
            self.containerView.label = newLabel
            self.containerView.sizeToFit()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.customView = self.containerView
    }
}
