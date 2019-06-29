//
//  NotesTests.swift
//  NotesTests
//
//  Created by Бабин Владимир on 27/06/2019.
//  Copyright © 2019 Pro IT Resource. All rights reserved.
//

import XCTest
@testable import Notes

class NotesTests: XCTestCase {

    func testNotesInit() {
        let title = "Привед"
        let content = "Медвед"
        let note = Note(title: title, content: content)
        XCTAssertEqual(note.uid.count, 36)
        XCTAssertEqual(note.title, title)
        XCTAssertEqual(note.content, content)
        XCTAssertEqual(note.color, .white)
        XCTAssertEqual(note.importance, .ordinary)
        XCTAssertEqual(note.selfDestructionDate, nil)
    }
}
