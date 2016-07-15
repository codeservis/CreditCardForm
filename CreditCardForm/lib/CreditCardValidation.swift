//
//  CreditCardValidation.swift
//  CreditCardForm
//
//  Created by Bruce McTigue on 7/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

func creditCardTypeFromString(string: String) -> CreditCardType {
    for type in CreditCardType.allValues {
        let predicate = NSPredicate(format: "SELF MATCHES %@", type.regex)
        let numbersString = onlyNumbersFromString(string)
        if predicate.evaluateWithObject(numbersString) {
            return type
        }
    }
    return CreditCardType.Unknown
}

func onlyNumbersFromString(string: String) -> String {
    let set = NSCharacterSet.decimalDigitCharacterSet().invertedSet
    let numbers = string.componentsSeparatedByCharactersInSet(set)
    return numbers.joinWithSeparator("")
}

func isValidExpirationDate(expirationDateString: String) -> Bool {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM/yy"
    if let expirationDate = dateFormatter.dateFromString(expirationDateString) {
        let now = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let expirationComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: expirationDate)
        expirationComponents.day = 0
        let expirationAdjustedDate = calendar.dateFromComponents(expirationComponents)
        if now.compare(expirationAdjustedDate!) == NSComparisonResult.OrderedAscending {
            return true
        }
        return false
    }
    return false
}


