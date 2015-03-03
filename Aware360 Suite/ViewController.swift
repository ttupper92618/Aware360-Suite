//
//  ViewController.swift
//  Aware360 Suite
//
//  Created by Tom Tupper on 2/10/15.
//  Copyright (c) 2015 Tom Tupper. All rights reserved.
//

import UIKit
import LocalAuthentication
import WebKit

public class ViewController: UIViewController {
@IBOutlet weak var webView: UIWebView!
@IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var doAuth = true;
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // center activity spinner
        activityIndicatorView.center = self.view.center
    
        // load the a360 app page
        loadAddress()
        
    }
    
    func loadAddress() {
        // append the userAgent and ensure it contains our browser detect regEx
        let userAgent = UIWebView().stringByEvaluatingJavaScriptFromString("navigator.userAgent")! + " iPad"
        NSUserDefaults.standardUserDefaults().registerDefaults(["UserAgent" : userAgent])
        
        // set up URL
        let urlPath = "http://ucsf.aware360aui.dev.awarepoint.com"
        let url: NSURL = NSURL(string: urlPath)!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
        
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    func webViewDidStartLoad(_ : UIWebView) {
        // respond to the view starting load
        activityIndicatorView.center = self.view.center
        activityIndicatorView.startAnimating()
        
    }
    
    func webViewDidFinishLoad(_ : UIWebView) {
        // respond to the view finishing load
        activityIndicatorView.stopAnimating()
        var authenticated = false;
        if doAuth { authenticateUser() }
        
    }
    
    func webView(_ : UIWebView, didFailLoadWithError error: NSError) {
        // handle a load failure
        NSLog("failed load")
        NSLog(error.localizedDescription)
       
        
    }
    
    /*func webView(_: UIWebView!, shouldStartLoadWithRequest request: NSURLRequest!, navigationType: UIWebViewNavigationType) -> Bool {
        activityIndicatorView.center = self.view.center
        
        // log the URL
        NSLog(request.description)
        NSLog(navigationType.rawValue.description)
        
        // if our request is for JS execution, do that here
        /*if (navigationType.rawValue.description == "5") {
            return true
            
        } else {
            return false
            
        }*/
        
        return true
        
    }*/
    
    func authenticateUser() {
        // Get the local authentication context.
        let context = LAContext()
        
        // Declare a NSError variable.
        var error: NSError?
        
        // Set the reason string that will appear on the authentication alert.
        var reasonString = "Authentication is needed to access aware360Suite."
        
        // Check if the device can evaluate the policy.
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            // we have touch ID, so prepare the UI for using it
            self.showTouchSplash()
            self.provideTrustedCredentials()
            
            [context .evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success: Bool, evalPolicyError: NSError?) -> Void in
                
                if success {
                    self.doAuth = false
                    self.logInWithStoredCredentials()
                    self.tellAuthorized()
 
                }
                else{
                    // If authentication failed then show a message to the console with a short description.
                    // In case that the error is a user fallback, then show the password alert view.
                    println(evalPolicyError?.localizedDescription)
                    
                    switch evalPolicyError!.code {
                        
                    case LAError.SystemCancel.rawValue:
                        self.doAuth = false;
                        self.clearTrustedCredentials()
                        self.hideTouchSplash()
                        
                    case LAError.UserCancel.rawValue:
                        self.doAuth = false;
                        self.clearTrustedCredentials()
                        self.hideTouchSplash()
                        
                    case LAError.UserFallback.rawValue:
                        self.doAuth = false;
                        self.clearTrustedCredentials()
                        self.hideTouchSplash()
                        
                    default:
                        self.doAuth = false;
                        self.clearTrustedCredentials()
                        self.hideTouchSplash()
                        
                    }
                }
                
            })]
        }
        else{
            // If the security policy cannot be evaluated then show a short message depending on the error.
            
            // , so prepare the UI for using it
            self.hideTouchSplash()
            self.clearTrustedCredentials()
            self.doAuth = false;
            
            switch error!.code{
                
            case LAError.TouchIDNotEnrolled.rawValue:
                println("TouchID is not enrolled")
                
            case LAError.PasscodeNotSet.rawValue:
                println("A passcode has not been set")
                
            default:
                // The LAError.TouchIDNotAvailable case.
                println("TouchID not available")
            }
            
            
        }
        
    }
    
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
        self.webView.stringByEvaluatingJavaScriptFromString("auiAuthenticate.recieveTrustedUID('ttupper@awarepoint.com')")
        self.webView.stringByEvaluatingJavaScriptFromString("auiAuthenticate.recieveTrustedPass('God1sFaithful!')")
        
    }
    
    func clearTrustedCredentialsGCD() {
        self.webView.stringByEvaluatingJavaScriptFromString("auiAuthenticate.recieveTrustedUID('')")
        self.webView.stringByEvaluatingJavaScriptFromString("auiAuthenticate.recieveTrustedPass('')")
        
    }
    
    func logInWithStoredCredentialsGCD() {
        self.webView.stringByEvaluatingJavaScriptFromString("auiAuthenticate.handleFingerprintAuth()")
        
    }
    
    func showTouchSplashGCD() {
        self.webView.stringByEvaluatingJavaScriptFromString("auiAuthenticate.showTouchSplash()")
        
    }
    
    func hideTouchSplashGCD() {
        self.webView.stringByEvaluatingJavaScriptFromString("auiAuthenticate.hideTouchSplash()")
        
    }
    
    func tellAuthorizedGCD() {
        self.webView.stringByEvaluatingJavaScriptFromString("auiAuthenticate.authTouchSplash()")
        
    }

}

