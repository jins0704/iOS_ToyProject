//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by 홍진석 on 2021/01/22.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation

struct Constants{
    static let loginsegue = "loginsegue"
    static let registersegue = "registersegue"
    static let title = "⚡️FlashChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    struct BrandColors{
        static let purple = "BrandPurple"
        static let lightpurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lightblue = "BrandLightBlue"
    }
    
    struct FStore{
        static let collectionName = "messages"
        static let sendField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
