//
//  Validators.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import Foundation

struct Validators {

    static func nonEmpty(_ value: String, fieldName: String) -> String? {
        value.trimmingCharacters(in: .whitespaces).isEmpty
            ? String(format: NSLocalizedString("validation_required", comment: ""), fieldName)
            : nil
    }

    static func validEmail(_ email: String) -> String? {
        let pattern = #"^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        let result = email.range(of: pattern, options: .regularExpression)
        return result == nil
            ? NSLocalizedString("validation_email", comment: "")
            : nil
    }

    static func validPhone(_ phone: String) -> String? {
        let digits = phone.filter { $0.isNumber }
        return digits.count < 7
            ? NSLocalizedString("validation_phone", comment: "")
            : nil
    }

    static func validName(_ name: String) -> String? {
        name.trimmingCharacters(in: .whitespaces).count < 2
            ? NSLocalizedString("validation_name", comment: "")
            : nil
    }

    static func validate(_ rules: [String?]) -> String? {
        rules.first(where: { $0 != nil }) ?? nil
    }
}
