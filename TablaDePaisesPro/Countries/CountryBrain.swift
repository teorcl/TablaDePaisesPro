//
//  CountryBrain.swift
//  TablaDePaisesPro
//
//  Created by TEO on 21/12/22.
//

import Foundation

protocol CountryBrainProtocol {
    func setViewController(_ viewController: CountriesViewControllerProtocol)
    func getNumberOfCountries() -> Int
    func getCountryForIndex(for index: Int) -> Country //Country es un modelo DTO
    func canDeleteCountry(for index: Int) -> Bool // Así le indicamos desde el cerebro si se puede editar (eliminar para este caso) un país
    func deleteCountry(at index: Int) // Eliminar el país que se encuentre en el indice index
    func processCountrySelected(at index: Int)
}

class CountryBrain {
    weak var viewController: CountriesViewControllerProtocol?
    let countriesStorage: CountriesStorageProtocol = CountriesStorage()
}

extension CountryBrain: CountryBrainProtocol {
    func processCountrySelected(at index: Int) {
        guard let viewController = viewController else { return }
        let country = countriesStorage.getCountryForIndex(for: index)
        viewController.presentAlert(with: country.example, and: country.name)
    }
    
    func deleteCountry(at index: Int) {
        guard let viewController = viewController else { return  }
        // MARK: - Primero se actualizan los datos y luego la interfaz grafica
        countriesStorage.deleteCountry(at: index)
        viewController.deleteRow(at: index) // Acceder al viewcontroller solamente si existe
    }
    
    func canDeleteCountry(for index: Int) -> Bool {
        //true // Por ahora el cerebro indica que todos los paises se pueden eliminar
        // MARK: - Eliminar los paises que su nombre sea diferente de Colombia
        let country = countriesStorage.getCountryForIndex(for: index)
//        if country.name != "Colombia" {
//            return true
//        } else {
//            return false
//        }
        let shouldDelete = country.name != "Colombia"
        return shouldDelete
    }
    
    func getCountryForIndex(for index: Int) -> Country {
        return countriesStorage.getCountryForIndex(for: index) 
    }
    
    func getNumberOfCountries() -> Int {
        return countriesStorage.getNumberOfCountries()
    }
    
    func setViewController(_ viewController: CountriesViewControllerProtocol){
        self.viewController = viewController
    }
}
