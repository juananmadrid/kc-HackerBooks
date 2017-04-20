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
        
        // Convierto string de tags separados con comas en array de String
        let array: Array = tags.components(separatedBy: ",")
    
        // Convierto array de String en array de Tag
        let arrayTag = convers(array)
        
        // Imagen y pdf por defecto
        let defaultImageURL = Bundle.main.url(forResource: "emptyBookCover", withExtension: "png")
        let defaultPdfURL = Bundle.main.url(forResource: "emptyPdf", withExtension: "pdf")
        
        // Obtengo imagenes usando Async e imagenes por defecto 
        let image = AsyncData(url: imageURL, defaultData: try Data(contentsOf: defaultImageURL!))
        let pdf = AsyncData(url: pdfURL, defaultData: try Data(contentsOf: defaultPdfURL!))

        return Book(title: titulo!,
                    authors: autor!,
                    tags: arrayTag,
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



// MARK: - Loading

/// Ahora esto la descarga y decodificacion la hacemos directamente en AppDelegate
// Función que carga JSON e imagenes y devuelve un array de books
//func downloadJSONFiles() throws {
//    
//    // Obtenemos path de Documents
//    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//    let pathString = path.absoluteString
//    
//    // Guardamos path obtenido en UserDefaults, aquí guardaremos pdf
//    let defaults = UserDefaults.standard
//    defaults.set(pathString, forKey: "pathPdf")
//    
//    do{
//        
//        // No están los ficheros cargados, los descargamos y los guardamos
//        let url = URL(string: "https://t.co/K9ziV0z3SJ")
//        let data = try? Data(contentsOf: url!)
//        guard let json = data else{
//            throw LibraryError.resourcePointedByURLNotReachable
//        }
//        
//        // Guardamos el json descargado en un archivo
//
//        // url del fichero
//        let url_file: URL = URL(fileURLWithPath: "books_readable.json", relativeTo: path)
//        // Creamos fichero
//        let fileManager = FileManager.default
//        let created = fileManager.createFile(atPath: url_file.path, contents: json, attributes: nil)
//        
//        // Creamos flag indicador para indicar fichero cargado
//        let defaults = UserDefaults.standard
//        defaults.set(true, forKey: "PDFDownloadedYet")
//        
//    }catch{
//        throw LibraryError.resourcePointedByURLNotReachable
//    }
//}


//func loadFromLocalFile(fileName name: String) throws -> JSONArray{
//    
//    //let defaults = UserDefaults.standard
//    // let pathPdf = defaults.string(forKey: "pathPdf")
//
//    // let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//    let path = URL(fileURLWithPath: pathPdf!)
//    // let pathDoc = path.absoluteString
//    let urljson = path.appendingPathComponent("books_readable.json")
//    // let url = URL(fileURLWithPath: pathDoc)
//    if let data = try? Data(contentsOf: urljson),           // obtenemos Json
//        let maybeArray = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONArray,               // Convertimos en Array de Json
//        let jsonArray = maybeArray {
//
//      
//        return jsonArray
//        
//    }else{
//        throw LibraryError.jsonParsingError
//    }
//}

