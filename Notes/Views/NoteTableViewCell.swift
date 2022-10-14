//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Daniel Akinniranye on 10/14/22.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var notesLbl: UILabel!
    
    static let identifier = String(describing: NoteTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(_ note: Note) {
        titleLbl.text = note.title
        dateLbl.text = note.dateDescription
        notesLbl.text = note.notes
    }
}
