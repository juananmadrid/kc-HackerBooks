//
//  Tag.swift
//  HackerBooks
//
//  Created by KRONOX on 3/2/17.
//  Copyright © 2017 kronox. All rights reserved.
//

import Foundation

class Tag {
    
    
    // MARK: - Stores properties
    var name	: String
    var isFavorite: Bool

    // MARK: - Initialization
    init(tag: String){
        
        name = tag
        isFavorite = false
        // Solo el Tag Favorite lo tendrá a True
    }

    
    // MARK: - Proxies
    func proxyForEquality() -> String{
        return "\(isFavorite)\(name)"
    }
    
    func proxyForComparison() -> String{
        return proxyForEquality()
    }

}





// MARK: - Protocols

extension Tag: Equatable{
    
    public static func ==(lhs: Tag,
                          rhs: Tag) -> Bool{
        return (lhs.proxyForEquality() == rhs.proxyForEquality())
    }
}

extension Tag: Comparable{
    
    public static func <(lhs: Tag,
                         rhs: Tag) -> Bool{
        return (lhs.proxyForComparison() < rhs.proxyForComparison())
    }
}

extension Tag: Hashable{                    // Hash de Tag = hash de _name
    public var hashValue: Int {
        return name.hashValue
    }
}

