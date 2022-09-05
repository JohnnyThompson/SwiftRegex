//
//  String+Extension.swift
//  CleverRegEx
//
//  Created by Евгений Карпов on 04.09.2022.
//

import Foundation

extension String {
    var trimmingWhitespaces: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func matches(_ regex: String) -> Bool {
        self.range(of: regex, options: .regularExpression) != nil
    }
}
