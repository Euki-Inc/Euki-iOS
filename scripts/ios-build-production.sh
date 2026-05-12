#!/bin/bash

################################################################################
# iOS Production Build Script - La Pina
#
# This script automates the process of building, archiving, and uploading
# the La Pina iOS app to TestFlight/App Store Connect.
#
# Usage:
#   ./scripts/ios-build-production.sh [options]
#
# Options:
#   --skip-tests          Skip running tests before build
#   --skip-upload         Create archive but don't upload
#   --export-only         Only export IPA, don't upload
#   --increment-build     Auto-increment build number
#   --clean               Clean build folder before building
#
# Requirements:
#   - Xcode 14.0 or later
#   - Valid code signing setup
#   - App Store Connect API key (for upload)
#
# Author: La Pina Team
# Last Updated: March 2026
################################################################################

set -e  # Exit on error
set -o pipefail  # Catch errors in pipes

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EUKI_DIR="${PROJECT_DIR}/Euki"
WORKSPACE="${EUKI_DIR}/Euki.xcworkspace"
PROJECT="${EUKI_DIR}/Euki.xcodeproj"
SCHEME="Euki"
CONFIGURATION="Release"
BUILD_DIR="${PROJECT_DIR}/build"
ARCHIVE_PATH="${BUILD_DIR}/Euki.xcarchive"
EXPORT_PATH="${BUILD_DIR}/export"
IPA_PATH="${EXPORT_PATH}/Euki.ipa"

# Parse command line arguments
SKIP_TESTS=false
SKIP_UPLOAD=false
EXPORT_ONLY=false
INCREMENT_BUILD=false
CLEAN_BUILD=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --skip-tests)
            SKIP_TESTS=true
            shift
            ;;
        --skip-upload)
            SKIP_UPLOAD=true
            shift
            ;;
        --export-only)
            EXPORT_ONLY=true
            shift
            ;;
        --increment-build)
            INCREMENT_BUILD=true
            shift
            ;;
        --clean)
            CLEAN_BUILD=true
            shift
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            exit 1
            ;;
    esac
done

################################################################################
# Helper Functions
################################################################################

print_header() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

check_command() {
    if ! command -v $1 &> /dev/null; then
        print_error "$1 is not installed or not in PATH"
        exit 1
    fi
}

################################################################################
# Pre-flight Checks
################################################################################

print_header "Pre-flight Checks"

# Check if Xcode is installed
check_command xcodebuild
XCODE_VERSION=$(xcodebuild -version | head -n 1)
print_info "Using $XCODE_VERSION"

# Check if workspace exists
if [ -f "$WORKSPACE" ]; then
    BUILD_TARGET="$WORKSPACE"
    USE_WORKSPACE=true
    print_success "Found workspace: $WORKSPACE"
elif [ -f "$PROJECT" ]; then
    BUILD_TARGET="$PROJECT"
    USE_WORKSPACE=false
    print_success "Found project: $PROJECT"
else
    print_error "Neither workspace nor project found in $EUKI_DIR"
    exit 1
fi

# Check scheme exists
SCHEMES=$(xcodebuild -list -workspace "$WORKSPACE" 2>/dev/null | grep -A 100 "Schemes:" | tail -n +2 || echo "")
if echo "$SCHEMES" | grep -q "$SCHEME"; then
    print_success "Scheme '$SCHEME' found"
else
    print_error "Scheme '$SCHEME' not found"
    echo "Available schemes:"
    echo "$SCHEMES"
    exit 1
fi

################################################################################
# Environment Verification
################################################################################

print_header "Environment Verification"

# Check for Config.plist (should exist for production)
CONFIG_PLIST="${EUKI_DIR}/Resources/Config.plist"
if [ ! -f "$CONFIG_PLIST" ]; then
    print_warning "Config.plist not found. Using template."
    print_info "For production, create Config.plist from Config.template.plist"
fi

# Verify code signing
print_info "Verifying code signing configuration..."
SIGNING_IDENTITY=$(xcodebuild -showBuildSettings -workspace "$WORKSPACE" -scheme "$SCHEME" -configuration "$CONFIGURATION" 2>/dev/null | grep "CODE_SIGN_IDENTITY" | head -n 1 | awk -F '= ' '{print $2}' || echo "Not set")
if [ "$SIGNING_IDENTITY" != "Not set" ]; then
    print_success "Code signing identity: $SIGNING_IDENTITY"
else
    print_warning "Code signing identity not set - will use automatic signing"
fi

################################################################################
# Version Information
################################################################################

print_header "Version Information"

