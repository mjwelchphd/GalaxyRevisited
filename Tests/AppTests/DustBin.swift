/*
 Dustbin -- temporary holding place

 // Test the stars index by simulating the show all stars button for Nebula N81
 // There aren't any stars yet, but we're just testing the button, not the content
 let starIdContext =
 StarIdContext(
 starId: "",
 galaxyId: starTestingContext.galaxyId,
 galaxyName: ""
 )

 let starIndexPageHtml =
 try retrievePageHtml(
 app: app,
 url: "/star/index",
 validationString: "<title>List All Stars</title>",
 context: starIdContext
 )

 // Some tests can be exceptionally hard to run becaause they require a complex setup
 // Just to test the "List all stars" link in the "Add Star" form, it's necessary to
 // get the galaxy name from the starIndexPageHtml in order to insert it into the
 // validation title
 guard let starAddFormHtml = try starIndexPageHtml.findForm(name: "add-form") else {
 XCTAssert(false, "form add-form not found in starAddFormHtml")
 return
 }

 guard let starAddGalaxyNameHidden = try starAddFormHtml.findHidden(name: "galaxyName") else {
 XCTAssert(false, "hidden input galaxyName not found in starAddFormHtml")
 return
 }

 guard let galaxyName = try starAddGalaxyNameHidden.findValue() else {
 XCTAssert(false, "hidden input galaxyName had no value attribute")
 return
 }

 let addStarPageHtml =
 try testButton(
 app,
 html: starIndexPageHtml,
 formName: "add-form",
 submitName: "add-submit",
 hiddenInputs: ["galaxyId", "galaxyName", "starId"],
 validationString: "<title>Add A Star",
 StarIdContext()
 )
 print("*560* \(addStarPageHtml)")


 try testLink(
 app,
 html: addStarPageHtml,
 name: "list-all-stars",
 validationString: "<title>List All Stars</title>"
 )



 try testButton(
 app, html: starIndexPageHtml,
 formName: "show-form",
 submitName: "show-submit",
 hiddenInputs: ["galaxyId", "galaxyName", "starId"],
 validationString: "<title>Show A Star</title>",
 StarIdContext()
 )

 */
