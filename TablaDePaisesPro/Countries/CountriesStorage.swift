//
//  CountriesStorage.swift
//  TablaDePaisesPro
//
//  Created by TEO on 21/12/22.
//
//  La responsabilidad de esta clase es almacenar los datos de los países
//

import Foundation

protocol CountriesStorageProtocol {
    func getCountryForIndex(for index: Int) -> Country
    func getNumberOfCountries() -> Int
}

class CountriesStorage {
    
    let countries = [
        Country(name: "Colombia", image: "colombia", lenguage: "Español", example: "Mi nombre es Teo"),
        Country(name: "Brasil", image: "brasil", lenguage: "Portugués", example: "Meu nome é Teo"),
        Country(name: "Estados Unidos", image: "usa", lenguage: "Inglés", example: "My name is Teo"),
        Country(name: "Francia", image: "francia", lenguage: "Francés", example: "Mon nom est Teo")
    ]
    
}

extension CountriesStorage: CountriesStorageProtocol {
    func getCountryForIndex(for index: Int) -> Country {
        countries[index] // Esto es lo mismo que return countries[index] (se puede usar porque solo hay una linea)
    }
    
    func getNumberOfCountries() -> Int {
        countries.count
    }
}
