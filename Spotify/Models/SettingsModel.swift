//
//  SettingsModel.swift
//  Spotify
//
//  Created by Enes Sancar on 29.08.2023.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> ()
}
