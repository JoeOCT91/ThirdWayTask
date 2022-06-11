//
//  ProductView.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 09/06/2022.
//

import UIKit

class ProductsView: BaseUIView {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    init() {
        super.init(frame: .zero)
        // configure sub views
        configureCollectionView()
        //Layout view sub views
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollectionView() {
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: Cells.productCell)
        collectionView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 4)
    }
    
    private func layout() {
        layoutCollectionView()
    }
    
    private func layoutCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
