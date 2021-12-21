//
//  Moviemodel.swift
//  Movie Quotes
//
//  Created by Safa Falaqi on 21/12/2021.
//

import Foundation


// MARK: - WelcomeElement
struct Movie: Codable {
    let place: Int
    let quote, movie: String
    let year: Int
    let image: String
}
