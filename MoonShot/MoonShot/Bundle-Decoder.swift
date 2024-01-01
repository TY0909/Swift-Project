//
//  Bundle-Decoder.swift
//  MoonShot
//
//  Created by M Sapphire on 2023/11/29.
//

import Foundation

extension Bundle {
    func decode<T:Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to find the \(file)")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to loaded the \(file)")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let result = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode the \(file)")
        }
        
        return result
    }
}
