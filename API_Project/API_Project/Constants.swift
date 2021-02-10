//
//  Constants.swift
//  API_Project
//
//  Created by 홍진석 on 2021/02/09.
//

import Foundation

enum SEGUE_ID{
    static let USER_LIST_VC = "user"
    static let PHOTO_COLLECTION_VC = "photo"
}

enum API{
    static let BASE_URL = "https://api.unsplash.com/"
    static let CLIENT_ID = ""
}

enum NOTIFICATION {
    enum API{
        static let AUTH_FAIL = "autification_fail"
    }
}
