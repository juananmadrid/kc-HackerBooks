//
//  Library.swift
//  HackerBooks
//
//  Created by KRONOX on 31/1/17.
//  Copyright © 2017 kronox. All rights reserved.
//

import Foundation
import UIKit

//: # MULTIDICTIONARY BASED STRUCTURE

public
struct Library<Tag: Hashable, Value: Hashable>{

    // MARK: - Types
    public
    typealias Bucket = Set<Value>
    typealias Books = [Book]
    // var tags = [Tag]
    
    // MARK: - Properties
    
    private
    var _dict : [Tag : Bucket]          // Bucket: cubo de libros
    
    
    // MARCK: - Initialization
    init(booksArray books: Books){
        
        _dict = Dictionary()            // Creamos diccionario vacío
        
        // Recorremos el array de books asignamos libro a cada Tags
        // para cada libro, para cada tags hago un set con [tat] = book.title

        for each in books{          // Para cada libro
            
            // let array = each.tags
            
            for tag in each.tags{   // Para cada tag
                
                guard let previous = _dict[tag] else{   // si tag existe no entro
                    _dict[tag] = Bucket()               // si tag no existe lo creo con un tag vacío
                    return
                }
                 _dict[tag] = previous.union(each.titulo)
            }
        }
    }
    
    
    // MARK: - Accessors (Getters)
    public
    var isEmpty: Bool {                 /// _dict VACÍO? (para compr. nil)
        return _dict.isEmpty
    }
    
    public
    var countBuckets : Int{             /// Nº TAGs (CUBOS) = Nº SECCIONES = Nº KEYS
        return _dict.count
    }
    
    public
    var count : Int{                    /// Nº CUBOS TOTALES (repetidos incluidos)
        
        var total = 0
        for bucket in _dict.values{
            total += bucket.count
        }
        return total
    }
    
    public
    var countUnique : Int{              /// TOTAL CUBOS = TOTAL LIBROS (sin repetir)
        var total = Bucket()
        for bucket in _dict.values{
            total = total.union(bucket) // UNION (set): une sin repetidos
        }
        return total.count
    }
    
    // MARK: - Mutators (Setters)
    //
    public
    subscript(tag: Tag) -> Bucket?{
        get{                            /// NOS DA LOS CUBOS DE CADA TAG O SECCIÓN
            return _dict[tag]
        }
        set(maybeNewBucket){                            // QUIZAS UN NUEVO libro (maybeNewBucket)
            guard let newBucket = maybeNewBucket else{  // Compr. q maybeNewBucket no es nil
                
                return                                  // añadir nada es no añadir, salimos y ya
            }
            guard let previous = _dict[tag] else {
                // Si no existía el backet creamos un nuevo añadiendo un tag (bucket) vacío
                _dict[tag] = Bucket()
                return
            }
            
            _dict[tag] = previous.union(newBucket)      // Creamos una unión de lo viejo y lo nuevo
        }
    }
    
    
    // Hay que insertar valores en nuestro diccionario. Con el set normal no se puede
    // Con esta clave coge este libro
    // Toda función que cambie el estado (self) de la struct ha de llevar "mutating"
    
    public
    mutating func insert(value: Value, forkey tag: Tag){    /// INSERTO LIBRO CON CLAVE X
        
        // Comprobamos si hay algo bajo esa clave y si no lo añado bajo nuevo bucket (Tag)
        if var previous = _dict[tag]{       // si hay algo dentro de esa key (tag)
            previous.insert(value)          // inserto nuevo elemento (value)
            _dict[tag] = previous           // metemos eso en un diccionario
        } else {                            // Creo nueva key haciendo un set:
            _dict[tag] = [value]            // por la declaracion de value, sabe q es un set
        }                                   // no un array (forma de hacer un set en Sets)
    }
    
}



// MARK: - Proxies
    


// MARK: - Protocols

