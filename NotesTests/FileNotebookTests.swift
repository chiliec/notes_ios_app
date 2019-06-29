//
//  FileNotebookTests.swift
//  NotesTests
//
//  Created by Бабин Владимир on 28/06/2019.
//  Copyright © 2019 Pro IT Resource. All rights reserved.
//

import XCTest
@testable import Notes

class FileNotebookTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadFromFile() {
        let note = Note(title: "Привед", content: "Медвед")
        let notes = [note.uid: note]
        let notebook = FileNotebook(notes: notes)
        notebook.saveToFile()
        notebook.loadFromFile()
        XCTAssertEqual(notebook.notes, notes)
    }
    
    func testAddNewNote() {
        let note = Note(title: "Привед", content: "Медвед")
        var notes = [note.uid: note]
        let notebook = FileNotebook(notes: notes)
        let newNote = Note(
            uid: "12345",
            title: "Прощай",
            content: "Медвед",
            color: .red,
            importance: .important,
            selfDestructionDate: Date()
        )
        notes[newNote.uid] = newNote
        XCTAssertNotEqual(notebook.notes, notes)
        notebook.add(newNote)
        notebook.saveToFile()
        notebook.loadFromFile()
        XCTAssertEqual(notebook.notes, notes)
    }
}
