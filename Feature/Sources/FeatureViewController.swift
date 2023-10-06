import UIKit
import Combine

import UIComponent

public final class FeatureViewController: UIViewController {
    
    let tableView = UITableView()
    let button = MOButton(frame: .zero)
    let indicator = UIActivityIndicatorView(style: .medium)
    
    private var cancellables = Set<AnyCancellable>()
    
    private let viewModel: FeatureViewModel
    
    public init(viewModel: FeatureViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        button.setTitle("버튼", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray5
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CELL")
        
        view.addSubview(button)
        view.addSubview(tableView)
        view.addSubview(indicator)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -16),
            
            button.heightAnchor.constraint(equalToConstant: 50),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            indicator.topAnchor.constraint(equalTo: tableView.topAnchor),
            indicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            indicator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            indicator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        bind(viewModel: viewModel)
        
        viewModel.didLoad()
    }
    
    private func bind(viewModel: FeatureViewModel) {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isLoading in
                if isLoading {
                    self?.indicator.startAnimating()
                } else {
                    self?.indicator.stopAnimating()
                }
            })
            .store(in: &cancellables)
        
        viewModel.$items
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &cancellables)
    }
    
    @objc
    private func didTapButton() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut]) {
            self.button.transform = .init(scaleX: 0.95, y: 0.95)
            self.viewModel.fetchItems()
        } completion: { _ in
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut]) {
                self.button.transform = .identity
            }
        }
    }
}


// MARK: - Extension

extension FeatureViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel?.text = item.name
        
        return cell
    }
}
