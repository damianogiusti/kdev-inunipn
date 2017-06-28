//
//  NewsRestDatasource.swift
//  InUniPn
//
//  Created by Andrea Minato on 28/06/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsRestDatasource: RestCapable, DateFormatCapable {

    private let token: String

    init(withToken token: String) {
        self.token = token
    }

    func all() -> DataResponse<[News]> {

        let response = getRestCall(toUrl: Addresses.news.url(), withParams: nil, token: token)
        if let json = response.data {
            let news = self.parseNews(from: json)
            return DataResponse(withData: news)
        } else if let error = response.error {
            return DataResponse(withError: error)
        }
        return DataResponse(withError: RestError.apiError)
    }

    private func parseNews(from json: JSON) -> [News] {
        var newsList: [News] = []
        let page = json["page"].intValue
        let posts = json["data"].arrayValue
        for p in posts {
            let news = News(withId: p["_id"].stringValue)
            news.title = p["title"].stringValue
            news.content = p["content"].stringValue
            news.createdDate = dateFromString(isoTimestamp: p["pub_date"].stringValue)
            news.updatedDate = dateFromString(isoTimestamp: p["createdAt"].stringValue)
            news.page = page
            news.imageUrl = p["media"].stringValue
            news.link = p["link"].stringValue
            newsList.append(news)
        }
        return newsList
    }
}

/*
 
 {
     "page": 1,
     "data": [
         {
         "_id": "5953468b02849b4ae0ba50d5",
         "createdAt": "2017-06-28T06:02:51.423Z",
         "updatedAt": "2017-06-28T06:02:51.423Z",
         "slug": "ateneo-cambio-al-vertice-dellamministrazione",
         "status": "publish",
         "link": "http://www.unipordenone.it/ateneo-cambio-al-vertice-dellamministrazione/",
         "title": "Ateneo, cambio al vertice dell&#8217;amministrazione",
         "content": "Massimo Di Silverio, 55 anni, laureato in Scienze politiche, è il nuovo direttore generale dell&#8217;Ateneo friulano. L&#8217;incarico, di durata triennale e rinnovabile, è stato deliberato all&#8217;unanimità dal Consiglio di amministrazione dell&#8217;università di Udine, nella seduta del 18 dicembre, su proposta del rettore Alberto Felice De Toni, sentito il Senato accademico. &#8220;L&#8217;innovazione nasce dalla diversità &#8211; dichiara il rettore -. Mi auguro che l&#8217;esperienza maturata da Di Silverio nell&#8217;ambito del settore privato possa rappresentare un punto di forza nel percorso di miglioramento per il nostro Ateneo&#8221;.\nMassimo Di Silverio nel 1982 entra in Zanussi Italia spa dove ricopre incarichi di crescente responsabilità fino ad essere nominato nel 1993 direttore dei Servizi operativi. Nel 1996 è nel Gruppo Aprilia con l&#8217;incarico di direttore di Aprilia Consumer Service spa e nel 1999 diventa direttore operativo di Aprilia spa. Nel 2000 assume l&#8217;incarico di direttore generale di Moto Guzzi spa. Nel 2005 entra nel gruppo Piaggio prima con l&#8217;incarico di amministratore delegato di Derbi Nacional Motor in Spagna e poi, nel 2007, assume la responsabilità di direttore della Business Unit Ricambi, Accessori, Assistenza Tecnica e Licensing.\n&#8220;Per me un nuovo impegno, entusiasmante, di cui sento tutta la responsabilità &#8211; sottolinea il nuovo direttore -. Farò ogni sforzo, insieme ai nuovi colleghi dell&#8217;area tecnico-amministrativa, per contribuire a realizzare gli obiettivi di sviluppo che il Rettore, il Senato Accademico e il Consiglio di Amministrazione vorranno indicare per l&#8217;Università di Udine&#8221;. Il nuovo direttore entrerà in carica a partire da gennaio e subentrerà a Clara Coviello, al vertice dell&#8217;amministrazione dell&#8217;ateneo friulano da luglio 2011 e quindi protagonista della trasformazione della figura del direttore amministrativo a direttore generale, introdotta dalla riforma Gelmini, che definisce questo vertice dell&#8217;ateneo come un vero e proprio manager, con competenze non soltanto tecniche ma anche manageriali e relazionali, come la complessiva gestione e organizzazione dei servizi, delle risorse strumentali e del personale tecnico-amministrativo dell&#8217;ateneo.\n[via Qui.UniUd.it]\n",
         "excerpt": "Massimo Di Silverio, 55 anni, laureato in Scienze politiche, è il nuovo direttore generale dell&#8217;Ateneo [&hellip;]\n",
         "sticky": false,
         "media": "http://www.unipordenone.it/wp-content/uploads/2014/01/1075scheda.jpg",
         "pub_date": "2014-01-10T12:16:16",
         "__v": 0
         },
 
 */
