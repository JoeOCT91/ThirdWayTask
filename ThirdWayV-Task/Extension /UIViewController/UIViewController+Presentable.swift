//
//  UIViewController+Presentable.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 09/06/2022.
//

import UIKit

protocol Presentable {
  func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
  
  func toPresent() -> UIViewController? {
    return self
  }
}
