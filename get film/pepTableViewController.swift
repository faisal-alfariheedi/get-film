//
//  TableViewController.swift
//  get people
//
//  Created by faisal on 10/05/1443 AH.
//

import UIKit

class TableViewController: UITableViewController {

    var pep : [String] = []
        
    @IBOutlet var table: UITableView!
    
    
    var co=0
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            URLSession.shared.dataTask(with: URL(string:"https://swapi.dev/api/people/?format=json")!, completionHandler: {
                data, response, error in
                do{
                    if let jr = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let res = jr["count"] as? NSInteger {
                            self.co = res
                            self.getpep()
                        }
                    }
                }catch{
                    print("Error \(error)")
                }
            }).resume()
            
            
            
        
        }
    func getpep(){
        for i in 1...co {
        URLSession.shared.dataTask(with: URL(string:"https://swapi.dev/api/people/\(i)?format=json")!, completionHandler: {
            data, response, error in
            do{
                if let jr = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let res = jr as? NSDictionary {
                        print(i , "  " , res["name"])
                        if(res["name"] != nil){
                        self.pep.append(try res["name"] as! String)
                        }else{self.co+=1}
                    }
                }
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            }catch{
                print("Error \(error)")
            }
        }).resume()
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pep.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = pep[indexPath.row]

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
