//
//  SearchViewController.swift
//  favorite-movies-app
//
//  Created by John Rigsby on 11/29/18.
//  Copyright © 2018 TCR Development, LLC. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var searchResults: [Movie] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search Results"
    }
    weak var delegate: ViewController!
    @IBOutlet var searchText: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBAction func search (sender: UIButton){
        print("Searching for \(self.searchText.text!)")
        
        var searchTerm = searchText.text!
        if searchTerm.characters.count > 2 {
            retrieveMoviesByTerm(searchTerm: searchTerm)
        }
    }
    @IBAction func addFav(sender: UIButton) {
        print("Selected \(sender.tag)")
        self.delegate.favoriteMovies.append(searchResults[sender.tag])
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // grouped vertical sections of the tableview
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // at init/appear ... this runs for each visible cell that needs to render
        let moviecell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! CustomTableViewCell
        
        let idx: Int = indexPath.row
        moviecell.favButton.tag = idx
        
        //title
        moviecell.movieTitle?.text = searchResults[idx].title
        //year
        moviecell.movieYear?.text = searchResults[idx].year
        // image
        displayMovieImage(idx, moviecell: moviecell)
        
        return moviecell
    }
    
    func displayMovieImage(_ row: Int, moviecell: CustomTableViewCell) {
        let url: String = (URL(string: searchResults[row].imageUrl)?.absoluteString)!
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                let image = UIImage(data: data!)
                moviecell.movieImageView?.image = image
            })
        }).resume()
    }
    func retrieveMoviesByTerm(searchTerm: String) {
        let url = "https://www.omdbapi.com/?apikey=2a701db4&s=\(searchTerm)&type=movie&r=json"
        HTTPHandler.getJson(urlString: url, completionHandler: parseDataIntoMovies)
    }
    
    func parseDataIntoMovies(data: Data?) -> Void {
        if let data = data {
            let object = JSONParser.parse(data: data)
            if let object = object {
                self.searchResults = MovieDataProcessor.mapJsonToMovies(object: object, moviesKey: "Search")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
