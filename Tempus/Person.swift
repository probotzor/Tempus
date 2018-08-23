//
//  Person.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/29/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import Foundation
import SwiftyJSON

class Person {
    private var _id: String!
    private var _name: String!
    private var _username: String!
    private var _picture: String!
    private var _slack: String!
    private var _position: String!
    private var _github: String!
    private var _skills: String!
    private var _tablla: String!
    private var _trello: String!
    private var _hardware: String!
    private var _role: Array<String>!
    private var _archived: Bool!
    
    
    var id: String! {
        return _id
    }
    
    var name: String! {
        return _name
    }
    var username: String! {
        return _username
    }
    var picture: String! {
        return _picture
    }
    var slack: String! {
        return _slack
    }
    var position: String! {
        return _position
    }
    var github: String! {
        return _github
    }
    var skills: String! {
        return _skills
    }
    var tablla: String! {
        return _tablla
    }
    var trello: String! {
        return _trello
    }
    var hardware: String! {
        return _hardware
    }
    
    var role: Array<String>! {
        return _role
    }
    
    var archived: Bool! {
        return _archived
    }
    
    
    
    init( id: String, name: String, username: String, picture: String, slack: String, position: String, github: String, skills: String, tablla: String, trello: String, hardware: String, role: Array<String>, archived: Bool) {
        self._id = id
        self._name = name
        self._username = username
        self._picture = picture
        self._slack = slack
        self._position = position
        self._github = github
        self._skills = skills
        self._tablla = tablla
        self._trello = trello
        self._hardware = hardware
        self._role = role
        self._archived = archived
    }
}
