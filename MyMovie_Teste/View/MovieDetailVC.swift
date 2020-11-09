//
//  MovieDetailVC.swift
//  MyMovie_Teste
//
//  Created by Fabio Makihara on 05/11/20.
//

import UIKit
import Kingfisher

class MovieDetailVC: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var realiseDateLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    var movie:Movie?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overviewTextView.delegate = self
        
        self.backdropImageView.image = UIImage(named: "\(movie?.posterPath ?? "")")
        self.titleLabel.text = self.movie?.title
        self.realiseDateLabel.text = self.movie?.releaseDate
        self.voteCountLabel.text = String(self.movie?.voteCount ?? 0)
        self.voteAverageLabel.text = String(self.movie?.voteAverage ?? 0)
        self.overviewTextView.text = self.movie?.overview
        self.runTimeLabel.text = String(self.movie?.budget ?? 0)
    }
    
    
}


extension MovieDetailVC: UITextViewDelegate {
}
