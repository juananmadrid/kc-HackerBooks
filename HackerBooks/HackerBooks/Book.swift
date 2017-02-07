//
//  Book.swift
//  HackerBooks
//
//  Created by KRONOX on 31/1/17.
//  Copyright © 2017 kronox. All rights reserved.
//

import Foundation
import UIKit

class Book {
    
    // MARK: - Stored Properties
    let titulo      :   String
    let autores     :   String
    let tags        :   [Tag]
    let image       :   UIImage
    let urlPdf      :   URL
    var isFavorite  :   Bool = false
    
    
    // MARK: - Inizialization
    
    init(title: String,
         authors: String,
         tags: [Tag],
         photo: UIImage,
         pdf_url: URL){
        
        titulo = title
        autores = authors
        self.tags = tags
        image = photo
        urlPdf = pdf_url
        
    }
    
    // MARK: - Proxies
    func proxyForEquality() -> String{
        return "\(titulo)\(autores)\(urlPdf)"
    }
    
    func proxyForComparison() -> String{
        return proxyForEquality()
    }
    
}


// MARK: - Protocols

extension Book: Equatable{

    public static func ==(lhs: Book,
                          rhs: Book) -> Bool{
        return (lhs.proxyForEquality() == rhs.proxyForEquality())
    }
}

extension Book: Comparable{
    
    public static func <(lhs: Book,
                         rhs: Book) -> Bool{
        return (lhs.proxyForComparison() < rhs.proxyForComparison())
    }
}

extension Book : CustomStringConvertible{
    
    public var description: String{
        get{
            return "<\(type(of:self)): \(titulo) -- \(autores)>"
        }
    }
}



