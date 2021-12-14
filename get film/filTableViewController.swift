//
//  filTableViewController.swift
//  get film
//
//  Created by faisal on 10/05/1443 AH.
//

import UIKit

class filTableViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    
    var fil = [String]()
    var mfil = film()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        mfil.getAllPeople(completionHandler: {
            data, response, error in
            do{
                let res = try JSONDecoder().decode(api.self, from: data!)
                print(res)
                for film in res.results{
                    print(film.title)
                    self.fil.append(film.title)
                }
                
                DispatchQueue.main.async {
                    self.table.reloadData()
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
        return fil.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tcell", for: indexPath)

        cell.textLabel?.text = fil[indexPath.row]
        
        return cell
    }
    
}
// MARK: - SWAPIFilmsResponse
struct api: Codable {
    let results: [Film]
}

// MARK: - Result
struct Film : Codable {
    let title: String
    
}
// MARK: - filmmodel
class film {
    func getAllPeople(completionHandler:@escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
            
        
            let task = URLSession.shared.dataTask(with: URL(string: "https://swapi.dev/api/films/?format=json")!, completionHandler: completionHandler).resume()
        }
    
}
