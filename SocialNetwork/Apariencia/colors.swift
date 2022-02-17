

import UIKit

class GradientColorLayer {
    var gl:CAGradientLayer!
    init(horizontal:Bool = false, inversed:Bool = false,darkColor:CGColor = Colors.gradient.dark.cgColor, lightColor:CGColor = Colors.gradient.light.cgColor) {
        self.gl = CAGradientLayer()
        
        self.gl.colors = !inversed ? [darkColor, lightColor] : [lightColor, darkColor]
        
        if !horizontal{
            self.gl.locations = [0.0, 1.0]
        }else{
            self.gl.startPoint = CGPoint(x: 0.0, y: 0.0)
            self.gl.endPoint = CGPoint(x: 1.0, y: 0.0)
        }
    }
}



@objc(ColorsPalette)
public protocol ColorsPalette {
    /// Material color code: 50
    static var lighten5: UIColor { get }
    /// Material color code: 100
    static var lighten4: UIColor { get }
    /// Material color code: 200
    static var lighten3: UIColor { get }
    /// Material color code: 300
    static var lighten2: UIColor { get }
    /// Material color code: 400
    static var lighten1: UIColor { get }
    /// Material color code: 500
    static var base: UIColor { get }
    /// Material color code: 600
    static var darken1: UIColor { get }
    /// Material color code: 700
    static var darken2: UIColor { get }
    /// Material color code: 800
    static var darken3: UIColor { get }
    /// Material color code: 900
    static var darken4: UIColor { get }
    
    /// Material color code: A100
    @objc
    optional static var accent1: UIColor { get }
    
    /// Material color code: A200
    @objc
    optional static var accent2: UIColor { get }
    
    /// Material color code: A400
    @objc
    optional static var accent3: UIColor { get }
    
    /// Material color code: A700
    @objc
    optional static var accent4: UIColor { get }
}

public class Colors: UIColor {
    
    
    public class surface {
        public static let base = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        public static let light = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        public static let dark = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
    }
    
    public class textOnSurface {
        public static let highEmphasis = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.87)
        public static let mediumEmphasis = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
        public static let disabled = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.38)
    }
    
    public class textOnPrimary {
        public static let highEmphasis = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        public static let mediumEmphasis = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.83)
        public static let mediumEmphasis2 = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        public static let disabled = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.38)
    }
    
    public class blackTextPrimary {
        public static let highEmphasis = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.87)
        public static let mediumEmphasis = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
        public static let disabled = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.38)
    }
    
    public class whiteTextPrimary {
        public static let highEmphasis = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        public static let mediumEmphasis = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6)
        public static let disabled = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.38)
    }
    
    
    public class textOnSecondary {
        public static let highEmphasis = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.87)
        public static let mediumEmphasis = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.62)
        public static let disabled = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.38)
    }
    
    public class blackTextSecondary {
        public static let highEmphasis = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.87)
        public static let mediumEmphasis = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
        public static let disabled = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.38)
    }
    
    public class whiteTextSecondary {
        public static let highEmphasis = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        public static let mediumEmphasis = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6)
        public static let disabled = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.38)
    }
    
    
    
    public class primary: ColorsPalette {
        public static let lighten6 = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        public static let lighten5 = #colorLiteral(red: 0.8901960784, green: 0.9490196078, blue: 0.9921568627, alpha: 1)
        public static let lighten4 = #colorLiteral(red: 0.7333333333, green: 0.8705882353, blue: 0.9843137255, alpha: 1)
        public static let lighten3 = #colorLiteral(red: 0.5647058824, green: 0.7921568627, blue: 0.9764705882, alpha: 1)
        
        //        public static let lighten2 = #colorLiteral(red: 0.3921568627, green: 0.7098039216, blue: 0.9647058824, alpha: 1)
        public static let lighten2 = #colorLiteral(red: 0.4039215686, green: 0.7882352941, blue: 0.9411764706, alpha: 1)
        public static let lighten1 = #colorLiteral(red: 0.2588235294, green: 0.6470588235, blue: 0.9607843137, alpha: 1)
        public static let base = #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.9529411765, alpha: 1)
        public static let darken1 = #colorLiteral(red: 0.1176470588, green: 0.5333333333, blue: 0.8980392157, alpha: 1)
        public static let darken2 = #colorLiteral(red: 0.09803921569, green: 0.462745098, blue: 0.8235294118, alpha: 1)
        public static let darken3 = #colorLiteral(red: 0.1137254902, green: 0.4039215686, blue: 0.7411764706, alpha: 1)
        public static let darken4 = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.3568627451, alpha: 1)
        public static let darken5 = #colorLiteral(red: 0.1137254902, green: 0.4039215686, blue: 0.7411764706, alpha: 1)
        //Herramienta
        public static let primaryColor = UIColor(red: 0.26, green: 0.63, blue: 0.28, alpha: 1.0)
        public static let primaryLightColor = UIColor(red: 0.46, green: 0.82, blue: 0.46, alpha: 1.0)
        public static let primaryDarkColor = UIColor(red: 0.00, green: 0.44, blue: 0.10, alpha: 1.0);
        public static let primaryTextColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.0);
        
        
    }
    
    
    
    
    
    
    // pink
    public class secondary: ColorsPalette {
        public static let lighten5 = #colorLiteral(red: 1, green: 0.9725490196, blue: 0.8823529412, alpha: 1)
        public static let lighten4 = #colorLiteral(red: 1, green: 0.9254901961, blue: 0.7019607843, alpha: 1)
        public static let lighten3 = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.5098039216, alpha: 1)
        public static let lighten2 = #colorLiteral(red: 1, green: 0.8352941176, blue: 0.3098039216, alpha: 1)
        public static let lighten1 = #colorLiteral(red: 1, green: 0.7921568627, blue: 0.1568627451, alpha: 1)
        public static let base = #colorLiteral(red: 1, green: 0.7568627451, blue: 0.02745098039, alpha: 1)
        public static let darken1 = #colorLiteral(red: 1, green: 0.7019607843, blue: 0, alpha: 1)
        public static let darken2 = #colorLiteral(red: 1, green: 0.6274509804, blue: 0, alpha: 1)
        public static let darken3 = #colorLiteral(red: 0.9882352941, green: 0.7529411765, blue: 0.1843137255, alpha: 1)
        public static let darken4 = #colorLiteral(red: 1, green: 0.4352941176, blue: 0, alpha: 1)
        public static let darken5 = #colorLiteral(red: 1, green: 0.5568627451, blue: 0.1490196078, alpha: 1)
        //Herramienta
        public static let secondaryColor = UIColor(red: 0.99, green: 0.85, blue: 0.21, alpha: 1.0);
        public static   let secondaryLightColor = UIColor(red: 1.00, green: 1.00, blue: 0.42, alpha: 1.0);
        public static  let secondaryDarkColor = UIColor(red: 0.78, green: 0.65, blue: 0.00, alpha: 1.0);
        public static let secondaryTextColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.0);
    }
    
    // pink
    public class gradient {
        public static let dark = #colorLiteral(red: 0.11, green: 0.4, blue: 0.74, alpha: 1.0)
        public static let light = #colorLiteral(red: 0.373, green: 0.729, blue: 0.898, alpha: 1.0)
        
    }
    
}
