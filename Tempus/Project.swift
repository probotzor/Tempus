//
//  Project.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/29/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import Foundation

class Project {
    private var _id: String!
    private var _name: String!
    private var _color: String!
    private var _email: String!
    private var _teamlead: String!
    private var _trello: String
    private var _archived: Bool!
    
    
    var id: String! {
        return _id
    }
    
    var name: String! {
        return _name
    }
    
    var color: String! {
        return _color
    }
    var email: String! {
        return _email
    }
    var teamlead: String! {
        return _teamlead
    }
    var trello: String! {
        return _trello
    }
    var archived: Bool! {
        return _archived
    }
    
    
    init( id: String, name: String, color: String,email: String, teamlead: String , trello: String, archived: Bool) {
        self._id = id
        self._name = name
        self._color = color
        self._email = email
        self._teamlead = teamlead
        self._trello = trello
        self._archived = archived
        
    }
}
