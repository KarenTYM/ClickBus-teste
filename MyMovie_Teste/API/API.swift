//
//  API.swift
//  MyMovie_Teste
//
//  Created by Fabio Makihara on 05/11/20.
//

import Foundation
import Alamofire

private let baseUrl = "https://api.themoviedb.org/3/movie/"
let posterUrl = "https://image.tmdb.org/t/p/original"
let backdropUrl = "https://image.tmdb.org/t/p/w300"
private let apiKey = "04086c212ff4d6f21382347b01ffdc69"
private let coder = JSONDecoder()


class API {
    class func fetchPopularMovies(_ page:Int,  onSuccess: @escaping (Results) -> Void) {
        coder.keyDecodingStrategy = .convertFromSnakeCase
        let urlStr = "\(baseUrl)popular?api_key=\(apiKey)&language=pt-BR&page=\(page)"
        guard let url = URL(string: urlStr) else {fatalError("Unable to get url")}
        
        // método da classe Alamofire que pega uma url e traz uma resposta
        AF.request(url).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {fatalError("Unable to parse data from api")}
                guard let results = try? coder.decode(Results.self, from: data) else {fatalError("Unable to parse data in to JSon")}
                DispatchQueue.main.async {
                    onSuccess(results)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


