//
//  LibraryTableViewController.swift
//  HackerBooks
//
//  Created by KRONOX on 3/2/17.
//  Copyright © 2017 kronox. All rights reserved.
//

import UIKit
import Foundation

class LibraryTableViewController: UITableViewController {
    
    // MARK: - Constants
    
    
    // MARK: - Properties
    let model : Library
    
    
    // MARK: - Inizialization
    init(model: Library){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return model.tagCount
        
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.bookCount(forTagName: getNumberTag(forSection: section))
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForFooterInSection section: Int) -> String? {
        
        return model.tags[section].name
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                            // indexPath tiene 2 secciones: Section y Row
        
        // Definir un Id para el tipo de celda (para pedir celda reutilizada)
        let cellId = "BookCell"
        
        // Averiguar el Tag
        let tag = getNumberTag(forSection: indexPath.section)
        
        // Averiguar el libro
        let book = model.book(forTagName: tag, at: indexPath.row)

        // Crear la celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil{
            // Creamos nueva celda
            cell = UITableViewCell(style: .subtitle,
                                   reuseIdentifier: cellId)
        }
        

        // Configurarla
        cell?.imageView?.image        =   UIImage(named: (book?.urlImage.lastPathComponent)!)
        cell?.textLabel?.text         =   book?.titulo
        cell?.detailTextLabel?.text   =   tagArraytoString(fromArrayTags: (book?.tags)!)
        
        // Devolverla
        return cell!
    }
    
    
    
    // MARK: - Utils
    
    // Función para obtener sección partiendo de nº sección
    // El número de cada tag será su número de posición en el array
    // Seccion x devuelvo Tag[x]
    func getNumberTag(forSection section: Int) -> String{

        return model.tags[section].name
    }
    
    // Función para convetir array de Tag en string
    func tagArraytoString(fromArrayTags arraytags: [Tag]) -> String{
        
        var array : [String] = []
        for elem in arraytags{
            array.append(elem.name)
        }
        return array.joined(separator: ",")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
