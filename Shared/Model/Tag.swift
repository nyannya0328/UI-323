//
//  Tag.swift
//  UI-323 (iOS)
//
//  Created by nyannyan0328 on 2021/10/08.
//

import SwiftUI

struct Tag: Identifiable,Hashable {
    var id = UUID().uuidString
    var text : String
    var size : CGFloat = 0
}

