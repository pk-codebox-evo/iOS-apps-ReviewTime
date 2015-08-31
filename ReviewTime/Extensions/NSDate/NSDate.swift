//
//  NSDate.swift
//
//  Created by Nathan Hegedus on 27/05/15.
//  Copyright (c) 2015 Nathan Hegedus. All rights reserved.
//

import UIKit

extension NSDate {
    
    var formatted: String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        formatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)!
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        return formatter.stringFromDate(self)
    }
    
    // MARK: - Public Methods
    // MARK: Difference From Dates
    func yearsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitYear, fromDate: date, toDate: self, options: nil).year
    }
    func monthsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitMonth, fromDate: date, toDate: self, options: nil).month
    }
    func weeksFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitWeekOfYear, fromDate: date, toDate: self, options: nil).weekOfYear
    }
    func daysFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay, fromDate: date, toDate: self, options: nil).day
    }
    func hoursFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitHour, fromDate: date, toDate: self, options: nil).hour
    }
    func minutesFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitMinute, fromDate: date, toDate: self, options: nil).minute
    }
    func secondsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitSecond, fromDate: date, toDate: self, options: nil).second
    }
    func offsetFrom(date:NSDate) -> (offSet: Int, newDateWithOffset: NSDate)? {
        let yearsOffset = yearsFrom(date)
        if yearsOffset   > 0 { return (yearsOffset, NSDate.sumYears(yearsOffset, toDate: date))   }
        
        let monthsOffset = monthsFrom(date)
        if monthsOffset  > 0 { return (monthsOffset, NSDate.sumMonths(monthsOffset, toDate: date))   }
        
        let weeksOffset = weeksFrom(date)
        if weeksOffset  > 0 { return (weeksOffset, NSDate.sumWeeks(weeksOffset, toDate: date))   }
        
        let daysOffset = daysFrom(date)
        if daysOffset  > 0 { return (daysOffset, NSDate.sumDays(daysOffset, toDate: date))   }
        
        let hoursOffset = hoursFrom(date)
        if hoursOffset  > 0 { return (hoursOffset, NSDate.sumHours(hoursOffset, toDate: date))   }
        
        let minutesOffset = minutesFrom(date)
        if minutesOffset  > 0 { return (minutesOffset, NSDate.sumMinutes(minutesOffset, toDate: date))   }
        
        let secondsOffset = secondsFrom(date)
        if secondsOffset  > 0 { return (secondsOffset, NSDate.sumSeconds(secondsOffset, toDate: date))   }
        
        return nil
    }

    // MARK: Compare Date
    func isGreaterThanDate(dateToCompare : NSDate) -> Bool {
        return self.compareDate(dateToCompare, withComparisonResult: .OrderedDescending)
    }
    func isLessThanDate(dateToCompare : NSDate) -> Bool {
        return self.compareDate(dateToCompare, withComparisonResult: .OrderedAscending)
    }
    func isDateEqualsToDate(dateToCompare : NSDate) -> Bool {
        return self.compareDate(dateToCompare, withComparisonResult: .OrderedSame)
    }
    private func compareDate(date: NSDate, withComparisonResult: NSComparisonResult) -> Bool {
        return self.compare(date) == withComparisonResult
    }
    
    // MARK: - Public Static Methods
    // MARK: Changing Date
    class func sumYears(year: Int, toDate date: NSDate) -> NSDate {
        return self.editDateByAddingUnit(.CalendarUnitYear, value: year, toDate: date)
    }
    class func sumMonths(months: Int, toDate date: NSDate) -> NSDate {
        return self.editDateByAddingUnit(.CalendarUnitMonth, value: months, toDate: date)
    }
    class func sumWeeks(weeks: Int, toDate date: NSDate) -> NSDate {
        return self.editDateByAddingUnit(.CalendarUnitWeekOfYear, value: weeks, toDate: date)
    }
    class func sumDays(days: Int, toDate date: NSDate) -> NSDate {
        return self.editDateByAddingUnit(.CalendarUnitDay, value: days, toDate: date)
    }
    class func sumHours(hours: Int, toDate date: NSDate) -> NSDate {
        return self.editDateByAddingUnit(.CalendarUnitHour, value: hours, toDate: date)
    }
    class func sumMinutes(minutes: Int, toDate date: NSDate) -> NSDate {
        return self.editDateByAddingUnit(.CalendarUnitMinute, value: minutes, toDate: date)
    }
    class func sumSeconds(seconds: Int, toDate date: NSDate) -> NSDate {
        return self.editDateByAddingUnit(.CalendarUnitSecond, value: seconds, toDate: date)
    }
    
    // MARK: Localization
    class func localeDateStringFromDate(date: NSDate) -> String {
        return self.localeDateStringFromDate(date, withStyle: .ShortStyle)
    }
    class func localeDateStringFromDate(date: NSDate, withStyle style: NSDateFormatterStyle) -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = style
        dateFormatter.locale = NSLocale.currentLocale()
        return dateFormatter.stringFromDate(date)
    }
    
    // MARK: - Private Static Methods
    private class func editDateByAddingUnit(unit: NSCalendarUnit, value: Int, toDate date: NSDate) -> NSDate {
        
        var newDate = NSCalendar.currentCalendar().dateByAddingUnit(
            unit,
            value: value,
            toDate: date,
            options: NSCalendarOptions(0))
        
        return newDate!

    }
    
}