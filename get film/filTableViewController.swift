//
//  filTableViewController.swift
//  get film
//
//  Created by faisal on 10/05/1443 AH.
//

import UIKit


class filTableViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    
    var fil = [Film]()
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
                    self.fil.append(film)
                }
                
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            }catch{
                print("Error \(error)")
            }
        
        })
    
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

        cell.textLabel?.text = fil[indexPath.row].title
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alert(mes: "Title: \(fil[indexPath.row].title)\nRelease_Date: \(fil[indexPath.row].Release_Date)\nDirector: \(fil[indexPath.row].Director)\nOpening_Crawl: \(fil[indexPath.row].Opening_Crawl)\n")
    }
    
}
// MARK: - api
struct api: Codable {
    let results: [Film]
    
}

// MARK: - Result
struct Film : Codable {
    let title: String
    let Release_Date: String
    let Director: String
    let Opening_Crawl: String
    
}
// MARK: - filmmodel
class film {
    func getAllPeople(completionHandler:@escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
            
        
            let task = URLSession.shared.dataTask(with: URL(string: "https://swapi.dev/api/films/?format=json")!, completionHandler: completionHandler).resume()
        }
    
}
