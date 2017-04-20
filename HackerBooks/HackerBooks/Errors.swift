import Foundation

enum LibraryError : Error{
    case wrongURLFormatForJSONResource
    case emptyJSONObject
    case resourcePointedByURLNotReachable
    case wrongJSONFormat
    case nilJSONObject
    case jsonParsingError
}
