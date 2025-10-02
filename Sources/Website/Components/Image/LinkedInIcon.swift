import Web

struct LinkedInIcon: Component {
    var body: Component {
        SVG(width: 24, height: 24, viewBox: "0 0 24 24") {
            SVGPath(d: "M8 20H4V9H8V20Z")
                .attribute(named: "fill", value: "currentColor")
            SVGPath(d: "M13.1377 10.7383C13.4645 10.0366 14.6278 8.71691 16.667 9.05371C18.706 9.3906 19.6076 11.0192 19.8037 11.791C19.8691 12.2123 20 13.3064 20 14.3164V20H16.667V14.3164C16.667 13.4042 16.2745 11.6227 14.7061 11.791C13.6603 11.9033 13.2539 12.7697 13.1377 13.6055V20H10V9.05371H13.1377V10.7383Z")
                .attribute(named: "fill", value: "currentColor")
            SVGPath(d: "M6 4C7.10457 4 8 4.89543 8 6C8 7.10457 7.10457 8 6 8C4.89543 8 4 7.10457 4 6C4 4.89543 4.89543 4 6 4Z")
                .attribute(named: "fill", value: "currentColor")
        }
    }
}
