//
//  Dan.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 7/7/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import Foundation

class Dan {
    private var _name: String!
    private var _date: String!
    private var _utcdate: Date!
    private var _pcard: [Punchcard]!
    
    var name: String! {
        return _name
    }
    var date: String! {
        return _date
    }
    var utcdate: Date! {
        return _utcdate
    }
    var pcard: [Punchcard]! {
        return _pcard
    }
    
    init(name: String, date: String, utcdate: Date!, pcard: [Punchcard]!) {
        self._name = name
        self._date = date
        self._utcdate = utcdate
        self._pcard = pcard
    }
    
    
    
}
