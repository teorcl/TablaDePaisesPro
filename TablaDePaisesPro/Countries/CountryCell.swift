//
//  CountryCell.swift
//  TablaDePaisesPro
//
//  Created by TEO on 21/12/22.
//

import UIKit

//MARK: - Este protocolo como está definido indica que solo(condicionado) puede ser implementado por una clase que herede de la clase UITableViewCell como lo es CountryCell
protocol CountryCellProtocol where Self: UITableViewCell {
    func setCountryName(_ countryName: String)
    func setLanguage(_ language: String)
    func setExample(_ example: String)
    func setFlagImage(_ flagImage: UIImage?)
}

class CountryCell: UITableViewCell {
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
}

extension CountryCell: CountryCellProtocol {
    func setCountryName(_ countryName: String) {
        countryNameLabel.text = countryName
    }
    
    func setLanguage(_ language: String) {
        languageLabel.text = language
    }
    
    func setExample(_ example: String) {
        exampleLabel.text = example
    }
    
    func setFlagImage(_ flagImage: UIImage?) {
        flagImageView.image = flagImage
    }
    
    
}
