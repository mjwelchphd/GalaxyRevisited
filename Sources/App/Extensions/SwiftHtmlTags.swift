///  File: Sources/App/Extensions/SwiftHtmlTags.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 9/3/2022.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.
///
///  Extends the W3Schools HTML specification.
///  The Button and Input tags are bug patches.

import SwiftHtml

extension SwiftHtml.A {

    /// Extends the W3Schools HTML specification by specifing the name of an `<a>...</a>`, i.e.,
    /// `<a name="link-1">...</a>` where ControllerTests#testLink can look for the name link-1.
    /// SwiftHtml conforms to the W3Schools HTML specification, but  a "name" attribute is needed
    /// for testing; it's no problem for a browser because the browser will ignore it.
    ///
    /// This is not a bugfix. If anything, it's a matter that the W3C never conceived of a reason a name in a link
    /// would be useful, but here we are. In order to test lihks, it's necessary to find them and that requires a name.
    func name(_ value: String) -> Self {
        attribute("name", value)
    }
}
