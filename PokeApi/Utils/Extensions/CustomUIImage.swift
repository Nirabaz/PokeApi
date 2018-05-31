//
//  SELCustomUIImage.swift
//  listUps
//
//  Created by Mykhailo Zabarin on 2/1/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import UIKit

@IBDesignable
class CustomUIImage: UIImageView{
    @IBInspectable var isCircle: Bool = true{
        didSet{
            layoutIfNeeded()
            if  isCircle{
                self.layer.cornerRadius = self.frame.size.width/2
            }else{
                self.layer.cornerRadius = 0
            }
            self.clipsToBounds = true
        }
    }
}
