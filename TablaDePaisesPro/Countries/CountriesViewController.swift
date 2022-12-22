//
//  CountriesViewController.swift
//  TablaDePaisesPro
//
//  Created by TEO on 20/12/22.
//

import UIKit

protocol CountriesViewControllerProtocol: AnyObject {
    func deleteRow(at index: Int)
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
    func deleteRow(at index: Int) {
        // tableView.reloadData() // En caso de que quisiera hacer una actualización forzada de toda la tabla
        // Esto tiene como desventaja que vuelve a invocar el llamado de todos los métodos que son requeridos por la tabla (computacionalmente es muy costoso)
        //MARK: - Aproximacion mas fina
        let indexPath = IndexPath(row: index, section: 0) // 0 porque solo tenemos una seccion
        tableView.performBatchUpdates {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brain.getNumberOfCountries()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellIdentifier, for: indexPath) as! CountryCellProtocol
        let country = brain.getCountryForIndex(for: indexPath.row)
        cell.setCountryName(country.name)
        cell.setLanguage(country.lenguage)
        cell.setExample(country.example)
        
        let flagImage = UIImage(named: country.image)
        
        cell.setFlagImage(flagImage)
        
        return cell
    }
    
    //MARK : - Generar edición en una celda de una tabla (canEditRowAt, commit)
    // Este metodo me habilita la opción de editar las celdas
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Cerebro digame si puedo eliminar el país para indice dado por indexPath.row
        brain.canDeleteCountry(for: indexPath.row)
    }
    
    // Este metodo se manejan los eventos respecto a alguna opción de edición
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Cerebro borre el país que se encuentra en el indexPath.row
            brain.deleteCountry(at: indexPath.row)
        }
    }
    
}
