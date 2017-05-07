import Foundation
import UIKit

/*
 {
 "authors": "Scott Chacon, Ben Straub",
 "image_url": "http://hackershelf.com/media/cache/b4/24/b42409de128aa7f1c9abbbfa549914de.jpg",
 "pdf_url": "https://progit2.s3.amazonaws.com/en/2015-03-06-439c2/progit-en.376.pdf",
 "tags": "version control, git",
 "title": "Pro Git"
 }
 */

// MARK: - Aliases
typealias JSONObject        =   AnyObject
typealias JSONDictionary    =   [String : JSONObject]
typealias JSONArray         =   [JSONDictionary]
typealias tagArray          =   [Tag]


// MARK: - Decoder
func decode(book json: JSONDictionary) throws -> Book{

    // Validamos el diccionario
    guard let urlString_image = json["image_url"] as? String,
        let imageURL = URL(string: urlString_image)
        else{
            throw LibraryError.wrongURLFormatForJSONResource
    }
    
    guard let urlString_pdf = json["pdf_url"] as? String,
         let pdfURL = URL(string:urlString_pdf)
         else{
            throw LibraryError.wrongURLFormatForJSONResource
    }
    
    let autor 	= json["authors"] as? String
    let titulo  = json["title"] as? String
    
    if let tags = json["tags"] as? String{
        
        // Imagen y pdf por defecto
        let defaultImageURL = Bundle.main.url(forResource: "emptyBookCover", withExtension: "png")
        let defaultPdfURL = Bundle.main.url(forResource: "emptyPdf", withExtension: "pdf")
        let tags = Tags(parseCommaSeparated(string: tags).map{Tag(tagName: $0)})
        // Obtengo imagenes usando Async e imagenes por defecto 
        let image = AsyncData(url: imageURL, defaultData: try! Data(contentsOf: defaultImageURL!))
        let pdf = AsyncData(url: pdfURL, defaultData: try! Data(contentsOf: defaultPdfURL!))

        return Book(title: titulo!,
                    authors: autor!,
                    tags: tags,
                    photo: image,
                    pdf: pdf)
        
    }else{
        throw LibraryError.wrongJSONFormat
    }

}

// Versión opcional (json vacío)
func decode(book json: JSONDictionary?) throws -> Book{
    
    guard let json = json else {
        throw LibraryError.nilJSONObject
    }
    return try decode(book: json)
    
}


// MARK: - Utils

// Función que convierte array de Strings en array de Tags
func convers(_ array: Array<String>) -> tagArray{
    
    var arrayTag: tagArray = []
    
    for each in array{
        let tag = Tag (tagName: each)
        arrayTag.append(tag)
    }
        return arrayTag
}

// MARK: - Parsing

// Parsea strings separado por comas en un array de Authors o Tags
func parseCommaSeparated(string s: String)->[String]{
    
    return s.components(separatedBy: ",").map({ $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }).filter({ $0.characters.count > 0})
}


