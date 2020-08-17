//
//  Array+Only.swift
//  Memorize
//
//  Created by Nikolay Zhukov on 5/29/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
