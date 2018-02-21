# Insert framework iOS SDK Integration

#### Step 1: Integrate Insert Framework

You have two options to add the insert framework. Via [CocoaPods](https://cocoapods.org/) or manually:

##### Add Insert Framework via CocoaPods

Open your [Podfile](https://guides.cocoapods.org/syntax/podfile.html) and add the following lines:
    
    platform:ios, '8.0'
    use_frameworks!
    # other pod statements

    # Uncomment for Xcode 7.2
    # pod 'Insert', '1.x' 
    # Uncomment for Xcode 7.3
    # pod 'Insert', '1.x.XCode-7.3'

(Note insert only supports iOS 8 or later.)

If your application is written in Swift, you will need to add a “Bridging header” and include the framework header:
     
     // your bridging header
     ... import statements
     #import <InsertFramework/InsertFramework.h> // import the framework header
    

**Build settings**

Under:

*Build Settings | Build Options*:

verify that the flag  **Embedded Content Contains Swift Code** is set to **Yes**

Under 

*Build Settings | Build Options*: 

verify that the flag  **Enable Bitcode** is set to **No**

Continue to Step 2 below
 

##### Manual integration

Download the framework from software.insert.io

Drag **InsertFramwork.framework** into your project. When prompted, check the option to “Copy items if needed”

Under 

*Build Phases | Link Binaries With Libraries*: 

verify that InsertFramework.framework is listed

Under  

*General | Embedded Binaries*: 

Press the + sign and add InsertFramework.framework

Under 

*Build Settings | Build Options*: 

Set **Embedded Content Contains Swift Code** to **Yes**

Under 

*Build Settings | Build Options*: 

Verify that the flag  **Enable Bitcode** is set to **No**

Under 

*General | Deployment Target*: 

Verify that your deployment target is set for 8.0 or later

### Step 2: Set a URL Scheme

Under 

*Info | URL Types*: 

Create a new URL by pressing the + sign

Set URL Schemes according to the scheme in the Insert web app dashboard

Set the url Identifier to any name of your choosing (or leave empty).


### Step 3: Initialization Code 

**Objective-C**

In your  **appDelegate** file add:

    #import <InsertFramework/InsertFramework.h>
add or modify the function:

    - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
      if ([[url scheme] containsString:@"insert"]) {
          [[InsertManager sharedManager] initWithUrl:url];
          return YES;
      }
      //  your code here ...
      return YES;
    }
Under **didFinishLaunchingWithOptions** add the following line of code

    [[InsertManager sharedManager] initSDK:@"your app key"
                           companyName:@"your company"];
##### Advanced

The Insert Platform allows the addition of screens that show on application start, such as an App Walkthrough insert type. In order to properly show insert-related screens on start, you may need to start certain application functionality only after a successful initialization of the insert SDK. To register for successful completion of insert SDK initialization add the following before the initSDK call:

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSuccessfullyInitSDK) name:kIIODidSuccessfullyInitializeSDKNotification object:nil];
Then implement the method:

    -(void)didSuccessfullyInitSDK {
      // your post initialization code here
    }
In the same way you can register for failed initialization by registering for **kIIOErrorInitializeSDKNotification**


**Swift only**

In your **AppDelegate** file add:

    import InsertFramework.InsertManager
add or modify the function,

    func application(application: UIApplication, openURL url: NSURL,sourceApplication: String?, annotation: AnyObject) -> Bool {
        if url.scheme.rangeOfString("insert") != nil   {
          InsertManager.sharedManager().initWithUrl(url)
          return true
         }
        // your code here...
        return true
    }
   
Under the function **didFinishLaunchingWithOptions** add the following line of code:

    InsertManager.sharedManager().initSDK("your app key",companyName:"your company")
##### Advanced

The Insert Platform allows the addition of screens that show on application start, such as an App Walkthrough insert type. In order to properly show insert-related screens on start, you may need to start certain application functionality only after a successful initialization of the insert SDK. To register for successful completion of insert SDK initialization add the following before the initSDK call:

    NSNotificationCenter.defaultCenter().addObserver(self, selector: "didSuccessfullyInitSDK", name: kIIODidSuccessfullyInitializeSDKNotification, object: nil)
Then implement the method:

    func didSuccessfullyInitSDK() {
      // your post initialization code here
    }
In the same way you can register for failed initialization by registering for **kIIOErrorInitializeSDKNotification**

##### Test your changes
**Test using Xcode:**

Run the app while attached to Xcode, review the device log and look for the message:
>Insert SDK was successfully integrated and connected to the Insert server. You can start adding insert to your app in the Insert’s web site.

**Test using the Insert Manager web application:**

Log into your Insert account. Under **My Apps**, you should verify that the **Number of app versions** has changed from 0 to 1 (or greater).

##### Troubleshooting

Please visit the iOS section of our help center: http://support.insert.io/hc/en-us/articles/206984289-iOS-Troubleshooting
