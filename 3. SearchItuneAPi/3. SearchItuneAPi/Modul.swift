//
//  Modul.swift
//  3. SearchItuneAPi
//
//  Created by Huy on 7/27/20.
//  Copyright © 2020 Huy. All rights reserved.
//

import Foundation
struct Result: Codable {
  let resultCount: Int
  let results:[Item]
}

struct Item: Codable {
  let trackId: Int?
  let trackName: String?
  let collectionName: String?
  let artworkUrl100: String?
  let trackPrice: Float?
  let previewUrl: String?
}
