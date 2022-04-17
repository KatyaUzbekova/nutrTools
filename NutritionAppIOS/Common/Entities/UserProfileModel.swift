//
//  UserProfileModel.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 06.04.2021.
//

import Foundation


struct UserProfileModelRegistration: Decodable {
    let body: UserProfileModel?
    let message: String?
}

struct UserProfileModelLogin: Decodable {
    let body: UserProfileModel?
}

struct UserProfileModel: Decodable {
    let id: Int
    let email: String
    let token: String
    let name: String
    let coins: Int
    let regDate: String
    let lastOnline: String
    let avatarUrl: String?
    let birthDate: String
    let transformationExpires: String?
    let cabinetExpires: String?
    let emailApproved: Bool
    let accountApproved: Bool
    let male: Bool
}
