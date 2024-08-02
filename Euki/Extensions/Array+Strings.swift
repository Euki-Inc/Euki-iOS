//
//  Array+Strings.swift
//  Euki
//
//  Created by Víctor Chávez on 10/10/22.
//  Copyright © 2022 Ibis. All rights reserved.
//

import Foundation

extension Array where Element == String {
    func toString() -> String {
        var string = ""
        self.forEach { item in
            string.append("\(string.isEmpty ? "" : ", ")\(item)")
        }
        return string
    }
}
