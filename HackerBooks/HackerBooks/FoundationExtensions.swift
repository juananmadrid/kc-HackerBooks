import Foundation


// Añadimos función a Bundle que acepta el nombre completo y se encarga de partirlo (nombre + ext) 
// y devolvernos el recurso
extension Bundle{
    
    func url(forResource name: String) -> URL?{
        
        // Partir el nombre por el .
        let tokens = name.components(separatedBy: ".")
        
        
        // Si sale bien, crear la url
        return url(forResource: tokens[0], withExtension: tokens[1])
        
    }
}
