//
//  CheckTableViewCell.swift
//  TodoListApp
//
//  Created by Justice Ekeke on 12/11/2021.
//

import UIKit

protocol CheckTableViewCellDelegate: AnyObject{
    func checkTableViewCell(_ cell: CheckTableViewCell, didChangeCheckedState checked: Bool )
}

class CheckTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var checkswitch: UISwitch!
    
    weak var delegate: CheckTableViewCellDelegate?
    
    @IBAction func checked(_ sender: UISwitch)
    {
        updateChecked()
        delegate?.checkTableViewCell(self, didChangeCheckedState: checkswitch.isOn) 
    }
    
    func set(title: String, checked:Bool)
    {
        label.text = title
        set(checked: checked)
    }
    
    func set(checked:Bool)
    {
        checkswitch.isOn = checked
        updateChecked()
    }
    
    private func updateChecked()
    {
        let attributedstring = NSMutableAttributedString(string: label.text!)
        
        if checkswitch.isOn{
            attributedstring.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedstring.length-1))
        }else{
            attributedstring.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedstring.length-1))
        }
      
        label.attributedText = attributedstring
    }
    
}
