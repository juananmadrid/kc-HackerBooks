//
//  JSONProcessing.swift
//  HackerBooks
//
//  Created by KRONOX on 1/2/17.
//  Copyright © 2017 kronox. All rights reserved.
//

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
typealias tagArray          = [Tag]


// MARK: - Decoder
func decode(book json: JSONDictionary) throws -> Book{
    
    // Validamos el diccionario
    guard let urlString_image = json["image_url"] as? String,     // Convierto url en String comprobando error
        let url_image = URL(string:urlString_image)              // Convierto string en url
        // let image = UIImage(named: url_image.lastPathComponent)   // Capturo nombre del fichero imagen
        else{
            throw LibraryError.wrongURLFormatForJSONResource
    }
    
    guard let urlString_pdf = json["pdf_url"] as? String,         // Convierto url en String comprobando error
         let url_pdf = URL(string:urlString_pdf)                 // Convierto string en url
         // let pdf:String = url_pdf.lastPathComponent               // Capturo nombre del pdf
         else{
            throw LibraryError.wrongURLFormatForJSONResource
    }
    
    
    let autor 	= json["authors"] as? String
    let titulo  = json["title"] as? String
    
    if let tags = json["tags"] as? String{
        
        // Convierto string de tags separados con comas en array de String
        let array:Array = tags.components(separatedBy: ",")
    
        // Convierto array de String en array de Tag
        let arrayTag = convers(array)

        return Book(title: titulo!,
                    authors: autor!,
                    tags: arrayTag,
                    photo_url: url_image,
                    pdf_url: url_pdf)
        
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
        let tag = Tag (tag: each)
        arrayTag.append(tag)
    }
    return arrayTag
}



// MARK: - Loading

// Función que carga JSON de un fichero y devuelve un array de books
func loadFromLocalFile(fileName name: String,                   // Obtenemos diccionario con url del fichero
    bundle: Bundle = Bundle.main) throws -> JSONArray{
    
    // Validamos url del fichero con funcion "forResource" declarada en Framework que averigua ruta fichero
    if let url = bundle.url(forResource: name),
        let data = try? Data(contentsOf: url),                  // obtenemos datos
        let maybeArray = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONArray,
        let array = maybeArray {                                // JSONSerialization convierte JSON en diccionario
        return array
    }else{
        throw LibraryError.jsonParsingError
    }
}


    /// Carga JSON desde carpeta Documens de la Sandbox
/*
func loadFromLocalFile(fileName name: String,                   // Obtenemos diccionario con url del fichero
    bundle: Bundle = Bundle.main) throws -> JSONArray{
    
    
    if let url = bundle.url(forResource: name),                 // validamos url del fichero
        let data = try? Data(contentsOf: url),                      // obtenemos datos
        let maybeArray = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONArray,
        let array = maybeArray {                                // JSONSerialization convierte JSON en diccionario
        return array
    }else{
        throw StarWarsError.jsonParsingError
    }
}
 */
