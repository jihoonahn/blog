import Web

struct TextAreaIcon: Component {
    var body: Component {
        SVG(width: 24, height: 24, viewBox: "0 0 24 24") {
            SVGPath(d: "M7.5 7.85C7.14102 7.85 6.85 8.14102 6.85 8.5C6.85 8.85898 7.14102 9.15 7.5 9.15H16.5C16.859 9.15 17.15 8.85898 17.15 8.5C17.15 8.14102 16.859 7.85 16.5 7.85H7.5Z")
                .attribute(named: "fill", value: "currentColor")
            SVGPath(d: "M6.85 12C6.85 11.641 7.14102 11.35 7.5 11.35H12.5C12.859 11.35 13.15 11.641 13.15 12C13.15 12.359 12.859 12.65 12.5 12.65H7.5C7.14102 12.65 6.85 12.359 6.85 12Z")
                .attribute(named: "fill", value: "currentColor")
            SVGPath(d: "M7.5 14.85C7.14102 14.85 6.85 15.141 6.85 15.5C6.85 15.859 7.14102 16.15 7.5 16.15H15.5C15.859 16.15 16.15 15.859 16.15 15.5C16.15 15.141 15.859 14.85 15.5 14.85H7.5Z")
                .attribute(named: "fill", value: "currentColor")
            SVGPath(d: "M4 6C4 4.89543 4.89543 4 6 4H18C19.1046 4 20 4.89543 20 6V18C20 19.1046 19.1046 20 18 20H6C4.89543 20 4 19.1046 4 18V6ZM6 5.3H18C18.3866 5.3 18.7 5.6134 18.7 6V18C18.7 18.3866 18.3866 18.7 18 18.7H6C5.6134 18.7 5.3 18.3866 5.3 18V6C5.3 5.6134 5.6134 5.3 6 5.3Z")
                .attribute(named: "fill-rule", value: "evenodd")
                .attribute(named: "clip-rule", value: "evenodd")
                .attribute(named: "fill", value: "currentColor")
        }
    }
}
