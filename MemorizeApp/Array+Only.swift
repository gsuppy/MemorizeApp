//
//  Array+Only.swift
//  MemorizeApp
//
//  Created by Kevin Kim on 8/27/20.
//  Copyright © 2020 Kevin Kim. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first: nil
    }
}
