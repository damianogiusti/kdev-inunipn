//
//  NewsRepository.swift
//  InUniPn
//
//  Created by Andrea Minato on 26/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit

protocol NewsRepository: class {
    
    init(withToken token: String)
    
    func news(byId id: String) -> News?
    
    func all() -> [News]
    
    func save(news: News) -> Bool
    
    func delete(byId id: String) -> Bool
    
    
    
    
}
