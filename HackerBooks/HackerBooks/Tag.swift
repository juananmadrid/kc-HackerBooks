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

    
    // MARK: - Proxies
    func proxyForEquality() -> String{
        return "\(name)"
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

extension Tag: Hashable{
    public var hashValue: Int {
        return name.hashValue
    }
}

