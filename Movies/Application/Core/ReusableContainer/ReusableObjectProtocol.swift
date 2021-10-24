// ReusableObjectProtocol.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol ReusableObjectProtocol: UIIdentifiable {}

extension UICollectionViewCell: ReusableObjectProtocol {}

extension UITableViewCell: ReusableObjectProtocol {}
