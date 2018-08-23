//
//  Mesec.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 7/14/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import Foundation


class Mesec {
    private var _name: String!
    private var _number: Int!
    private var _mprojct: [MProject]!
    
    var name: String! {
        return _name
    }
    var number: Int! {
        return _number
    }
    var mprojct: [MProject]! {
        return _mprojct
    }
    
    init(name: String, number: Int, mprojct: [MProject]) {
        self._name = name
        self._number = number
        self._mprojct = mprojct
    }
    
    
    
}
