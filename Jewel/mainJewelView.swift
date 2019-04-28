//
//  mainJewelView.swift
//  Jewel
//
//  Created by Ethan Cardboard Box on 21/2/19.
//  Copyright © 2019 Ethan Cardboard Box. All rights reserved.
//
//  FUCKING XCODE DELETED THIS ENTIRE FUCKING FILE FOR NO FUCKING REASON!!!
//  TODO: REDO ONE OF THE MOST COMPLEX SCRIPTS IN THE FUCKING PROJECT!!!!! WHAT THE FUCC!!
//
//  DOING THIS CAN SUCK MY ASS!!



import Cocoa
import Foundation

class mainJewelView: NSView, WKNavigationDelegate, URLSessionDelegate {
    
    struct defaultsKeys {
        static let keyOne = "https://xenthio.github.io/homepage.html"
    }
    
    @IBOutlet weak var homepageis: NSTextField!
    
    
    
    @IBAction func homepage(_ sender: Any) { // apply settings in settings dialog
        
        UserDefaults.standard.set(myURL.stringValue, forKey: "Homepage") //setObject
        //UserDefaults.standard.set(homepageis.stringValue, forKey: "URL")
        //defaults.set(homepageis.stringValue, forKey: defaultsKey.keyOne)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    
    @IBOutlet var MenuConnect: NSImageView!
    @IBOutlet var FirstLaunch: NSWindow!
    @IBOutlet var CKRT: NSWindow!
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        FirstLaunch?.titleVisibility = .hidden
        FirstLaunch?.styleMask.insert(.fullSizeContentView)
        FirstLaunch?.titlebarAppearsTransparent = true
        FirstLaunch?.contentView?.wantsLayer = true
        FirstLaunch?.contentView?.layer?.contents = NSImage(named: NSImage.Name("maxresdefault"))
        let customToolbar = NSToolbar()
        Winderps?.titleVisibility = .hidden
        Winderps?.toolbar = customToolbar
        
        //if UserDefaults.standard.string(forKey: "Key") == nil {
        //homepageis.stringValue = "https://xenthio.github.io/homepage.html"
        //} else {
        //homepageis.stringValue = UserDefaults.standard.string(forKey: "Key")!
        //}
        self.webView.navigationDelegate = self
        webView?.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0.2 Safari/605.1.15"
        // test for custom homepage
        
        //if let stringOne = defaults.string {
        //zlet name = UserDefaults.standard.string(forKey: "URL") ?? ""
        //if name != nil {
        //    let request = URLRequest(url: URL(string: name)!)
        //    webView?.load(request)  // Some String Value
        
        //} else {
        //let request = URLRequest(url: URL(string: "https://xenthio.github.io/homepage.html")!)
        
        if UserDefaults.standard.string(forKey: "HomePage") != nil {
            let request = URLRequest(url: URL(string:  UserDefaults.standard.string(forKey: "Homepage")!)!)
            webView?.load(request) //load the homepage
        } else {
            UserDefaults.standard.set("https://xenthio.github.io/homepage.html", forKey: "Homepage")
            let request = URLRequest(url: URL(string:  UserDefaults.standard.string(forKey: "Key")!)!)
            webView?.load(request) //load the homepage
            UserDefaults.standard.set(true, forKey: "HasBeenLaunchedBefore")
        }
        
        //}
        // TODO: Make it so the user can change the homepage.
        print("Launched Successfully")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil) // delayed so that the URL bar is blank
        })
        
        
        
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        print("Application Closed")
    }
    
    
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let nserr = error as NSError
        if nserr.code == -1001 { // TIMED OUT:
            let request = URLRequest(url: URL(string: "https://xenthio.github.io/error.html")!)
            webView.load(request)
        } else if nserr.code == -1009 { // NOT CONNECTED TO THE INTERNET
            webView.loadHTMLString("""
            <html>
                <head>
                    <title>Whoops! i dont think you should be able to see the title as well what the heck???</title>
                </head>

                <body>
                    <span style="font-family:arial,helvetica,sans-serif;">
            
            
            
                        <span style="font-family:arial,helvetica,sans-serif;">
                            <h1>Cannot connect to the internet!</h1>
                            the most common of all!
                            <br>
                            <h4>you could try:</h4>
                            Turning on WIFI connections if it is disabled
                            <br>
                            Using a Wired connection
                            <br>
                            Restarting the Router
                            <br>
                            Restarting your Computer
                            <p>&nbsp;</p>
            
                        </span>
                    </span>
                </body>
            </html>
""", baseURL: URL(string: "about:blank"))
        } else if nserr.code == -1003 { // SERVER CANNOT BE FOUND
            webView.loadHTMLString("""
            <html>
                <head>
                    <title>Whoops! i dont think you should be able to see the title as well what the heck???</title>
                </head>

                <body>
                    <span style="font-family:arial,helvetica,sans-serif;">
            
            
            
                        <span style="font-family:arial,helvetica,sans-serif;">
                            <h1>Oh no! There was an Error!</h1>
                            <h4>it seems the server could not be found!</h4>
                            check if you spelled the address correctly
                            <br>
                            if you are the admin of this webpage, you know what to do.
                            <br>
                            <br>
                            TODO: MAKE BETTER ERROR PAGE
                            <p>&nbsp;</p>
            
                        </span>
                    </span>
                </body>
            </html>
""", baseURL: URL(string: "about:blank"))
        } else if nserr.code == -1100 { // URL NOT FOUND ON SERVER
            webView.loadHTMLString("""
            <html>
                <head>
                    <title>Whoops! i dont think you should be able to see the title as well what the heck???</title>
                </head>

                <body>
                    <span style="font-family:arial,helvetica,sans-serif;">
            
            
            
                        <span style="font-family:arial,helvetica,sans-serif;">
                            <h1>Uh oh!</h1>
                            The URL cannot be Found on Server
                            <br>
                            check if you typed in the url correctly!
                            <p>&nbsp;</p>
            
                        </span>
                    </span>
                </body>
            </html>
""", baseURL: URL(string: "about:blank"))
        } else {
            print(nserr.code)
            webView.loadHTMLString("""
            <html>
                <head>
                    <title>Whoops! i dont think you should be able to see the title as well what the heck???</title>
                </head>
                            <body><div class="lr_dct_ent vmod XpoqFe" data-hveid="CAIQBw"><div class="dDoNo gsrt" style="margin-bottom:0;line-height:normal"><h1>Unknown Error</h1></div><div class="vmod"><div class="lr_dct_ent_ph"><span class="lr_dct_ph XpoqFe">/<span>ʌnˈnəʊn&nbsp;ˈɛrə</span>/</span></div><div class="vmod"><div class="xpdxpnd vk_gy" data-mh="-1" aria-hidden="true"><span>adjective: <b>unknown</b></span></div><ol class="lr_dct_sf_sens"><li><div class="vmod"><div class="lr_dct_sf_sen Uekwlc XpoqFe"><div style="margin-left:20px"><div class="PNlCoe XpoqFe"><div style="display:inline" data-dobid="dfn"><span>We honestly have no idea what has happened.</span></div><span class="vmod"><div class="vk_gy">I have no clue on how to program... hurr durr, what is a sea plus plus?</div></span><div class="vmod"></div></div></div></div></div></li></ol></div></div></div></body></html>
            
                        </span>
                    </span>
                </body>
            </html>
""", baseURL: URL(string: "about:blank"))
        }
    }
    
    
    //-----------------------------------------------------------------------------------------//
    //                                 The main code for Jewel                                 //
    //-----------------------------------------------------------------------------------------//
    
    // Varable declarations:
    @IBOutlet var Winderps: NSWindow!
    @IBOutlet var title: NSTextField!
    @IBOutlet var urHome: NSButton!
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet var isSecure: NSButton!
    @IBOutlet var progressView: NSProgressIndicator!
    @IBOutlet var myURL: NSTextField!
    @IBOutlet var menupopup: NSView!
    @IBOutlet var sidemenubg: NSVisualEffectView!
    @IBOutlet var sidemenu: NSScrollView!
    @IBOutlet var ToolMenu: NSBox!
    
    
    
    // Function declarations:
    
    // Here i present...!
    // The *amazing* Error Handler that i spent wayyy too much time researching on how to make it.
    // lets just say i got it correct the first time but turns out something else was breaking it
    /*func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
     //let request = URLRequest(url: URL(string: "https://xenthio.github.io/error.html")!)
     // i was an idiot and i did not pick up on the fact that if you were offline it could not display the error page.
     print("error was: LOOK BELOW")
     error
     print("DONE")
     webView.loadHTMLString("""
     <html>
     <head>
     <title>Whoops! i dont think you should be able to see the title as well what the heck???</title>
     </head>
     
     <body>
     <span style="font-family:arial,helvetica,sans-serif;">
     
     
     
     <span style="font-family:arial,helvetica,sans-serif;">
     <h1>Oh no! There was an Error!</h1>
     <h4>You could Try:</h4>
     Checking if you spelled the address correctly
     <br>
     or if you are connected to the internet
     <br>
     <br>
     TODO: MAKE BETTER ERROR PAGE
     <p>&nbsp;</p>
     
     </span>
     </span>
     </body>
     </html>
     """, baseURL: URL(string: "about:blank"))
     // TODO:
     // 1. make pages for specific errors
     // 2. make it pickup on the error and display the page for that specific error
     }*/
    // Super cool, am i right?
    
    var estWebload = 0
    
    
    @IBAction func DownloadPage(_ sender: Any) {
        let config = URLSessionConfiguration.background(withIdentifier: "com.jewel.downloadin.background")
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
        let task = session.downloadTask(with: URL(string: myURL.stringValue)!)
        task.resume()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        if let response = navigationResponse.response as? HTTPURLResponse {
            if response.statusCode == 404 {
                // ...
            }
        }
        decisionHandler(.allow)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            
            
            
            //if var myURL = NSURL(string: "https://github.com/Xenthio/Jewel/releases/download/v1.1/Jewel.zip") {
            //    Downloader.load(myURL)
            //}
            
            progressView.startAnimation(self)
            //print(webView.url) //used for debugging. re-enable if needed
            progressView.increment(by: 1.0) //updating the value because otherwise it will be nil.
            progressView.increment(by: -1.0)
            progressView.doubleValue = webView.estimatedProgress * 100 // basicly converts the 1.000 into 100.0
            // TODO: Make loading bar smoothly animated
            print(webView.estimatedProgress)
            print("Wazzap")
            print(webView.customUserAgent!)
            myURL.stringValue = (webView.url?.absoluteString)! // Updates the url bar to show current page
            myURL.takeStringValueFrom(webView.url)
            urHome.isHidden = true
            //print((webView.serverTrust! as! String)+" is trust?")
            
            DispatchQueue.main.async {
                if self.webView.hasOnlySecureContent {
                    self.isSecure.isHidden = false
                } else {
                    self.isSecure.isHidden = true
                } // fix because it does not work for some reason
            }
            title.stringValue = webView.title!
            if webView.estimatedProgress == 1.0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    self.progressView.doubleValue = 0.1
                    self.progressView.doubleValue = 0.0
                    self.progressView.doubleValue = 0.0
                    self.progressView.doubleValue = 0.0
                    self.progressView.doubleValue = 0.1
                })
                
            } // fix because it used to work but stopped out of nowhere for some mysterious reason
            
        }
    }
    
    @IBOutlet var ToolsButton2: NSButton!
    @IBOutlet var ToolsButton1: NSButton!
    @IBOutlet var ToolsLabel: NSTextField!
    @IBOutlet var MenuButtonVAR: NSButton!
    @IBOutlet var Tools: NSWindow!
    var MenuIsOpen = false
    //var newsize: NSSize!
    @IBAction func MenuButton(_ sender: Any) {
        //print(sidemenu.frame.height)
        print("HELLO - THIS IS A MARKER")
        if MenuIsOpen == true {
            print("MENU CLOSED")
            MenuConnect.isHidden = true
            ToolMenu.isHidden = true
            ToolsLabel.isHidden = true
            ToolsButton1.isHidden = true
            ToolsButton2.isHidden = true
            //Tools.setIsVisible(false)
            //sidemenu.isHidden = true
            //sidemenubg.isHidden = true
            // repeat {
            //usleep(1000)
            //DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            //    newsize = NSMakeSize(sidemenu.frame.width, sidemenu.frame.height - 1)
            //   sidemenu.setFrameSize(newsize)
            //   print(sidemenu.frame.height)
            //   print("Marker 2")
            
            //}
            //} while sidemenu.frame.height != 1
            MenuIsOpen = false
        } else {
            print("MENU OPEN")
            MenuConnect.isHidden = false
            ToolMenu.isHidden = false
            ToolsLabel.isHidden = false
            ToolsButton1.isHidden = false
            ToolsButton2.isHidden = false
            //sidemenu.isHidden = false
            //sidemenubg.isHidden = false
            MenuIsOpen = true
        }
    }
    
    
    
    
    var repeatTimes = 0
    
    @IBAction func myURLonenter(_ sender: Any) {
        //webView.configuration.
        if myURL.stringValue.hasPrefix("http://") || myURL.stringValue.hasPrefix("https://") {
            // Detects if it's a URL
            let request = URLRequest(url: URL(string: myURL.stringValue)!)
            webView?.load(request)
            print("Contains a url!")
            repeatTimes = 0
            print("System-Utility: Loaded " + myURL.stringValue + " successfully")
        } else {
            
            if myURL.stringValue.contains(".com") || myURL.stringValue.contains(".net") || myURL.stringValue.contains(".org") || myURL.stringValue.contains(".io") || myURL.stringValue.contains(".web") || myURL.stringValue.contains(".tk") || myURL.stringValue.contains(".gl") || myURL.stringValue.contains(".ly") || myURL.stringValue.contains(".be") {
                // Detects if it's a URL
                let theCurrentURL = "https://" + myURL.stringValue
                let request = URLRequest(url: URL(string: theCurrentURL )!)
                webView?.load(request)
                print("Contains a url!")
                repeatTimes = 0
                print("System-Utility: Loaded " + myURL.stringValue + " successfully")
            } else {
                // Detects if it's a Google search
                let newString = myURL.stringValue.replacingOccurrences(of: " ", with: "+",  options: .literal, range: nil) //replaces spaces with pluses otherwise it'll crash.
                
                let request = URLRequest(url: URL(string: "https://www.google.com/search?q="+newString)!)
                
                webView?.load(request)
            }
            
        }
    } // Loads URL input when Enter is pressed
    
    @IBAction func GoButton(_ sender: Any) {
        
        // find better way to detect website
        
        
        
        if myURL.stringValue.hasPrefix("http://") || myURL.stringValue.hasPrefix("https://") {
            // Detects if it's a URL
            let request = URLRequest(url: URL(string: myURL.stringValue)!)
            webView?.load(request)
            print("Contains a url!")
            repeatTimes = 0
            print("System-Utility: Loaded " + myURL.stringValue + " successfully")
        } else {
            if myURL.stringValue.contains(".com") || myURL.stringValue.contains(".net") || myURL.stringValue.contains(".org") || myURL.stringValue.contains(".io") || myURL.stringValue.contains(".web") || myURL.stringValue.contains(".tk") || myURL.stringValue.contains(".gl") || myURL.stringValue.contains(".ly") || myURL.stringValue.contains(".be") {
                // Detects if it's a URL
                let theCurrentURL = "https://" + myURL.stringValue
                let request = URLRequest(url: URL(string: theCurrentURL )!)
                webView?.load(request)
                print("Contains a url!")
                repeatTimes = 0
                print("System-Utility: Loaded " + myURL.stringValue + " successfully")
            } else {
                // Detects if it's a Google search
                let newString = myURL.stringValue.replacingOccurrences(of: " ", with: "+",  options: .literal, range: nil) //replaces spaces with pluses otherwise it'll crash.
                
                let request = URLRequest(url: URL(string: "https://www.google.com/search?q="+newString)!)
                
                webView?.load(request)
            }
        }
    } //Loads URL input when GoButton is pressed
    
    
    
    //this is here to mark a location! Location: 4.D.C. KRET
    
    // ;)
    
}

//Ethan was Here
