//
//  EUKNoActionTextField.swift
//  Euki
//
//  Created by Víctor Chávez on 29/5/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

class EUKNoActionTextField: EUKTextField {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func selectionRects(for range: UITextRange) -> [Any] {
		return []
	}

	override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
		return false
	}
}
