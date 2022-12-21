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
}

class CountryBrain {
    weak var viewController: CountriesViewControllerProtocol?
    let countriesStorage: CountriesStorageProtocol = CountriesStorage()
}

extension CountryBrain: CountryBrainProtocol {
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
