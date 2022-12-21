//
//  CountriesViewController.swift
//  TablaDePaisesPro
//
//  Created by TEO on 20/12/22.
//

import UIKit

protocol CountriesViewControllerProtocol: AnyObject {
    
}

class CountriesViewController: UIViewController {
    
    private struct Const {
        static let cellIdentifier = "CountryCell"
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    let brain: CountryBrainProtocol = CountryBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        brain.setViewController(self)
    }
    
}

extension CountriesViewController: CountriesViewControllerProtocol {
    
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - Notemos que solo me trae 2 de las 3 cosas que requiere una tabla, faltaría el numero de secciones (Recordemos que si solo necesitamos una sola seccion no hay necesidad de implementarlo)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brain.getNumberOfCountries()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: - Covertir la UITableViewCell a mi modelo
        //let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellIdentifier, for: indexPath) //Esto me retorna un UITableViewCell, pero mi celda está modelada en un clase llamada CountryCell, por lo tanto debería hacer una conversion a ese modelo (Pero ojo que este metodo retorna un UITableViewCell)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellIdentifier, for: indexPath) as! CountryCellProtocol // Aquí cell ya puede acceder a los atributos de la clase CountryCell
        //Quién me provee los datos?, la vista solo sabe pintar, para esto se los solicito al cerebro
        // cerebro.obtenerElPaisParaElIndex(indexPath.row)
        let country = brain.getCountryForIndex(for: indexPath.row) // Se crea la constante country por mantenimiento
        cell.setCountryName(country.name)
        cell.setLanguage(country.lenguage)
        cell.setExample(country.example)
        
        let flagImage = UIImage(named: country.image)
        
        cell.setFlagImage(flagImage)
        
        // MARK: - Aquí me pide retornar una celda de tipo UITableViewCell, pero yo había hecho la conversión de cell a CountryCellProtocol, sin embargo CountryCellProtocol es conformado por la clase CountryCell que hereda de la clase UITableViewCell, pero el compilador no sabe esto, como resolvemos este problema?
        
        // MARK: - Para resolver este problema yo le indico al CountryCellProtocol que este protocolo tiene que ser conformado por clases que hereden de la clase UITableVieCell, esto se hace así
        
        // MARK: - protocol CountryCellProtocol where Self: UITableViewCell
        
        // Una vez solucionado el problema ahí si puedo retornar la celda cell
        return cell
    }
}
