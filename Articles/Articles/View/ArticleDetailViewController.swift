//
//  ArticleDetailViewController.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 25/11/21.
//

import UIKit
/**
 A Detail ViewController which showcases the details of the Articles. The data is pushed externally, this class only process UI related operations.
 */
class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    
    var source: String?
    var abstract: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureView()
    }
    
    func configureView() {
        self.sourceLabel.text = self.source ?? ""
        self.abstractLabel.text = self.abstract ?? ""
    }
    
}
