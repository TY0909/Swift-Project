//
//  Bundle-Decodable.swift
//  SnowFeak
//
//  Created by M Sapphire on 2024/2/1.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) ->T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate the \(file) in the bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed to load \(file) from the bundle")
        }
        
        guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("failed to decode \(file) from the bundle")
        }
        
        return decoded
    }
}
