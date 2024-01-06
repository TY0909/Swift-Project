//
//  FileManager-DocumentDirectory.swift
//  BucketList
//
//  Created by M Sapphire on 2024/1/5.
//

import Foundation

extension FileManager {
    static var documentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
