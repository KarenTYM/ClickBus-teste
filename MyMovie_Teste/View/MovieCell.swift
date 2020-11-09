//
//  MovieCell.swift
//  MyMovie_Teste
//
//  Created by Fabio Makihara on 05/11/20.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    
    var movie:Movie? {
        didSet {
            if let movie = movie {
                movieImageView.kf.setImage(with: "\(movie.posterPath ?? "")".url)
            }
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setuptMovie(movie:Movie) {
        self.movieImageView.image = UIImage(named: "\(movie.posterPath ?? "")")
        self.titleLabel.text = movie.title
        self.voteCountLabel.text = String(movie.voteCount ?? 0)
        self.voteAverageLabel.text = String(movie.voteAverage ?? 0)
    }
    
}


extension String {
    var url: URL? {
        return URL(string:"\(posterUrl)\(self)")
    }
}
