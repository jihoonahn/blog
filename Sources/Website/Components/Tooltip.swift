import Web

enum TooltipPosition: String, Sendable {
    case top
    case bottom
    case left
    case right
}

struct Tooltip: Component {
    let text: String
    let position: TooltipPosition
    let delay: Int
    let content: ContentProvider
    
    init(
        text: String,
        position: TooltipPosition = .top,
        delay: Int = 200,
        @ComponentBuilder content: @escaping ContentProvider
    ) {
        self.text = text
        self.position = position
        self.delay = delay
        self.content = content
    }
    
    public var body: Component {
        Div {
            content()
            
            Div {
                Text(text)
            }
            .class(tooltipClass)
            .attribute(named: "style", value: "transition-delay: \(delay)ms;")
        }
        .class("tooltip-container relative group")
        .style(".tooltip-container:hover .tooltip { opacity: 1; visibility: visible; }")
    }
    
    private var tooltipClass: String {
        let baseClass = "tooltip absolute z-50 px-3 py-2 text-sm text-neutral-100 bg-neutral-900 border border-neutral-700 rounded-lg shadow-lg opacity-0 invisible transition-all duration-200 pointer-events-none whitespace-nowrap"
        
        let positionClass: String
        switch position {
        case .top:
            positionClass = "bottom-full left-1/2 transform -translate-x-1/2 mb-3"
        case .bottom:
            positionClass = "top-full left-1/2 transform -translate-x-1/2 mt-3"
        case .left:
            positionClass = "right-full top-1/2 transform -translate-y-1/2 mr-3"
        case .right:
            positionClass = "left-full top-1/2 transform -translate-y-1/2 ml-3"
        }
        
        return "\(baseClass) \(positionClass)"
    }
}
