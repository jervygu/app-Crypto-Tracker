//
//  Extensions.swift
//  Crypto Tracker
//
//  Created by Jervy Umandap on 8/20/21.
//

import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return left + width
    }
    
    var top: CGFloat {
        return frame.size.width
    }
    
    var bottom: CGFloat {
        return top + height
    }
}
