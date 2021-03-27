//
//  ViewController.swift
//  Filterator
//
//  Created by Mark Dalrymple on 3/27/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(Person.random(count: 10))")
    }
}

