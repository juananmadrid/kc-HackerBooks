//
//  Library.swift
//  HackerBooks
//
//  Created by KRONOX on 3/2/17.
//  Copyright © 2017 kronox. All rights reserved.
//

import Foundation
import UIKit

class Library{
    
    // MARK: Utility types
    typealias BooksArray = [Book]
    
    // MARK: - Properties
    var books 	: [Book]                // Array de libros
    var tags    : [Tag]                // Array de Tags (sin repetir)
    var mdict   : MultiDictionary<String, String>

    
    // MARK: - Initialization
    init(bookArray array: BooksArray){
        
        books 	= 	[]
        tags    = 	[]
        mdict 	= 	MultiDictionary<String, String>()

        for book in array{
            
            // Asigno a books
            books.append(book)
            
            // Asigno a tags
            for element in book.tags{
                tags.append(element)
            }
            
            // Asigno a mdict
                for tag in book.tags{
                    
                    var bucket = Set<String>()      // creo set vacío
                    bucket.insert(book.titulo)      // inserto titulo del libro
                    mdict[tag.name] = bucket        //
                }
            
            /// Ordenamos los libros dentro de cada tag........?????????????

        }
    }

    
    // MARK: - Accesors
    
    
    // Nº Total de libros
    var booksCount: Int{
        get{
            let count: Int = self.books.count
            return count
        }
    }


    
    // Cantidad de libros por tag. Si no existe el tag devolvemos 0
    func bookCount(forTagName name: String) -> Int{

        // si existe esa clave
        if mdict[name] != nil {
             return mdict[name]!.count
        }else{
            return 0
        }

    }
    
    
    // Array de libros (instancias de Book) que hay por Tag.
    // Un libro puede estar en varios Tags. Si no hay libros en un Tag devolvemos nil
    func books(forTagName name: String) -> [Book]?{
        
        // comprobamos que existe tag
        if mdict[name] != nil {

            // comprobamos que no está vació el tag
            if mdict[name]?.count != nil{
                
                // convertimos lista en array y ordenamos
                var arrayNames : [String] = []       // Creo array vació de nombres de libros
                var arrayBooks : [Book] = []         // Creo array vacío de libros
                
                for element in mdict[name]! {
                    arrayNames.append(element)
                }
                arrayNames.sort()                    /// Ordeno lista de libros
                
                // convierto array de nombres de libros en array de libros
                for each in books{
                    // var book = books[each]
                    for name in arrayNames{
                        if each.titulo == name{
                            arrayBooks.append(each)
                        }
                    }
                }
                return arrayBooks
                
            }else{
                return nil
            }
        }else{
            return nil
        }
   
    }
    
    
    // AGTBook para el libro que está en la posición index de aquellos bajo un cierto tag
    // Devuelve libro que está en posición index
    // Si el index no existe o el tag no existe, devolvemos nil
    func book(forTagName name: String, at:Int?) -> Book?{
        
        // Comprobamos que existe index
        if let index = at {
                
            let booksTag = books(forTagName: name)  // Objengo array de libros en ese Tag
            let book = booksTag?[index]
            return book
            
        }else{
            return nil
        }


    
    
    var isEmpty: Bool {
        return mdict.isEmpty
    }
    
    var countTags: Int {                    // Nº total de TAGS
        return mdict.count
    }
    
    var countBooks: Int {                   // Nº Total de LIBROS (sin repetir)
        return mdict.countUnique
    }
    
    var countCubos: Int{                    // Nº Total de LIBROS q aparecen (con repetidos)
        return mdict.count
    }
    

    
}
}

