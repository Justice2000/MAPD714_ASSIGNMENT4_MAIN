//
//  CheckTableViewCell.swift
//  TodoListApp
//
//  Created by Justice Ekeke on 12/11/2021.
//

import UIKit

class CheckTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var checkswitch: UISwitch!
    
    @IBAction func checked(_ sender: UISwitch) {
        updateChecked()
    }
    
    func set(title: String, checked:Bool){
        label.text = title
        checkswitch.isOn = checked
        updateChecked()
    }
    
    private func updateChecked(){
        let attributedstring = NSMutableAttributedString(string: label.text!)
        
        if checkswitch.isOn{
            attributedstring.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedstring.length-1))
        }else{
            attributedstring.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedstring.length-1))
        }
      
        label.attributedText = attributedstring
    }
    
}
