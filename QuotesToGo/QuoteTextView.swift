//
//  QuoteTextView.swift
//  QuotesToGo
//
//  Created by Jacob K Giberson on 3/5/16.
//  Copyright © 2016 Daniel Autenrieth. All rights reserved.
//

import UIKit

class QuoteTextView: UITextView {

    var heightConstraint:NSLayoutConstraint?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        let size = self.sizeThatFits(CGSizeMake(self.bounds.width, CGFloat(FLT_MAX)))

        if self.heightConstraint == nil {
            heightConstraint = NSLayoutConstraint(item: self, attribute: <#T##NSLayoutAttribute#>.Height, relatedBy: <#T##NSLayoutRelation#>.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: CGFloat(1), constant: size.height)
        
            self.addConstraint(heightConstraint!)
            
        }
        
        heightConstraint!.constant = size.height
        
        super.updateConstraints()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
