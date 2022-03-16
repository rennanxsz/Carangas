//
//  REST.swift
//  Carangas
//
//  Created by Rennan Bruno on 11/03/22.
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import Foundation

enum CarError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

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
    
    class func loadCars(onComplete: @escaping ([Car]) -> Void, onError: @escaping (CarError) -> Void) {
        guard let url = URL(string: basePath) else {
            onError(.url)
            return
            
        }
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error == nil {
                
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                    
                }
                if response.statusCode == 200 {
                    
                    guard let data = data else {return}
                    do {
                        let cars = try JSONDecoder().decode([Car].self, from: data)
                        onComplete(cars)
                    } catch {
                        print(error.localizedDescription)
                        onError(.invalidJSON)
                    }
                    
                } else {
                    print("Algum status inválido pelo servidor!!")
                    onError(.responseStatusCode(code: response.statusCode))
                }
                
            } else {
                onError(.taskError(error: error!))
            }            
        }
        dataTask.resume()
    }
    
    class func save(car: Car, onComplete: @escaping (Bool) -> Void) {
        guard let url = URL(string: basePath) else {
            onComplete(false)
            return
        }
        
        var resquest = URLRequest(url: url)
        resquest.httpMethod = "POST"
        
        guard let json = try? JSONEncoder().encode(car) else {
            onComplete(false)
            return
        }
        resquest.httpBody = json
        
        
        let dataTask = session.dataTask(with: resquest) { (data, response, error) in
            if error == nil {
                
            } else {
                onComplete(false)
            }
        }
    }
    
}
