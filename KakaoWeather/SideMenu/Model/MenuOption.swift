//
//  MenuOption.swiftreturn #imageLiteral(resourceName: <#T##String#>)//  KakaoWeather
//
//  Created by Susan Kim on 03/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

enum MenuOption: Int, CaseIterable {
    case share
    case editLocations
    case currentLocation
    case settings
    case sendFeedback
    case rate
    
    var label: String {
        switch self {
        case .share:
            return "Share"
        case .editLocations:
            return "Edit Locations"
        case .currentLocation:
            return "Current Location"
        case .settings:
            return "Settings"
        case .sendFeedback:
            return "Send Feedback"
        case .rate:
            return "Rate This App"
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        default:
            return #imageLiteral(resourceName: "close")
        }
    }
}
