//
//  Notification.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 7/20/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import Foundation

class Notification {
    
    private var _name: String!
    private var _picture: String!
    private var _description: String!
    private var _date: String!
    private var _datecreated: String!
    
    var name: String! {
        return _name
    }
    
    var picture: String! {
        return _picture
    }
    
    var description: String! {
        return _description
    }
    
    var date: String! {
        return _date
    }
    
    var datecreated: String! {
        return _datecreated
    }
    
    init(name: String, picture: String, description: String, date: String, datecreated: String) {
        self._name = name
        self._picture = picture
        self._description = description
        self._date = date
        self._datecreated = datecreated
    }
}
