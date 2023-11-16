EXECUTABLE_NAME := jihoonahn blog

install:
	@echo "💠 Install $(EXECUTABLE_NAME)..."
	brew install publish
start:
	@echo "🚀 Start $(EXECUTABLE_NAME)..."
	publish run
run: 
	@echo "🍎 run $(EXECUTABLE_NAME)..."
	swift run Blog
tailwind:
	@echo "👻 Start TailWindCSS inside $(EXECUTABLE_NAME)"
	npm install
	npx tailwindcss build Sources/Styles/global.css -o Output/styles.css -c tailwind.config.js
