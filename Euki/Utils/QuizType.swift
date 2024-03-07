//
//  QuizType.swift
//  Euki
//
//  Created by ahlem on 1/3/2024.
//  Copyright © 2024 Ibis. All rights reserved.
//

import Foundation

enum QuizType: String {
    case contraception
    case menstruation
    
    var localizedString: String {
          switch self {
          case .contraception:
              return NSLocalizedString("Contraception", comment: "")
          case .menstruation:
              return NSLocalizedString("Menstruation", comment: "")
          }
      }
}
