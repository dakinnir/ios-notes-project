//
//  ViewController.swift
//  Notes
//
//  Created by Daniel Akinniranye on 10/14/22.
//

import UIKit

class NotesViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var notesSearchBar: UISearchBar!
    @IBOutlet weak var notesTableView: UITableView!
    
    var notes: [Note] = [
        Note(title: "Educational Notes", notes: "These include: accommodation, advice, baggage, behaviour, bread, chaos, damage, furniture, information, luck, luggage, news, permission, progress, scenery, traffic, weather and work."),
        Note(title: "Physics Notes from Max", notes: "A position function can be either scalar-valued (for motion in one dimension) or vector-valued (for motion in two or three dimensions). At each point in time its value represents the position of an object at that time.", lastModified: Date() - 690000)
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initial setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        notesTableView.delegate = self
        notesTableView.dataSource = self
        registerCellsForTableView()
    }
    
    /// This function helps us register the nib for table view cells
    func registerCellsForTableView()  {
        notesTableView.register(UINib(nibName: NoteTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NoteTableViewCell.identifier)
    }
    

}


extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 // notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath) as! NoteTableViewCell
        cell.setup(notes[indexPath.row])
        return cell
    }
    
}

extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        return
    }
}

