//
//  Box.swift
//  Game
//
//  Created by Nhật Minh on 12/12/16.
//  Copyright © 2016 Nhật Minh. All rights reserved.
//

import UIKit

class Item: UIImageView {
    var isBox = false
    override init(image: UIImage?) {
        super.init(image: image)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
