EXECUTABLE_NAME := jihoonahn blog

install:
	@echo "💠 Install $(EXECUTABLE_NAME)..."
	brew install publish
start:
	@echo "🚀 Start $(EXECUTABLE_NAME)..."
	publish run
run: 
	@echo "🍎 run $(EXECUTABLE_NAME)..."
	publish generate
