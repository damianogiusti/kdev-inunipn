//
//  NewsRepository.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

protocol NewsRepository: class {
    
    func news(byId id: String) -> News?
    
    func save(news: News) -> Bool
    
    func saveAll(newsList: [News]) -> Bool
    
    func delete(byId id: String) -> Bool
    
    func all() -> [News]


}
