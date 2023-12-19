import XCTest

final class TrendingMoviesUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }

    func testMovieListScrollingAndNavigation() throws {
        let app = XCUIApplication()

        let movieListTableView = app.collectionViews[AccessibilityIdentifiers.movieList]
         let firstCell = movieListTableView.cells.element(boundBy: 0)
         XCTAssertTrue(firstCell.waitForExistence(timeout: 10))
         firstCell.tap()

         app.navigationBars.buttons.element(boundBy: 0).tap()
    }
}
