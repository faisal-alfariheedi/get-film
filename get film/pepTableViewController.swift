//
//  TableViewController.swift
//  get people
//
//  Created by faisal on 10/05/1443 AH.
//

import UIKit

class TableViewController: UITableViewController {

    var pep : [Pep] = []
        
    @IBOutlet var table: UITableView!
    
    var mpep = swpep()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            mpep.getAllPeople(completionHandler: { [self]
                data, response, error in
                do{
                    if let jr = try JSONSerialization.jsonObject(with: data! , options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let res = jr["count"] as? NSInteger {
                            self.mpep.co = res
                            print(self.mpep.co)
                            self.mpep.getpep(completionHandler: {
                                data, response, error in
                                do{
//                                    do {
////                                        print(response)
//                                        pep.append(try JSONDecoder().decode(Pep.self, from: data!))
//
//                                    } catch {
//                                        print("Failed to decode JSON \(error)")
//                                    }
                                    if let jr = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                        if let res = jr as? NSDictionary {
                                            print("  " , res["name"])
                                            if(res["name"] != nil){
                                                self.pep.append(try Pep(name: res["name"] as! String, gender: res["gender"] as! String, birth_year: res["birth_year"] as! String, mass: res["mass"] as! String))
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

        cell.textLabel?.text = pep[indexPath.row].name

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alert(mes: "name: \(pep[indexPath.row].name)\ngender: \(pep[indexPath.row].gender)\nbirth year: \(pep[indexPath.row].birth_year)\nmass: \(pep[indexPath.row].mass)\n")
    }
    
    func alert(mes :String) {
        let alert = UIAlertController(title: "detail", message: mes, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { [self] action in
            switch action.style{
                case .cancel:
                    break
                    
                 default:
                    print("")
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    

  

}
// MARK: - api
struct pepapi: Codable {
    let results: [Pep]
    
}

// MARK: - Result
struct Pep : Codable {
    let name: String
    let gender: String
    let birth_year: String
    let mass: String
    
    
    
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
