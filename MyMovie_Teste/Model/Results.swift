//
//  Results.swift
//  MyMovie_Teste
//
//  Created by Fabio Makihara on 05/11/20.
//

import Foundation

struct Results:Codable {
    let results:[Movie]
    let page:Int?
    let totalPages: Int?
    let totalResults: Int?
}



