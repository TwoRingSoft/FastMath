init:
	brew bundle
	rbenv exec bundle update
	rbenv exec bundle exec pod update --repo-update

build: build-phone build-mac

build-phone:
	xcodebuild -workspace FastMath.xcworkspace -scheme FastMathTestHarness -sdk iphoneos -quiet clean build

build-mac:
	xcodebuild -workspace FastMath.xcworkspace -scheme FastMathTestHarness-macOS -sdk macosx -quiet clean build

test:
	xcrun xcodebuild -workspace FastMath.xcworkspace -scheme FastMath-iOS-Unit-Tests -destination 'platform=iOS Simulator,name=iPhone SE,OS=12.4' test | tee test_iOS.log | rbenv exec bundle exec xcpretty -t
	xcrun xcodebuild -workspace FastMath.xcworkspace -scheme FastMath-macOS-Unit-Tests test | tee test_macOS.log | rbenv exec bundle exec xcpretty -t

bump:
	rbenv exec bundle exec bumpr $(COMPONENT) FastMath.podspec
	rbenv exec bundle exec migrate-changelog CHANGELOG.md `vrsn --read --file FastMath.podspec`

prerelease:
	rbenv exec bundle exec prerelease-podspec FastMath.podspec --allow-warnings --skip-tests

release:
	rbenv exec bundle exec release-podspec FastMath.podspec --repo tworingsoft --allow-warnings --skip-tests
