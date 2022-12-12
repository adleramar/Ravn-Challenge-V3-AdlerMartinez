//
//  NetworkManager.swift
//  PokeApp
//
//  Created by Adler on 10/12/22.
//

import UIKit
import Reachability

class NetworkManager: NSObject {

        var reachability: Reachability!

        // Create a singleton instance
        static let sharedInstance: NetworkManager = { return NetworkManager() }()


        override init() {
            super.init()

            // Initialise reachability
            reachability = try? Reachability()

            // Register an observer for the network status
//            NotificationCenter.default.addObserver(
//                self,
//                selector: #selector(networkStatusChanged(_:)),
//                name: .reachabilityChanged,
//                object: reachability
//            )

            do {
                // Start the network status notifier
                try reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        }

//        @objc func networkStatusChanged(_ notification: Notification) {
//            // Do something globally here!
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let reachability = notification.object as! Reachability
//
//            if reachability.connection == .unavailable {
//
//            }
//        }

        static func stopNotifier() -> Void {
            do {
                // Stop the network status notifier
                try (NetworkManager.sharedInstance.reachability).startNotifier()
            } catch {
                print("Error stopping notifier")
            }
        }

        // Network is reachable
        static func isReachable(completed: @escaping (NetworkManager) -> Void) {
            if (NetworkManager.sharedInstance.reachability).connection != .unavailable {
                completed(NetworkManager.sharedInstance)
            }
        }

        // Network is unreachable
        static func isUnreachable(completed: @escaping (NetworkManager) -> Void) {
            if (NetworkManager.sharedInstance.reachability).connection == .unavailable {
                completed(NetworkManager.sharedInstance)
            }
        }

        // Network is reachable via WWAN/Cellular
        static func isReachableViaWWAN(completed: @escaping (NetworkManager) -> Void) {
            if (NetworkManager.sharedInstance.reachability).connection == .cellular {
                completed(NetworkManager.sharedInstance)
            }
        }

        // Network is reachable via WiFi
        static func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {
            if (NetworkManager.sharedInstance.reachability).connection == .wifi {
                completed(NetworkManager.sharedInstance)
            }
        }
    }
