//
//  FileNotebook.swift
//  Notes
//
//  Created by Бабин Владимир on 28/06/2019.
//  Copyright © 2019 Pro IT Resource. All rights reserved.
//

import Foundation

final class FileNotebook {
    typealias Notes = [String: Note]
    
    private(set) var notes: Notes
    
    private var fileURL: URL? {
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            else { return nil }
        return documentsDirectoryUrl.appendingPathComponent("notes.json")
    }
    
    init(notes: Notes) {
        self.notes = notes
    }
    
    public func add(_ note: Note) {
        notes[note.uid] = note
    }
    
    public func remove(with uid: String) {
        notes[uid] = nil
    }
    
    public func saveToFile() {
        guard let fileURL = fileURL else { return }
        do {
            let jsonNotes = notes.map({ $0.value.json })
            let data = try JSONSerialization.data(withJSONObject: jsonNotes, options: [])
            try data.write(to: fileURL)
        } catch {
            print(error)
        }
    }
    
    public func loadFromFile() {
        guard let fileURL = fileURL, let stream = InputStream(url: fileURL) else { return }
        stream.open()
        defer { stream.close() }
        do {
            guard let notesJson = try JSONSerialization.jsonObject(with: stream, options: []) as? [[String: Any]] else { return }
            let notesArray = notesJson.compactMap({ Note.parse(json: $0) })
            self.notes = Dictionary(uniqueKeysWithValues: notesArray.map({ ($0.uid, $0) }) )
        } catch {
            print(error)
        }
    }
}
