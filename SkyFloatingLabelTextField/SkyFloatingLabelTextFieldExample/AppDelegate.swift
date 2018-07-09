//  Copyright 201-2017 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); 
//  you may not use this file except in compliance with the License. 
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the 
//  License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
//  either express or implied. See the License for the specific language governing permissions 
//  and limitations under the License.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // MARK: - Appearance

        if #available(iOS 9.0, *) {

            // Apply styles for text fields contained in AppearanceViewController
            let styles = SkyFloatingLabelTextField.appearance(
                whenContainedInInstancesOf: [AppearanceViewController.self]
            )

            // Text-, placeholder- and tintcolor
            styles.textColor          = .brown
            styles.tintColor          = .brown
            styles.placeholderColor   = .darkGray
            styles.selectedTitleColor = .orange
            styles.errorColor         = .purple

            // Fonts
            #if swift(>=4.0)
                styles.font               = .systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 1.0))
                styles.placeholderFont    = .systemFont(ofSize: 14, weight: UIFont.Weight(0.1))
            #else
                styles.font               = .systemFont(ofSize: 14, weight: 1.0)
                styles.placeholderFont    = .systemFont(ofSize: 14, weight: 0.1)
            #endif

            // Line
            styles.lineHeight = 2
            styles.lineColor          = .brown

            // Selected line
            styles.selectedLineHeight = 3
            styles.selectedLineColor  = .orange
        }

        // MARK: - Icon appearance

        if #available(iOS 9.0, *) {

            // Apply icon styles
            let iconStyles = SkyFloatingLabelTextFieldWithIcon.appearance(
                whenContainedInInstancesOf: [AppearanceViewController.self]
            )

            // Icon colors
            iconStyles.iconColor          = .brown
            iconStyles.selectedIconColor  = .orange

            // Icon font
            iconStyles.iconFont = UIFont(name: "FontAwesome", size: 15)

            // Icon margins
            iconStyles.iconMarginLeft = 5
            iconStyles.iconMarginBottom = 5
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }

}

/// Swift < 4.2 support
#if !(swift(>=4.2))
extension UIApplication {
    typealias LaunchOptionsKey = UIApplicationLaunchOptionsKey
}
#endif
