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
        Note(notes: "These include: accommodation, advice, baggage, behaviour, bread, chaos, damage, furniture, information, luck, luggage, news, permission, progress, scenery, traffic, weather and work."),
        Note(
            notes: "A position function can be either scalar-valued (for motion in one dimension) or vector-valued (for motion in two or three dimensions). At each point in time its value represents the position of an object at that time.", lastModified: Date() - 690000)
    ]
    
    var filteredNotes: [Note]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initial setup after loading the view.
        notesTableView.delegate = self
        notesTableView.dataSource = self
        notesSearchBar.delegate = self
        registerCellsForTableView()
        
        filteredNotes = notes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        notesSearchBar.resignFirstResponder()

        DispatchQueue.main.async {
            self.notesTableView.reloadData()
        }
    }
    
    /// This function helps us register the nib for table view cells
    func registerCellsForTableView()  {
        notesTableView.register(UINib(nibName: NoteTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NoteTableViewCell.identifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditNoteSegue" {
            let destination = segue.destination as! EditNoteViewController
            destination.note = notes[notesTableView.indexPathForSelectedRow?.row ?? 0]
            destination.title = "Edit Current Note"
            destination.navigationItem.largeTitleDisplayMode = .never
            destination.delegate = self
        } else if segue.identifier == "AddNoteSegue" {
            let destination = segue.destination as! EditNoteViewController
            destination.delegate = self
            destination.title = "Add New Note"

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        notesSearchBar.resignFirstResponder()
        view.endEditing(true)
    }
    
    
}

// MARK: - TableView DataSource
extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath) as! NoteTableViewCell
        cell.setup(filteredNotes[indexPath.row])
        return cell
    }
    
}
// MARK: - TableView Delegate
extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "EditNoteSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        return
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // the initial state (Before the animation)
        cell.alpha = 0

        // the final state (After the animation)
        UIView.animate(withDuration: 1.0, animations: { cell.alpha = 1 })
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let removeNoteAction = UIContextualAction(style: .destructive, title: "Remove") { action, view, completion in
            // remove item from the notes array and table view
            self.notes.remove(at: indexPath.row)
            self.notesTableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [removeNoteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
}
// MARK: - Edit Note View Controller Delegate
extension NotesViewController: EditNoteViewControllerDelegate {
    func updateNotesViewController(_ newNote: Note) {
        if let indexPath = notesTableView.indexPathForSelectedRow {
            self.notes[indexPath.row] = newNote
        } else {
            self.notes.append(newNote)
        }
        
        notesTableView.reloadData()
    }
}

// MARK: - Search Bar Delegate
extension NotesViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        return
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text {
            filteredNotes = notes.filter { note in
                !note.title.ranges(of: text).isEmpty ||
                !note.notes.ranges(of: text).isEmpty ||
                !note.title.lowercased().ranges(of: text).isEmpty
            }
        }
        notesTableView.reloadData()
    }
        
}


