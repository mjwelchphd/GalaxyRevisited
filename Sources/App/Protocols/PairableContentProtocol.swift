///  File: Sources/App/Protocols/PairableContentProtocol.swift
///
///  Author: Michael J. Welch, Ph.D.
///  Created: 8/27/22.
///  Copyright © 2022 Michael J. Welch, Ph.D. All rights reserved.

import Vapor

/// Used in CotrollerTests for the "testButton" method because it reads
/// the HTML for the form associated with the named button and creates a list of the
/// hidden inputs and their values. This protocol guarantees that the context passed to
/// "testButton" has the required initializer method, i.e., init(pairs:).
protocol PairableContent: Content {

    init()
    init(pairs: [String: String])
}
