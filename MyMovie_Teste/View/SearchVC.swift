//
//  SearchVC.swift
//  MyMovie_Teste
//
//  Created by Fabio Makihara on 06/11/20.
//

import UIKit

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var filterMoviesTableView: UITableView!
    
    private let apiKey = "04086c212ff4d6f21382347b01ffdc69"
    private let baseUrl = "https://api.themoviedb.org/3/"
    
    private var moviesFilter:[Movie]?
  
    
    private func config() {
        self.filterMoviesTableView.delegate = self
        self.filterMoviesTableView.dataSource = self
        self.filterMoviesTableView.tableFooterView = UIView(frame: .zero)
        self.searchTextField.delegate = self
        self.filterMoviesTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.config()
       
    }
    

// MARK: func searchMovies()

    func searchMovies() {
        self.searchTextField.resignFirstResponder()
        
        guard let text = searchTextField.text, !text.isEmpty else {return}
        let query = text.replacingOccurrences(of: " ", with: "%20")
        URLSession.shared.dataTask(with: URL(string: "\(baseUrl)search/movie?api_key=\(apiKey)&query=\(query)&language=pt-BR")!, completionHandler: { [self] data, response, error in
            guard let data = data, error == nil else {return}
    
            // Convert data
            var results:Results?
            do {
                results = try JSONDecoder().decode(Results.self, from: data)
            }
            catch {
                print(error.localizedDescription)
            }
        
            // Update movie array
            self.moviesFilter = results?.results

            DispatchQueue.main.async {
                self.filterMoviesTableView.reloadData()
            }
        }) .resume()
    }
}


// MARK: extension UITexFiel

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchMovies()
        self.filterMoviesTableView.reloadData()
        return true
    }
}


// MARK: extension UITableView

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesFilter?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movie = moviesFilter?[indexPath.row]
        cell.setuptMovie(movie: cell.movie!)
        return cell
    }
    
        
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "MovieDetailVC", sender: moviesFilter?[indexPath.row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movie:Movie? = sender as? Movie
        let vc = segue.destination as? MovieDetailVC
        vc?.movie = movie
    }
}
