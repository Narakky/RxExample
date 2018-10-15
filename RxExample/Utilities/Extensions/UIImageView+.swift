//
//  UIImageView+.swift
//  RxExample
//
//  Created by Naraki on 10/15/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {

    func setImage(url: String, placeholder: UIImage?) {
        guard let url = URL(string: url) else { return }
        af_setImage(withURL: url,
                    placeholderImage: placeholder,
                    filter: nil,
                    progress: nil,
                    progressQueue: DispatchQueue.global(),
                    imageTransition: .crossDissolve(0.5),
                    runImageTransitionIfCached: false,
                    completion: nil)
    }

}
