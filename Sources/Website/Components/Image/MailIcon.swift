import Web

struct MailIcon: Component {
    var body: Component {
        SVG(width: 24, height: 24, viewBox: "0 0 24 24") {
            SVGPath(d: "M4 7C4 6.44772 4.44772 6 5 6H19C19.5523 6 20 6.44772 20 7V17C20 17.5523 19.5523 18 19 18H5C4.44772 18 4 17.5523 4 17V7ZM5.3 8.01307V16.7H18.7V8.01307L12.959 12.1138C12.3853 12.5235 11.6147 12.5235 11.041 12.1138L5.3 8.01307ZM17.4617 7.3H6.5383L11.7966 11.0559C11.9183 11.1428 12.0817 11.1428 12.2034 11.0559L17.4617 7.3Z")
                .attribute(named: "fill-rule", value: "evenodd")
                .attribute(named: "clip-rule", value: "evenodd")
                .attribute(named: "fill", value: "currentColor")
        }
    }
}
