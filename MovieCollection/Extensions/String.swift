//
//  String.swift
//  MovieCollection
//
//  Created by anita on 22.09.2022.
//

import Foundation

extension String {
    /*
      Truncates the string to the specified length number of characters and appends an optional trailing string if longer.
      - Parameter length: Desired maximum lengths of a string
      - Parameter trailing: A 'String' that will be appended after the truncation.
       
      - Returns: 'String' object.
     */
     func truncate(length: Int) -> String {
       return (self.count > length) ? self.prefix(length) + "" : self
     }
   }
