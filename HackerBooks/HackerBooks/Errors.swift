//
//  Errors.swift
//  HackerBooks
//
//  Created by KRONOX on 1/2/17.
//  Copyright © 2017 kronox. All rights reserved.
//

import Foundation

enum LibraryError : Error{
    case wrongURLFormatForJSONResource
    case resourcePointedByURLNotReachable
    case wrongJSONFormat
    case nilJSONObject
    case jsonParsingError
}
