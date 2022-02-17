//
//  EncuestaCell.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 16/02/22.
//

import UIKit
import Charts

class EncuestaCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var pieChartView: UIView!
    @IBOutlet weak var preguntaLabel: UILabel!
    

    override func prepareForReuse() {
        super.prepareForReuse()
        preguntaLabel.text = ""
        self.pieChartView.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func loadCellWithData(_ rowData:[String:Any],_ colores:[String]){
        preguntaLabel.text = rowData["text"] as? String ?? ""
        let chart = PieChartView(frame: self.pieChartView.frame)
        var entries = [PieChartDataEntry]()
        if let chartData = rowData["chartData"] as? [[String:Any]]{
            for chart in chartData{
                let entry = PieChartDataEntry()
                if let percetnage = chart["percetnage"] as? Int{
                    entry.y = Double (percetnage)
                }
                if let text = chart["text"] as? String{
                    entry.label = text
                }
                entries.append(entry)
            }
        }
        let set = PieChartDataSet( entries: entries, label: "")
        var colors: [UIColor] = []
        for color in colores{
            colors.append(UIColor.init(hex: color))
        }
        set.colors = colors
        let data = PieChartData(dataSet: set)
        chart.data = data
        chart.noDataText = "No data available"
        chart.isUserInteractionEnabled = true
        let d = Description()
        chart.chartDescription = d
        chart.holeRadiusPercent = 0.50
        chart.transparentCircleColor = UIColor.clear
        chart.center = CGPoint(x: pieChartView.frame.size.width  / 2,
                               y: pieChartView.frame.size.height / 2)
        self.pieChartView.addSubview(chart)
        
    }
    
}
