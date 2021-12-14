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
    
    var mpep = swpep()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            mpep.getAllPeople(completionHandler: { [self]
                data, response, error in
                do{
                    if let jr = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let res = jr["count"] as? NSInteger {
                            self.mpep.co = res
                            print(self.mpep.co)
                            self.mpep.getpep(completionHandler: {
                                data, response, error in
                                do{
                                    if let jr = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                        if let res = jr as? NSDictionary {
                                            print("  " , res["name"])
                                            if(res["name"] != nil){
                                                self.pep.append(try res["name"] as! String)
                                                DispatchQueue.main.async {
                                                        self.table.reloadData()
                                                    }
                                            }else{self.mpep.co+=1}
                                        }
                                    }
                                }catch{
                                    print("Error \(error)")
                                }
                            })
                            
                        }
                    }
                }catch{
                    print("Error \(error)")
                }
            })
            
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
    

  

}

// MARK: - pepmodel
 
 class swpep{
     var pep = [String]()
     var co = 0
    func getAllPeople(completionHandler:@escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) -> [String] {
        
             let task = URLSession.shared.dataTask(with: URL(string: "https://swapi.dev/api/people/?format=json")!, completionHandler: completionHandler).resume()
         
         return pep
         }
     
     func getpep(completionHandler:@escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) -> [String] {
         
         for i in 1...co {
         URLSession.shared.dataTask(with: URL(string:"https://swapi.dev/api/people/\(i)?format=json")!, completionHandler: completionHandler).resume()
         }
         
         return pep
     }
     
     
     
 }
