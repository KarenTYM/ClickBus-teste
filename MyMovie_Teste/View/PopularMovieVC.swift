//
//  PopularMovieVC.swift
//  MyMovie_Teste
//
//  Created by Fabio Makihara on 05/11/20.
//

import UIKit

class PopularMovieVC: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
 
    private var movies:[Movie]?
    private var page:Int = 1
    private var totalPages:Int = 0

    
    private func configTableView() {
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        self.movieTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }

    
    
    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetch()
        self.configTableView()
        
    }
    
    
    private func fetch(_ page:Int = 1) {
        API.fetchPopularMovies(page) {data in
            self.totalPages = data.totalPages ?? 1
            self.movies = data.results
            self.movieTableView.reloadData()
        }
    }
    
   
    
    
    private func loadMoreData(){
        if page < totalPages {
            page += 1
            OperationQueue.main.addOperation {
                API.fetchPopularMovies(self.page) { data in
                    self.movies? += data.results
                    self.movieTableView.reloadData()
                }
            }
        }
    }
}




// MARK: extension

extension PopularMovieVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movie = movies?[indexPath.row]
        cell.setuptMovie(movie: cell.movie!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let count = movies?.count else {fatalError()}
        if indexPath.row == count - 1 {
            self.loadMoreData() 
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "MovieDetailVC", sender: movies?[indexPath.row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movie:Movie? = sender as? Movie
        let vc = segue.destination as? MovieDetailVC
        vc?.movie = movie
    }
    
}



