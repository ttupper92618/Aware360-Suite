//
//  js_Bridge.swift
//  aware360 suite
//
//  Created by Thomas Tupper on 2/13/15.
//  Copyright (c) 2015 Thomas Tupper. All rights reserved.
//

import Foundation

public class jsBridge {
    let myView = ViewController()
    // --- GCD thread functionality ----
    
    func provideTrustedCredentials() {
        // login was successful - execute a credentialed login on the main thread
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0), { ()->() in
            dispatch_async(dispatch_get_main_queue(), {
                self.provideTrustedCredentialsGCD()
            })
        })
        
    }
    
    func clearTrustedCredentials() {
        // login was successful - execute a credentialed login on the main thread
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0), { ()->() in
            dispatch_async(dispatch_get_main_queue(), {
                self.clearTrustedCredentialsGCD()
            })
        })
        
    }
    
    
    func logInWithStoredCredentials() {
        // login was successful - execute a credentialed login on the main thread
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0), { ()->() in
            dispatch_async(dispatch_get_main_queue(), {
                self.logInWithStoredCredentialsGCD()
            })
        })
        
    }
    
    func showTouchSplash() {
        // login was successful - execute a credentialed login on the main thread
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0), { ()->() in
            dispatch_async(dispatch_get_main_queue(), {
                self.showTouchSplashGCD()
            })
        })
        
    }
    
    
    func hideTouchSplash() {
        // login was successful - execute a credentialed login on the main thread
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0), { ()->() in
            dispatch_async(dispatch_get_main_queue(), {
                self.hideTouchSplashGCD()
            })
        })
        
    }
    
    func tellAuthorized() {
        // login was successful - execute a credentialed login on the main thread
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0), { ()->() in
            dispatch_async(dispatch_get_main_queue(), {
                self.tellAuthorizedGCD()
            })
        })
        
    }
    
    
    // --- JS Bridge functionality ----
    
    func provideTrustedCredentialsGCD() {
        myView.webView?.stringByEvaluatingJavaScriptFromString("auiAuthenticate.recieveTrustedUID('ttupper@awarepoint.com')")
        myView.webView?.stringByEvaluatingJavaScriptFromString("auiAuthenticate.recieveTrustedPass('God1sFaithful!')")
        
    }
    
    func clearTrustedCredentialsGCD() {
        myView.webView?.stringByEvaluatingJavaScriptFromString("auiAuthenticate.recieveTrustedUID('')")
        myView.webView?.stringByEvaluatingJavaScriptFromString("auiAuthenticate.recieveTrustedPass('')")
        
    }
    
    func logInWithStoredCredentialsGCD() {
        myView.webView?.stringByEvaluatingJavaScriptFromString("auiAuthenticate.handleFingerprintAuth()")
        
    }
    
    func showTouchSplashGCD() {
        myView.webView?.stringByEvaluatingJavaScriptFromString("auiAuthenticate.showTouchSplash()")
        
    }
    
    func hideTouchSplashGCD() {
        myView.webView?.stringByEvaluatingJavaScriptFromString("auiAuthenticate.hideTouchSplash()")
        
    }
    
    func tellAuthorizedGCD() {
        myView.webView?.stringByEvaluatingJavaScriptFromString("auiAuthenticate.authTouchSplash()")
        
    }
    
    
}
