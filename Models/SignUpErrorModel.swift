//
//  SignUpErrorModel.swift
//  SignUpSwiftUI
//
//  Created by Frank Bara on 1/27/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import Foundation

struct SignUpErrorModel: Codable {
    let validationErrors: ValidationErrors
    
    enum CodingKeys: String, CodingKey {
        case validationErrors = "validation_errors"
    }
}

struct ValidationErrors: Codable {
    let name, email, password: [String]?
}
