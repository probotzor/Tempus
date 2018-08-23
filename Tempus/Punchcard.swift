//
//  Day.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 7/4/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import Foundation

class Punchcard {
    private var _id: String!
    private var _projectid: String!
    private var _projectname: String!
    private var _projectcolor: String!
    private var _hours: Int!
    private var _type: String!
    private var _email: String!
    private var _trello: String!
    private var _date: String!
    private var _datedate: Date!
    
    
    var id: String! {
        return _id
    }
    
    var projectid: String! {
        return _projectid
    }

    var projectname: String! {
        return _projectname
    }
    
    var projectcolor: String! {
        return _projectcolor
    }

    var hours: Int! {
        return _hours
    }
    
    var type: String! {
        return _type
    }
    
    var trello: String! {
        return _trello
    }
    var date: String! {
        return _date
    }
    
    var datedate: Date! {
        return _datedate
    }
    
    
    init( id: String, projectid: String, projectname: String, projectcolor: String, hours: Int, type: String, trello: String, date: String, datedate: Date!) {
        self._id = id
        self._projectid = projectid
        self._projectname = projectname
        self._projectcolor = projectcolor
        self._hours = hours
        self._type = type
        self._trello = trello
        self._date = date
        self._datedate = datedate
        
        
    }
}