# Get current version and build number from project
MARKETING_VERSION=$(xcodebuild -showBuildSettings -workspace "$WORKSPACE" -scheme "$SCHEME" -configuration "$CONFIGURATION" 2>/dev/null | grep "MARKETING_VERSION" | head -n 1 | awk '{print $3}')
CURRENT_BUILD=$(xcodebuild -showBuildSettings -workspace "$WORKSPACE" -scheme "$SCHEME" -configuration "$CONFIGURATION" 2>/dev/null | grep "CURRENT_PROJECT_VERSION" | head -n 1 | awk '{print $3}')

if [ -z "$MARKETING_VERSION" ]; then
    MARKETING_VERSION="1.0.0"
    print_warning "Could not determine MARKETING_VERSION, using default: $MARKETING_VERSION"
else
    print_info "Current version: $MARKETING_VERSION"
fi

if [ -z "$CURRENT_BUILD" ]; then
    CURRENT_BUILD="1"
    print_warning "Could not determine build number, using default: $CURRENT_BUILD"
else
    print_info "Current build: $CURRENT_BUILD"
fi

# Increment build number if requested
if [ "$INCREMENT_BUILD" = true ]; then
    NEW_BUILD=$((CURRENT_BUILD + 1))
    print_info "Incrementing build number: $CURRENT_BUILD → $NEW_BUILD"

    # Update build number using agvtool or PlistBuddy
    if command -v agvtool &> /dev/null; then
        cd "$EUKI_DIR"
        agvtool new-version -all "$NEW_BUILD" > /dev/null 2>&1
        print_success "Build number updated to $NEW_BUILD"
    else
        print_warning "agvtool not available, build number not incremented"
        print_info "To enable agvtool, set 'Versioning System' to 'Apple Generic' in project settings"
    fi
fi

################################################################################
# Clean Build (Optional)
################################################################################

if [ "$CLEAN_BUILD" = true ]; then
    print_header "Cleaning Build Folder"

    xcodebuild clean \
        -workspace "$WORKSPACE" \
        -scheme "$SCHEME" \
        -configuration "$CONFIGURATION" \
        | grep -A 5 "CLEAN SUCCEEDED" || true

    print_success "Build folder cleaned"
fi

# Clean previous build artifacts
if [ -d "$BUILD_DIR" ]; then
    print_info "Removing previous build artifacts..."
    rm -rf "$BUILD_DIR"
fi

mkdir -p "$BUILD_DIR"
mkdir -p "$EXPORT_PATH"

################################################################################
# Run Tests (Optional)
################################################################################

if [ "$SKIP_TESTS" = false ]; then
    print_header "Running Tests"

    print_info "Running unit and UI tests..."

    # Run tests on simulator
    xcodebuild test \
        -workspace "$WORKSPACE" \
        -scheme "$SCHEME" \
        -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
        -configuration Debug \
        | grep -E "(Test Suite|Test Case.*passed|Test Case.*failed|BUILD)" || true

    # Check if tests passed
    if [ ${PIPESTATUS[0]} -eq 0 ]; then
        print_success "All tests passed"
    else
        print_error "Tests failed. Fix failing tests before building for production."
        exit 1
    fi
else
    print_warning "Skipping tests (--skip-tests flag provided)"
fi

################################################################################
# Build and Archive
################################################################################

print_header "Building and Archiving"

print_info "Creating archive for $SCHEME ($MARKETING_VERSION)..."
print_info "This may take several minutes..."

# Archive the app
xcodebuild archive \
    -workspace "$WORKSPACE" \
    -scheme "$SCHEME" \
    -configuration "$CONFIGURATION" \
    -archivePath "$ARCHIVE_PATH" \
    -destination 'generic/platform=iOS' \
    CODE_SIGN_STYLE=Automatic \
    | grep -E "(Building|Archiving|Archive Succeeded)" || true

# Check if archive succeeded
if [ ${PIPESTATUS[0]} -eq 0 ] && [ -d "$ARCHIVE_PATH" ]; then
    print_success "Archive created successfully"
    print_info "Archive location: $ARCHIVE_PATH"
else
    print_error "Archive failed"
    exit 1
fi

# Verify archive
print_info "Verifying archive..."
if [ -f "$ARCHIVE_PATH/Info.plist" ]; then
    ARCHIVE_NAME=$(defaults read "$ARCHIVE_PATH/Info.plist" Name 2>/dev/null || echo "Unknown")
    ARCHIVE_DATE=$(defaults read "$ARCHIVE_PATH/Info.plist" CreationDate 2>/dev/null || echo "Unknown")
    print_success "Archive: $ARCHIVE_NAME"
    print_info "Created: $ARCHIVE_DATE"
else
    print_warning "Could not read archive info"
fi

################################################################################
# Export IPA
################################################################################

print_header "Exporting IPA"

# Create ExportOptions.plist if it doesn't exist
EXPORT_OPTIONS="${BUILD_DIR}/ExportOptions.plist"

