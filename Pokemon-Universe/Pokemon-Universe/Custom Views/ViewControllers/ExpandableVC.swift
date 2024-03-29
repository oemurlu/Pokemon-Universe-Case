//
//  ExpandableVC.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 28.03.2024.
//

import UIKit

final class ExpandableVC: UIViewController {
    
    private var tableView: UITableView!
    private var skills: [String]?
    private var weight: Int?
    private var height: Int?
    private var stats: [(name: String, value: Int)]?
    private var isSectionExpanded: [Bool] = [false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    init(skills: [String]?, weight: Int?, height: Int?, stats: [(name: String, value: Int)]?) {
        super.init(nibName: nil, bundle: nil)
        self.skills = skills
        self.weight = weight
        self.height = height
        self.stats = stats
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}


extension ExpandableVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSectionExpanded[section] {
            switch section {
            case 0: return skills?.count ?? 0
            case 1: return 2 // weight, height
            case 2: return stats?.count ?? 0
            default: return 0
            }
        } else {
            return 0 // dont show any rows if section is not expanded
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = skills?[indexPath.row].capitalized
        case 1:
            if indexPath.row == 0 {
                cell.textLabel?.text = "Weight: \(weight ?? 0) hectogram"
            } else {
                cell.textLabel?.text = "Height: \(height ?? 0) decimeters"
            }
        case 2:
            if let stat = stats?[indexPath.row] {
                cell.textLabel?.text = "\(stat.name): \(stat.value) "
            }
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0: return "Skills"
        case 1: return "Physics"
        case 2: return "Stats"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        
        let symbolImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        let symbolName = isSectionExpanded[section] ? "arrowtriangle.down.fill" : "arrowtriangle.right.fill"
        symbolImageView.image = UIImage(systemName: symbolName)
        symbolImageView.tintColor = .label
        
        let headerLabel = UILabel(frame: CGRect(x: 40, y: 5, width: tableView.bounds.size.width - 40, height: 30))
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        headerLabel.textColor = .label
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        headerView.addSubview(symbolImageView)
        headerView.addSubview(headerLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
        headerView.addGestureRecognizer(tapGesture)
        headerView.tag = section
        
        return headerView
    }
    
    @objc func toggleSection(_ sender: UITapGestureRecognizer) {
        if let section = sender.view?.tag {
            isSectionExpanded[section] = !isSectionExpanded[section]
            tableView.reloadSections(IndexSet(integer: section), with: .fade)
        }
    }
}
