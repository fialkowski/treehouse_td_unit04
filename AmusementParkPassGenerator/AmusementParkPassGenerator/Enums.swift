//
//  Enums.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-04-10.
//  Copyright © 2019 nikko444. All rights reserved.
//

enum RideAdmission: String {
    case general
    case vip
}

enum Area: String, CaseIterable {
    case amusement
    case kitchen
    case rideControl
    case maintenance
    case office
}

enum Good: String {
    case food
    case mercandise
}

enum PaymentTerms: String, CaseIterable {
    case hourly
    case payroll
}

enum Department: String, CaseIterable {
    case foodServices
    case rideServices
    case parkMaintenance
    case office
}
