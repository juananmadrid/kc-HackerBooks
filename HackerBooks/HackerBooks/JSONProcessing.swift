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
typealias tagArray          =   [Tag]


// MARK: - Decoder
func decode(book json: JSONDictionary) throws -> Book{

//    let defaults = UserDefaults.standard
//    let pathPdf = defaults.string(forKey: "pathPdf")
    
//    let path = URL(fileURLWithPath: pathPdf!)

    // Validamos el diccionario
    guard let urlString_image = json["image_url"] as? String,     // Convierto url en String comprobando error
        let url_image = URL(string:urlString_image),            // Convierto string en url
        let image = UIImage(named: url_image.lastPathComponent)
        // let path_ = path.appendingPathComponent(imageName)
        else{
            throw LibraryError.wrongURLFormatForJSONResource
    }
    
    
    guard let urlString_pdf = json["pdf_url"] as? String,         // Convierto url en String comprobando error
         let url_pdf = URL(string:urlString_pdf)                  // Convierto string en url
         // let pdf:String = url_pdf.lastPathComponent            // Capturo nombre del pdf
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
                    photo: image,
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

// Función que carga JSON e imagenes y devuelve un array de books
func downloadJSONFiles() throws {
    
    // Obtenemos path de Documents
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let pathString = path.absoluteString
    
    // Guardamos path obtenido en UserDefaults, aquí guardaremos pdf
    let defaults = UserDefaults.standard
    defaults.set(pathString, forKey: "pathPdf")
    
    do{
        
        // No están los ficheros cargados, los descargamos y los guardamos
        let url = URL(string: "https://t.co/K9ziV0z3SJ")
        let data = try? Data(contentsOf: url!)
        guard let json = data else{
            throw LibraryError.resourcePointedByURLNotReachable
        }
        
        
        // Guardamos el json descargado en un archivo

        // url del fichero
        let url_file: URL = URL(fileURLWithPath: "books_readable.json", relativeTo: path)
        // Creamos fichero
        let fileManager = FileManager.default
        let created = fileManager.createFile(atPath: url_file.path, contents: json, attributes: nil)
        
        // Creamos flag indicador para indicar fichero cargado
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "PDFDownloadedYet")
        
    }catch{
        throw LibraryError.resourcePointedByURLNotReachable
    }
}


func loadFromLocalFile(fileName name: String) throws -> JSONArray{
    
    let defaults = UserDefaults.standard
    let pathPdf = defaults.string(forKey: "pathPdf")

    // let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let path = URL(fileURLWithPath: pathPdf!)
    // let pathDoc = path.absoluteString
    let urljson = path.appendingPathComponent("books_readable.json")
    // let url = URL(fileURLWithPath: pathDoc)
    if let data = try? Data(contentsOf: urljson),           // obtenemos Json
        let maybeArray = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONArray,               // Convertimos en Array de Json
        let jsonArray = maybeArray {

      
        return jsonArray
        
    }else{
        throw LibraryError.jsonParsingError
    }
}

