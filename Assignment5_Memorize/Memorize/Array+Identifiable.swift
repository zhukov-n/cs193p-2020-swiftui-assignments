//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Nikolay Zhukov on 5/29/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching item: Element) -> Int? {
        for index in 0..<count {
            if self[index].id == item.id {
                return index
            }
        }
        
        return nil
    }
}
