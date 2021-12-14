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
    override func viewDidLoad() {
        super.viewDidLoad()

        URLSession.shared.dataTask(with: URL(string: "https://swapi.dev/api/films/?format=json")! , completionHandler: {
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
                }).resume()
    
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
// MARK: - api
struct api: Codable {
    let results: [Film]
}

// MARK: - Result
struct Film : Codable {
    let title: String
    
}
