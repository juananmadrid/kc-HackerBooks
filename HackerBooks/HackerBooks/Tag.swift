import Foundation

typealias Tags = Set<Tag>


class Tag {
    
    // MARK: - Stores properties
    var name	: String
    var isFavorite: Bool

    // MARK: - Initialization
    init(tagName: String){
        
        name = tagName.capitalized
        isFavorite = false

    }

}



// MARK: - Protocols

extension Tag: Equatable{
    
    public static func ==(lhs: Tag, rhs: Tag) -> Bool{
        return (lhs.name == rhs.name)
    }
}

extension Tag: Comparable{
    
    public static func <(lhs: Tag, rhs: Tag) -> Bool{
        
        if lhs.name == "Favorite"{                // Favorito siempre Tag menor
            return true
        }
        else if rhs.name == "Favorite"{           // Igual pero al en rhs
            return false
        }else{
            return lhs.name < rhs.name    // Ordenamos por nombre el resto de Tag
        }
        
    }
}

extension Tag: Hashable{
    public var hashValue: Int {
        return name.hashValue
    }
}

