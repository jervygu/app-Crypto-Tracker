//
//  CryptoData.swift
//  Crypto Tracker
//
//  Created by Jervy Umandap on 8/20/21.
//

import Foundation

struct CryptoData: Codable {
    let asset_id: String
    let name: String
//    let type_is_crypto: Int
//    let data_end: String
//    let data_quote_end: String
//    let data_trade_end: String
//    let data_symbols_count: Int
//    let volume_1hrs_usd: Double
//    let volume_1day_usd: Double
//    let volume_1mth_usd: Double
    let price_usd: Double?
    let id_icon: String?
}

struct Icon: Codable {
    let asset_id: String
    let url: String
}
