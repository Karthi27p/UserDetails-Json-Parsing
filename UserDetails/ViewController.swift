//
//  ViewController.swift
//  UserDetails
//
//  Created by TRINGAPPS on 02/02/19.
//  Copyright © 2019 TRINGAPPS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var userArray: Array<Any> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let url: URL = URL(string:"https://jsonplaceholder.typicode.com/users")!
        let urlRequest = NSURLRequest(url: url)
        Service.apiServiceRequest(requestUrl: urlRequest as URLRequest, resultStruct: Array<User>.self) { (model, error) in
            self.userArray = model as! Array<User>
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "User Cell") as! TableViewCell
        let user = userArray[indexPath.row] as! User
        cell.name.text = user.name
        cell.userName.text = user.username
        cell.email.text = user.email
        cell.street.text = user.address.street
        cell.suite.text = user.address.suite
        cell.city.text = user.address.city
        cell.zipCode.text = user.address.zipcode
        cell.lat.text = user.address.geo.lat
        cell.long.text = user.address.geo.lng
        cell.phone.text = user.phone
        cell.website.text = user.website
        cell.companyName.text = user.company.name
        cell.catchPhrase.text = user.company.catchPhrase
    
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600.0
    }

}

