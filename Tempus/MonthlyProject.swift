//
//  MonthlyProject.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 7/14/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import Foundation

class MProject {
    private var _name: String!
    private var _color: String!
    private var _hours: Int!
    private var _year: Int!
    private var _month: Int!
    
    
    var name: String! {
        return _name
    }
    
    var color: String! {
        return _color
    }
    
    var hours: Int! {
        return _hours
    }
    
    var year: Int! {
        return _year
    }
    
    var month: Int! {
        return _month
    }
    
    init( name: String, color: String, hours: Int, year: Int, month: Int) {
        self._name = name
        self._color = color
        self._hours = hours
        self._year = year
        self._month = month 
    }
}

