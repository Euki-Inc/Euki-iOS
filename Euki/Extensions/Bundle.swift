//
//  Bundle.swift
//  Euki
//
//  Created by Víctor Chávez on 10/08/22.
//  Copyright © 2022 Ibis. All rights reserved.
//

import UIKit

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
