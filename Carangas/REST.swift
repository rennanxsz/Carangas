//
//  REST.swift
//  Carangas
//
//  Created by Rennan Bruno on 11/03/22.
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import Foundation

class REST {
    
    private static let basePath = "https://carangas.herokuapp.com/cars"
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        //Liberando ou negando que o usuario use o 4g ou 3g
        config.allowsCellularAccess = false //true
        //Informando o tipo de requisição, neste caso foi feito uma requisição de um Json
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        //Configuranto o tempo que o usuario vai aguardar
        config.timeoutIntervalForRequest = 30.0
        //Configurando o maximo de requisições
        config.httpMaximumConnectionsPerHost = 5
        
        return config
    }()
    
    //Sessão criada manualmente.
    private static let session = URLSession(configuration: configuration) //URLSession.shared
    
    
    
}
