//
//  APICaller.swift
//  Crypto Tracker
//
//  Created by Jervy Umandap on 8/20/21.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private struct Constants {
        static let apikey = "A769D294-9D2D-418F-A570-1888269B2E09"
        static let assetsEndpoint = "https://rest.coinapi.io/v1/assets/"
        static let iconsEndpoint = "https://rest.coinapi.io/v1/assets/icons/50/"
        
    }
    
    private init() {}
    
    public var icons: [Icon] = []
    
    private var whenReadyBlock: ((Result<[CryptoData], Error>) -> Void)?
    
    public func getAllCryptoData(completion: @escaping(Result<[CryptoData], Error>) -> Void) {
        
        guard !icons.isEmpty else {
            whenReadyBlock = completion
            return
        }
        
        guard let url = URL(string: Constants.assetsEndpoint + "?apikey=" + Constants.apikey) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                // decode response
                let cryptos = try JSONDecoder().decode([CryptoData].self, from: data)
                let sortedCryptos = cryptos.sorted { (first, second) -> Bool in
                    return first.price_usd ?? 0 > second.price_usd ?? 0
                }
                completion(.success(sortedCryptos))
//                print(sortedCryptos)
                
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    public func getAllIcons() {
        guard let url = URL(string: Constants.iconsEndpoint + "?apikey=" + Constants.apikey) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                // decode response
                self?.icons = try JSONDecoder().decode([Icon].self, from: data)
                if let completion = self?.whenReadyBlock {
                    self?.getAllCryptoData(completion: completion)
                }
                
            } catch {
                print(error)
//                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    
}

// https://rest.coinapi.io/v1/exchangerate/BTC/PHP?apikey=A769D294-9D2D-418F-A570-1888269B2E09
// https://rest.coinapi.io/v1/assets/?apikey=A769D294-9D2D-418F-A570-1888269B2E09
// https://rest.coinapi.io/v1/assets/icons/50/?apikey=A769D294-9D2D-418F-A570-1888269B2E09