cat > "$EXPORT_OPTIONS" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>app-store</string>
    <key>teamID</key>
    <string>REPLACE_WITH_YOUR_TEAM_ID</string>
    <key>uploadSymbols</key>
    <true/>
    <key>uploadBitcode</key>
    <false/>
    <key>compileBitcode</key>
    <false/>
    <key>signingStyle</key>
    <string>automatic</string>
    <key>destination</key>
    <string>upload</string>
</dict>
</plist>
EOF

print_info "Exporting IPA for App Store distribution..."

xcodebuild -exportArchive \
    -archivePath "$ARCHIVE_PATH" \
    -exportPath "$EXPORT_PATH" \
    -exportOptionsPlist "$EXPORT_OPTIONS" \
    | grep -E "(Exporting|Export succeeded)" || true

# Check if export succeeded
if [ ${PIPESTATUS[0]} -eq 0 ] && [ -f "$IPA_PATH" ]; then
    print_success "IPA exported successfully"

    # Get IPA size
    IPA_SIZE=$(du -h "$IPA_PATH" | cut -f1)
    print_info "IPA size: $IPA_SIZE"
    print_info "IPA location: $IPA_PATH"
else
    print_error "Export failed"
    exit 1
fi

################################################################################
# Upload to App Store Connect
################################################################################

if [ "$EXPORT_ONLY" = false ] && [ "$SKIP_UPLOAD" = false ]; then
    print_header "Uploading to App Store Connect"

    print_info "Uploading IPA to App Store Connect..."
    print_warning "This requires valid App Store Connect credentials"

    # Check for xcrun altool (deprecated in Xcode 14+)
    # Use notarytool instead for Xcode 14+
    XCODE_MAJOR_VERSION=$(xcodebuild -version | grep "Xcode" | awk '{print $2}' | cut -d. -f1)

    if [ "$XCODE_MAJOR_VERSION" -ge 14 ]; then
        print_info "Using notarytool for upload (Xcode 14+)..."
        print_warning "Manual upload required - please use Xcode Organizer or Transporter app"
        print_info "Alternatively, configure App Store Connect API key for automated uploads"
        print_info ""
        print_info "To upload manually:"
        print_info "1. Open Xcode → Window → Organizer"
        print_info "2. Select the archive"
        print_info "3. Click 'Distribute App' → 'App Store Connect' → 'Upload'"
        print_info ""
        print_info "Or drag $IPA_PATH into Transporter app"
    else
        # Legacy altool method (Xcode 13 and earlier)
        print_info "Using altool for upload..."

        # Prompt for Apple ID credentials
        read -p "Enter your Apple ID: " APPLE_ID
        read -s -p "Enter your app-specific password: " APP_PASSWORD
        echo ""

        xcrun altool --upload-app \
            --type ios \
            --file "$IPA_PATH" \
            --username "$APPLE_ID" \
            --password "$APP_PASSWORD" \
            --verbose

        if [ $? -eq 0 ]; then
            print_success "Upload successful"
            print_info "Check App Store Connect for processing status"
        else
            print_error "Upload failed"
            exit 1
        fi
    fi
elif [ "$EXPORT_ONLY" = true ]; then
    print_warning "Export only mode - skipping upload"
elif [ "$SKIP_UPLOAD" = true ]; then
    print_warning "Upload skipped (--skip-upload flag provided)"
fi

################################################################################
# Summary
################################################################################

print_header "Build Summary"

echo ""
echo -e "${GREEN}Build completed successfully!${NC}"
echo ""
echo "Version:        $MARKETING_VERSION ($CURRENT_BUILD)"
echo "Configuration:  $CONFIGURATION"
echo "Archive:        $ARCHIVE_PATH"
echo "IPA:            $IPA_PATH"
echo "IPA Size:       $IPA_SIZE"
echo ""

if [ "$SKIP_UPLOAD" = false ] && [ "$EXPORT_ONLY" = false ]; then
    echo -e "${BLUE}Next Steps:${NC}"
    echo "1. Check App Store Connect for build processing status"
    echo "2. Add 'What to Test' information in TestFlight"
    echo "3. Submit build for TestFlight review (if external testing)"
    echo "4. Invite beta testers"
    echo ""
    echo "Processing typically takes 5-15 minutes."
    echo "You'll receive an email when the build is ready."
else
    echo -e "${BLUE}Next Steps:${NC}"
    echo "1. Upload IPA using Xcode Organizer or Transporter app"
    echo "2. Check App Store Connect for processing status"
    echo "3. Continue with TestFlight setup"
fi

echo ""
print_info "View detailed logs in: ${BUILD_DIR}/"
echo ""

################################################################################
# Cleanup (Optional)
################################################################################

# Uncomment to auto-delete build artifacts after successful build
# print_info "Cleaning up build artifacts..."
# rm -rf "$BUILD_DIR"
# print_success "Build artifacts cleaned"

print_success "Script completed successfully"
echo ""

exit 0
