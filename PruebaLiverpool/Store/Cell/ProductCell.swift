//
//  ProductCell.swift
//  PruebaLiverpool
//
//  Created by Osvaldo Salas Palomo on 10/02/23.
//

import UIKit
import SDWebImage

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet weak var lblDiscountedPrice: UILabel!
    @IBOutlet weak var lblFullPrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var stackColors: UIStackView!
    @IBOutlet weak var widthConstraintConstant: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(product: Record) {
        lblProductName.text = product.productDisplayName
        lblFullPrice.attributedText = product.promoPrice == 0 || Int(product.promoPrice) == Int(product.listPrice) ? NSAttributedString(string: "$\(product.listPrice)") : "$\(product.listPrice)".strikeThrough()
        lblDiscountedPrice.text = "$\(product.promoPrice)"
        lblDiscountedPrice.isHidden = product.promoPrice == 0 ? true : false
        
        let urlImagen = product.smImage.trimmingCharacters(in: .whitespaces)
        if !urlImagen.isEmpty {
            imgProduct.contentMode = .scaleAspectFit
            imgProduct.sd_setImage(with: URL(string: urlImagen)) { image, error, _, _ in
                if error == nil {
                    self.imgProduct.image = image
                }
            }
        }
        
        if stackColors.arrangedSubviews.count == 0 {
            for colorVar in product.variantsColor {
                if !colorVar.colorHex.isEmpty {
                    let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                    view.backgroundColor = hexToColor(hex: colorVar.colorHex)
                    view.layer.cornerRadius = 10
                    view.layer.borderWidth = 1
                    view.layer.borderColor = UIColor.black.cgColor
                    stackColors.addArrangedSubview(view)
                }
            }
            widthConstraintConstant.constant = CGFloat(product.variantsColor.count) * 22.5
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func hexToColor(hex: String) -> UIColor {
        var string:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (string.hasPrefix("#")) {
            string.remove(at: string.startIndex)
        }
        if ((string.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: string).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


