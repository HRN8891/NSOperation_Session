//
//  UserDetailModel.swift
//  EnrichMyGroup
//
//  Created by Hiren Patel on 14/05/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit

class UserModel {

    var userName: String = ""
    var email: String = ""
    var userId: Int = 0
    var dnnUserId: Int = 0
    var firstName: String = ""
    var portalId: Int = 0
    var displayName: String = ""
    var createdDt: String = ""
    var isAdministrator: Bool = false
    var isContentProvider: Bool  = false
    var isDeleted: Bool = false
    var isDeletedDt: Bool  = false
    var isDeletedUserId: Int  = 0
    var lastModifiedDt: String = ""
    var lastmodifiedById: Int  = 0
    var isActive: Bool  = false
    var isActiveDt: String = ""
    var isActiveUserId: Int  = 0
    var password: String = ""

    init() {

    }

}
