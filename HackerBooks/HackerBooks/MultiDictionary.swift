import Foundation

//A [Multimap](https://en.wikipedia.org/wiki/Multimap) implementation for Swift.
//A MultiDictionary is a generalization of the Dictionary data type, where more
//than one object can be associated with a single key.
//
//public is used as this class might very well end in a separate framework


public
struct MultiDictionary<Key : Hashable, Value : Hashable>{
    
    //MARK: - Types
    public
    typealias Bucket = Set<Value>
    
    
    //MARK: - Properties
    private
    var _dict : [Key : Bucket]
    
    
    //MARK: - Lifecycle
    
    // Creates an empty multiDictionary
    public
    init(){
        _dict = Dictionary()
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
    var countUnique : Int {             /// TOTAL CUBOS = TOTAL LIBROS (sin repetir) POR TAG
        var tally = Bucket()
        
        for bucket in _dict.values{
            tally = tally.union(bucket) // UNION (set): une sin repetidos
        }
        
        return tally.count
    }
    
    public
    var count : Int{                    /// Nº CUBOS TOTALES (repetidos incluidos)
        
        var tally = 0
        for bucket in _dict.values{
            tally += bucket.count
        }
        return tally
    }
    
    
    public
    func countBucketsForValue(key: Key) -> Int{       /// Nº CUBOS POR CADA KEY
        return _dict[key]!.count
    }
    
    
    public
    var keys : LazyMapCollection<Dictionary<Key, Bucket>,Key> {
        return _dict.keys
    }
    
    public
    var buckets : LazyMapCollection<Dictionary<Key, Bucket>,Bucket> {
        return _dict.values
    }
    // Takes a key and returns an optional Bucket. If the key is not present,
    // returns .None.
    // The setter takes a Bucket and adds its contents to the existing Bucket
    // if any.
    public
    subscript(key: Key) ->Bucket?{
        get{                                    /// BUCKETS POR TAG O SECCIÓN
            return _dict[key]
        }
        
        set(maybeNewBucket){
            guard let newBucket = maybeNewBucket else{
                // Adding an empty optional is a NOP
                return
            }
            
            guard let previous = _dict[key] else{
                // if there was nothing for that kye, just the add the new bucket
                _dict[key] = newBucket
                return
            }
            
            // Otherwise create a union of old and new
            _dict[key] = previous.union(newBucket)
        }
    }
    
    // Hay que insertar valores en nuestro diccionario. Con el set normal no se puede
    // Con esta clave coge este libro
    // Toda función que cambie el estado (self) de la struct ha de llevar "mutating"

    // Inserts a value into an existing bucket, or creates a new bucket if
    // necessary.
    // If the value is already in the bucket, does nothing.
    // For a method to mutate a struct, it must be marked as 'mutating'
    public
    mutating func insert(value: Value, forKey key: Key){
        // Comprobamos si hay algo bajo esa clave y si no lo añado bajo nuevo bucket (Tag)
        if var previous = _dict[key] {          // si hay algo dentro de esa key (tag)
            previous.insert(value)              // inserto nuevo elemento (value)
            _dict[key] = previous               // metemos eso en un diccionario
        }else{                                  // Creo nueva key haciendo un set:
            _dict[key] = [value]                // por la declaracion de value, sabe q es un set
        }                                       // no un array (forma de hacer un set en Sets)
    }
    
    // Removes a value from an existing bucket. If the value or key isn't
    // there, it does nothing.
    // If after removing, the bucket is empty, it get's removed also
    public
    mutating func remove(value: Value, fromKey key: Key){
        
        guard var bucket = _dict[key] else{
            return
        }
        
        guard bucket.contains(value) else{
            return
        }
        
        bucket.remove(value)    // Since Set is a value type, a copy was made at this point!
        if bucket.isEmpty{
            _dict.removeValue(forKey: key)
        }else{
            _dict[key] = bucket // otherwise the bucket in dict is still unchanged!
        }
    }
}


