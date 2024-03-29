import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setSharedValueFromDB()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private func setSharedValueFromDB() {
        let userDefault = UserDefaults.standard
        CollectionViewConfigurations.shared.animationDuration = fetchValueForFloat(userDefault: Constant.Keys.animationSpeedKey, with: userDefault) ?? 4
        CollectionViewConfigurations.shared.cellHeight = fetchValueForFloat(userDefault: Constant.Keys.sizeOfItemKey, with: userDefault) ?? 100
        CollectionViewConfigurations.shared.spaceBetweenItems = fetchValueForInt(userDefault: Constant.Keys.spacingBetweenItemsKey, with: userDefault) ?? 5
    }

    private func fetchValueForFloat(userDefault key: String, with userDefault: UserDefaults) -> Float? {
        return userDefault.object(forKey: key) != nil ? userDefault.float(forKey: key) : nil
    }

    private func fetchValueForInt(userDefault key: String, with userDefault: UserDefaults) -> Int? {
       return userDefault.object(forKey: key) != nil ? userDefault.integer(forKey: key) : nil
    }
}

