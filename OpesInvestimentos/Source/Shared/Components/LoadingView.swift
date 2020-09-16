//
//  LoadingView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 12/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

open class LoadingView {
    
    internal static var spinnerView: UIActivityIndicatorView?
    internal static var loadingLabel: UILabel?
    internal static var touchHandler: (() -> Void)?

    public static let style: UIActivityIndicatorView.Style = .large
    public static let color: UIColor = .white
    public static let font: UIFont? = .boldSystemFont(ofSize: 14)
    public static let backgroundColor: UIColor = UIColor(white: 0, alpha: 0.6)

    public static func spin(on view: UIView? = UIApplication.shared.keyWindow,
                            loadingText: String,
                            style: UIActivityIndicatorView.Style = style,
                            backgroundColor: UIColor = backgroundColor,
                            touchHandler: (() -> Void)? = nil) {
        let viewFrame = view?.bounds ?? .zero

        let indicator = UIActivityIndicatorView(frame: viewFrame)
        indicator.backgroundColor = backgroundColor
        indicator.style = style
        indicator.color = color
        indicator.startAnimating()

        view?.addSubview(indicator)
        self.spinnerView = indicator

        let label = UILabel(frame: .zero)
        label.font = font
        label.textColor = color
        label.text = loadingText
        label.sizeToFit()

        let viewCenter = view?.center ?? .zero
        let labelOrigin = CGPoint(x: viewCenter.x, y: viewCenter.y + 40)
        label.center = labelOrigin

        view?.addSubview(label)
        self.loadingLabel = label

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(runTouchHandler))
        spinnerView?.addGestureRecognizer(tapGestureRecognizer)
        self.touchHandler = touchHandler
    }

    @objc internal static func runTouchHandler() {
        touchHandler?()
    }

    public static func stop() {
        spinnerView?.stopAnimating()
        spinnerView?.removeFromSuperview()
        loadingLabel?.removeFromSuperview()
    }
}
