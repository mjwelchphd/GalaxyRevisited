///  File: Sources/App/Extensions/Request+Templates.swift
///
///  Author: Tibor Bödecs <mail.tib@gmail.com>
///  Copyright © 2022 Tibor Bödecs, All rights reserved.

import Vapor

/// Simplifies creating and rendering HTML contexts and is used in controllers.
public extension Request {

    var templates: TemplateRenderer { .init(self) }
}
