import Foundation
import UIKit

class Book {
    
    // MARK: - Stored Properties
    let titulo      :   String
    let autores     :   String
    let tags        :   [Tag]       // Set<Tag>
    let image       :   AsyncData
    let pdf         :   AsyncData
    var isFavorite  :   Bool = false
    
    
    // MARK: - Inizialization
    
    init(title: String,
         authors: String,
         tags: [Tag],               // Set<Tag>
         photo: AsyncData,
         pdf: AsyncData){
        
        titulo = title
        autores = authors
        self.tags = tags
        image = photo
        self.pdf = pdf
        
    }
    
    // MARK: - Proxies
    func proxyForEquality() -> String{
        return "\(titulo)\(autores)\(pdf)"
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

extension Book: Hashable{
    
    var proxyForHashing : String{
        get{
            return "\(titulo)\(autores)"
        }
    }
    var hashValue: Int {
        return proxyForHashing.hashValue
    }
}




