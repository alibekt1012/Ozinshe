//
//  Validation.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 08.08.2023.
//

import Foundation

class Validation {
    public func validateEmailId(emailID: String) -> Bool {
         let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
         let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
         let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
         let isValidateEmail = validateEmail.evaluate(with: trimmedString)
         return isValidateEmail
      }
}
