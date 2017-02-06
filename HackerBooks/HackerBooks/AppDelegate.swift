//
//  AppDelegate.swift
//  HackerBooks
//
//  Created by KRONOX on 31/1/17.
//  Copyright © 2017 kronox. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Creamos una windows de verdad, no opcional
        window = UIWindow(frame: UIScreen.main.bounds)
    
        // Creamos instancia del modelo
        
        do{
        // Comprobamos si están los ficheros ya cargados de anteriormente. Dos opciones:
            // 1. OK. Guardo flag en NSUserDefaults (mira online), que indica si es la primera vez que arrancamos
            // 2. Comprobando la existencia del fichero en sí cuando arrancas
            
            // Comprobamos si ficheros guardados comprobando flag
            let defaults = UserDefaults.standard
            let filesLoaded = defaults.bool(forKey: "filesLoaded")
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

            // si json no guardado lo descargamos
            if (filesLoaded == false){
            try downloadJSONFiles(fromPath: url)
            }
            
            // cargamos json
            let json = try loadFromLocalFile(fileName: "books_readable", fromPath: url)
            
            // Creamos array de clases tipo Book decodificando json
            var books = [Book]()
            for each in json{
                do{
                    let book = try decode(book: each, fromPath: url)
                    books.append(book)
                }catch{
                    print("Error al procesar \(each)")
                }
                books.sort()        // Ordenamos array de books
            }
            

            
            // Creamos el modelo
            let model = Library(bookArray: books)
            
            // Creamos LibraryVC
            let lVC = LibraryTableViewController(model: model)
            
            // Creamos un Nav
            let lNav = UINavigationController(rootViewController: lVC)
            
            
            // Indicamos a la windows elemento root
            window?.rootViewController = lNav
            
            // Mostramos la window
            window?.makeKeyAndVisible()
            
            return true
            
            
        }catch{
            fatalError("Error while loading Model from JSON")
        }
        
        
        
        
        
        return true
    }

    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

// Utils

/*
func downloadJSONFiles() throws {
    
    do{
        
        // No están los ficheros cargados, los descargamos y los guardamos
        let url = URL(string: "https://t.co/K9ziV0z3SJ")
        let data = try? Data(contentsOf: url!)
        guard let json = data else{
            throw LibraryError.resourcePointedByURLNotReachable
        }
        
        // Guardamos el json descargado en un archivo
        
        // Path de Documents
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // url del fichero
        let url_file: URL = URL(fileURLWithPath: "books_readable.json", relativeTo: path)
        // Creamos fichero
        let fileManager = FileManager.default
        let created = fileManager.createFile(atPath: url_file.path, contents: json, attributes: nil)
        
        // Creamos flag indicador para indicar fichero cargado
        let flag: Bool = created
        let defaults = UserDefaults.standard
        defaults.set(flag, forKey: "filesLoaded")
        
        
    }catch{
        throw LibraryError.resourcePointedByURLNotReachable
    }
}

*/
