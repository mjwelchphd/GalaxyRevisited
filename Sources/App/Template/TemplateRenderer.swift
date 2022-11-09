///  File: Sources/App/Template/TemplateRenderer.swift
///
///  Author: Tibor Bödecs <mail.tib@gmail.com>
///  Copyright © 2022 Tibor Bödecs, All rights reserved.

import Vapor
import SwiftHtml

/// A helper method to convert SwiftHtml HTML output to a Response object. Since these few statements
/// are used ubiquitously throughout a typical Vapor-SwiftHtml application, putting it here simplifies your code.
public struct TemplateRenderer {

    var req: Request

    init(_ req: Request) {
        self.req = req
    }

    /// Convert SwiftHtml HTML output to a Response object.
    public func renderHtml(_ template: TemplateRepresentable, minify: Bool = false, indent: Int = 4) -> Response {
        let doc = Document(.html) { template.render(req) }
        let body = DocumentRenderer(minify: minify, indent: indent).render(doc)
        return Response(status: .ok, headers: ["content-type": "text/html"], body: .init(string: body))
    }
}
