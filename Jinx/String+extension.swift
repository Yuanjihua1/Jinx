//
//  String+extension.swift
//  Jinx
//
//  Created by ZhangJing on 2017/5/17.
//  Copyright © 2017年 xiuye. All rights reserved.
//

import Foundation

extension String {
    var longString : String? {
        
        switch self {
        case "generate" , "g":
            return "Generate"
        default:
            return nil
        }
        
        
    }
}
