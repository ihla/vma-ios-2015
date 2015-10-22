//
//  MasterViewController.swift
//  LifeCycleDemo
//
//  Created by Lubos Ilcik on 17/10/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    let logLayoutMethods = false
    let logAppLifeCycleMethods = false

    var objects = [AnyObject]()

    // MARK: - Lifecycle Methods
    
    // initializer sa nezvykne override, tu je len pre štúdijné účely
    // VC má väčšinou viacej init metód
    required init?(coder aDecoder: NSCoder) {
        log.debug("")
        super.init(coder: aDecoder)
    }

    // awakeFromNib sa volá keď VC objekt bol vytvorený a inicializovaný z nib-file (nib = Interface Builder archive file)
    // v tomto momente sú všetky IBOutlets inicializované spolu so všetkými UI objektami
    // view hierarchy však ešte nie je vytvorená!
    // dobré miesto na inicializovanie tých vecí, ktoré sa nedajú urobiť v IB, no s VC sa nezvykne používať
    override func awakeFromNib() {
        log.debug("")
        super.awakeFromNib()
    }

    // viewDidLoad sa volá keď view hierarchy bola vytvorená
    // tu sa zvykne nastaviť GUI podľa dát z modelu
    // v tomto čase však ešte neprebehol layout, preto view objekty ešte nemajú rozmery (geometry), nedá sa napr. rozlíšiť či app beží na iPhone alebo iPad
    // viewDidLoad sa pre každý VC volá len raz, view*Appear a view*Disappear viac krát
    override func viewDidLoad() {
        log.debug("")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //>>>>>>>>>>>>>>>>>
        // takto sa pridá štandartný edit button do navigation bar
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        //>>>>>>>>>>>>>>>>>
        // príklad ako sa vytvorí button programovo a nastaví target action 'insertNewObject'
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        // a takto sa pridá do navigation bar
        self.navigationItem.rightBarButtonItem = addButton
    }

    // viewWillAppear a viewDidAppear sa volá vždy pri prechode z off-screen do on-screen
    // hodí sa pre update GUI na zmeny, ktoré sa udiali počas off-screen
    // treba urobiť dobré rozhodnutie o tom, čo robiť vo viewDidLoad (vykoná sa vždy len raz) a čo tu (môže sa vykonať viac krát)
    override func viewWillAppear(animated: Bool) {
        log.debug("animated=\(animated)")
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed

        //>>>>>>>>>>>>>>>>>
        // App life cycle observers
        // je mechanizmus, ktorým sa VC dozvie o zmenách app stavu
        // nezabudni volať removeObserver() inak hrozí runtime exception!
        // pozri ostatné UIApplication*Notification tytpy v doku
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationDidBecomeActiveNotification", name: UIApplicationDidBecomeActiveNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterForegroundNotification", name: UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationDidEnterBackgroundNotification", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActiveNotification", name: UIApplicationWillResignActiveNotification, object: nil)

        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        log.debug("animated=\(animated)")
        super.viewDidAppear(animated)
    }

    // inverzné metódy k view*Appear 
    // dobré miesto na cleanup & uvoľnenie system resources
    override func viewWillDisappear(animated: Bool) {
        log.debug("animated=\(animated)")

        //>>>>>>>>>>>>>>>>>
        // remove all observers
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(animated: Bool) {
        log.debug("animated=\(animated)")
        super.viewDidDisappear(animated)
    }

    // MARK: - Geometry Changes Methods
    
    // view*LyoutSubviews systém volá kedykoľvek po viewDidLoad keď potrebuje zmeniť geometriu views
    override func viewWillLayoutSubviews() {
        if logLayoutMethods { log.debug("") }
        super.viewWillLayoutSubviews()
    }
    
    // medzi viewWillLayoutSubviews a viewDidLayoutSubviews sa uskutoční autolayout
    override func viewDidLayoutSubviews() {
        if logLayoutMethods { log.debug("") }
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Memory Warning
    
    // týmto systém upozorňuje na low memory
    // tu je dobré uvoľniť cache
    override func didReceiveMemoryWarning() {
        log.debug("")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    // prepareForSegue sa volá vždy pred vykonaním segue
    // segue.destinationViewController referuje destination VC
    // destination VC objekt je v tomto okamihu už vytvorený
    // tu možno odovzdať data
    // pozor: IBOutlets ani UI objekty ešte neexistujú!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        log.debug("segue.identifier=\(segue.identifier)")
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                //>>>>>>>>>>>>>>>>>
                // príklad ako sa odovzdajú data - pozri ako je GUI nastavené v DetailViewController (pozor, v tomto momente ešte nie sú vytvorené IBOutlets v DetailViewController!)
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    // MARK: - App Life Cycle observers
    
    func applicationDidBecomeActiveNotification() {
        if logAppLifeCycleMethods { log.debug("") }
    }
    func applicationWillEnterForegroundNotification() {
        if logAppLifeCycleMethods { log.debug("") }
    }
    func applicationDidEnterBackgroundNotification() {
        if logAppLifeCycleMethods { log.debug("") }
    }
    func applicationWillResignActiveNotification() {
        if logAppLifeCycleMethods { log.debug("") }
    }

    // MARK: - Impl Details
    
    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

}

