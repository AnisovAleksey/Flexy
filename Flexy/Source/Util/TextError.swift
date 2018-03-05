//
//  TextError.swift
//  Flexy
//
//  Created by Aleksey Anisov on 03.03.2018.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

struct TextError: Error {
    let error: String
    
    var localizedDescription: String {
        return error
    }
}
