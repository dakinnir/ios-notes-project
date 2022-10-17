//
//  EditNoteViewController.swift
//  Notes
//
//  Created by Daniel Akinniranye on 10/14/22.
//

import UIKit

protocol EditNoteViewControllerDelegate {
    func updateNotesViewController(_ note: Note)
}

class EditNoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    // MARK: - Properties
    var note: Note?
    
    @IBOutlet weak var notesTextView: UITextView!
    
    var delegate: EditNoteViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // initial setup after loading the view.
        // pre-populate views
        if let note = note {
            notesTextView.text = note.notes
        }
    }

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.becomeFirstResponder()
        return true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .automatic
        
        notesTextView.delegate = self
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        notesTextView.resignFirstResponder()
    }
    
    // save current notes
    @IBAction func doneBtnClicked(_ sender: UIBarButtonItem) {
        if let note = notesTextView.text {                        
            let modifiedDate: Date = Date()
            let newNote = Note(notes: note, lastModified: modifiedDate)
            self.delegate?.updateNotesViewController(newNote)
            
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            return
        }
    }

}
