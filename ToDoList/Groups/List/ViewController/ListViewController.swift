//
//  ListViewController.swift
//  ToDoList
//
//  Created by Наджафов Араз on 08.11.2020.
//

import UIKit
import RealmSwift

class ToDoList: Object {
    
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()
    
}

class ListViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var tableView: UITableView!
    
    private let realm = try! Realm()
    private var data = [ToDoList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(ToDoList.self).map({ $0 })
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }
    
    @IBAction func didTapAddButtonAction() {
        let dateVC = UIStoryboard(name: "Date", bundle: nil).instantiateInitialViewController() as! DateViewController
        dateVC.completionHandler = { [weak self] in
            self?.refresh()
        }
        navigationController?.pushViewController(dateVC, animated: true)
        
        print("Add action")
    }
    
    func refresh() {
        data = realm.objects(ToDoList.self).map({ $0 })
        tableView.reloadData()
        let tempImageView = UIImageView(image: UIImage(named: "Paper"))
        tempImageView.frame = self.tableView.frame
        self.tableView.backgroundView = tempImageView;
    }
    
}

// MARK: -
// MARK: - Configure TableView DataSource
extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        cell.textLabel?.text = data[indexPath.row].item
        cell.textLabel?.font = UIFont(name: "American Typewriter", size: 15)
        return cell
    }
    
}

// MARK: -
// MARK: - Configure TableView Delegate
extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = data[indexPath.row]
        let pointVC = UIStoryboard(name: "Point", bundle: nil).instantiateInitialViewController() as! PointViewController
        pointVC.item = item
        pointVC.deletionHandler = { [weak self] in
            self?.refresh()
        }
//        pointVC.title = item.item
        navigationController?.pushViewController(pointVC, animated: true)
    }
    
}

// MARK: -
// MARK: - Configure

private extension ListViewController {
    
    func configure() {
        configureTableView()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}
