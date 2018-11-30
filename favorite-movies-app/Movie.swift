//
//  Movie.swift
//  favorite-movies-app
//
//  Created by John Rigsby on 11/29/18.
//  Copyright © 2018 TCR Development, LLC. All rights reserved.
//

import Foundation

class Movie{
    var id: String = ""
    var title: String = ""
    var year: String = ""
    var imageUrl: String = ""
    var plot: String = ""
    
    init(id: String, title: String, year: String, imageUrl: String, plot: String = ""){
        self.id = id
        self.title = title
        self.year = year
        self.imageUrl = imageUrl
        self.plot = plot
    }
}
