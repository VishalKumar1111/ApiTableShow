//
//  ViewController.swift
//  ApiTableShow
//
//  Created by RLogixxTraining on 04/10/23.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var tblView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblView.dataSource = self
        tblView.delegate = self
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TableViewCell")
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=in&apiKey=c56e376ba65e44e68af159b3777c6bce")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
            guard let data = data else { return }

            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    
                    
              var arrNews = jsonResult["articles"] as? [Any]
                    
                    

                    let firstVal = arrNews?[indexPath.row] as? [String : Any]
                    
                    let title = firstVal?["title"] as? String
                    let description = firstVal?["description"] as? String
                    let imageurl = firstVal?["urlToImage"] as? String
                    print(imageurl ?? "")
                 
                    
                    print(description ?? "")
//                    let decription = firstVal?["description"] as? String
//                    print(description)
//                    print(title ?? "")
                    
                          
                    cell.textLabel?.text = title
                   cell.detailTextLabel?.text = description
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
                       
        }
        
        
        
        
        
        
//        cell.textLabel?.text = "Hello"
        
        return cell
    }


}

