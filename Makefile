VERSION = $(shell cat ./VERSION)
BUILD_NUMBER = $(shell cat ./BUILDNUMBER)
BUILD_NUMBER_FILE=BUILDNUMBER
PROJ_DIR=$(shell pwd)

incrementbuild: 
	@if ! test -f $(BUILD_NUMBER_FILE); then echo 0 > $(BUILD_NUMBER_FILE); fi
	@@echo $$(($(BUILD_NUMBER)+1)) > $(BUILD_NUMBER_FILE)

run:
	flutter run -v

run-release-version:
	flutter run -v --release

run-and-clean-first:
	flutter clean
	flutter pub get
	flutter run -v

run-release-and-clean-first:
	flutter clean
	flutter pub get
	flutter run -v --release

release-ios:
	make incrementbuild
	flutter clean
	flutter build ios --release  --build-name=weather$(VERSION) --build-number=$(BUILD_NUMBER)
	cd ios/ && bundle install && bundle exec fastlane release --verbose

release-android:
	make incrementbuild
	flutter clean
	flutter build apk --release --build-name=weather$(VERSION) --build-number=$(BUILD_NUMBER)

beta-android:
	@echo "FROM BUILDNUMBER : $(BUILD_NUMBER)"
	make incrementbuild
	flutter clean
	flutter pub get
	flutter build apk --release --build-name=weather-beta-$(VERSION) --build-number=$(BUILD_NUMBER)  --verbose
	mv $(PROJ_DIR)/build/app/outputs/apk/release/app-release.apk $(PROJ_DIR)/build/app/outputs/apk/release/weather-beta-$(VERSION).apk
	@echo "\n\n\n ------------>> Done! <<------------ \n\n\n"
# cd android/ && bundle install && bundle exec fastlane beta --verbose