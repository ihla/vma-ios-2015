//
//  DetailViewController.swift
//  LifeCycleDemo
//
//  Created by Lubos Ilcik on 17/10/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let logLayoutMethods = false

    static var instanceCount = 0
    var instanceNumber = 0

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: AnyObject? {
        //>>>>>>>>>>>>>>>>>
        // willSet() a didSet() sú tzv. 'property observers'
        didSet {
            // Update the view.
            //>>>>>>>>>>>>>>>>>
            // všimni si, že v configureView() sa kontroluje či je label outlet non nil!
            // ak je nil, nastaví sa až vo viewDidLoad()
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        instanceNumber = DetailViewController.instanceCount++
        super.init(coder: aDecoder)
        log.debug("\(instanceNumber)")
    }
    
    //>>>>>>>>>>>>>>>>>
    // deinit je tu len pre štúdijné účely
    // dealloc resources používaných VC je dobré urobiť vo view*Disappear() metódach ako doporučuje Apple!
    deinit {
        log.debug("\(instanceNumber)")
    }
    
    override func awakeFromNib() {
        log.debug("")
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        log.debug("")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //>>>>>>>>>>>>>>>>>
        // tu sa nastaví label na hodnotu z detailItem (ak not nil)
        // Tip: alternatívne sa to dá urobiť v detailDescriptionLabel - didSet() metóde pričom sa dá ušetriť zopár if-let podmienok (urob za domácu úlohu)
        self.configureView()
    }

    override func viewWillAppear(animated: Bool) {
        log.debug("animated=\(animated)")
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        log.debug("animated=\(animated)")
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        log.debug("animated=\(animated)")
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        log.debug("animated=\(animated)")
        super.viewDidDisappear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        if logLayoutMethods { log.debug("") }
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        if logLayoutMethods { log.debug("") }
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

