///  File: Sources/App/Template/TemplateRepresentable.swift
///
///  Author: Tibor Bödecs <mail.tib@gmail.com>
///  Copyright © 2022 Tibor Bödecs, All rights reserved.

import Vapor
import SwiftSgml

/// Conformance to TemplateRepresentable guarantees that  the structure can be returned as a response to a request.
/// To be more precise, TemplateRenderer needs to guarantee that the template presented has a "render" method.
public protocol TemplateRepresentable {

    @TagBuilder
    func render(_ req: Request) -> Tag
}
