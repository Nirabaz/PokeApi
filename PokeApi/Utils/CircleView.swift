//
//  SELCircleView.swift
//  listUps
//
//  Created by Mykhailo Zabarin on 2/1/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import UIKit

class SELCircleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }

}
