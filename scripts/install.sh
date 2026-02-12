#!/bin/bash
################################################################################
# KDE Tiling WM Dotfiles - Installation Script
################################################################################
# This script:
# - Backs up existing configurations automatically
# - Installs new configurations safely
# - Verifies installation
# - Provides rollback option
#
# Usage: ./install.sh [OPTIONS]
# Options:
#   --no-backup    Skip backup (not recommended)
#   --force        Overwrite without confirmation
#   --dry-run      Show what would be done without actually doing it
#
################################################################################

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config/kde-tiling-dotfiles-backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_SUBDIR="$BACKUP_DIR/backup_$TIMESTAMP"

# Parse command line arguments
NO_BACKUP=false
FORCE=false
DRY_RUN=false

for arg in "$@"; do
    case $arg in
        --no-backup)
            NO_BACKUP=true
            shift
            ;;
        --force)
            FORCE=true
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --help)
            echo "Usage: $0 [OPTIONS]"
            echo "Options:"
            echo "  --no-backup    Skip backup (not recommended)"
            echo "  --force        Overwrite without confirmation"
            echo "  --dry-run      Show what would be done"
            echo "  --help         Show this help message"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $arg${NC}"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

################################################################################
# Helper Functions
################################################################################

print_header() {
    echo -e "\n${BLUE}═══════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

check_dependencies() {
    local missing_deps=()
    
    # Check for required commands
    for cmd in qdbus6 kwriteconfig6; do
        if ! command -v $cmd &> /dev/null; then
            missing_deps+=("$cmd")
        fi
    done
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_error "Missing dependencies: ${missing_deps[*]}"
        print_info "Please install KDE Plasma 6 and required tools"
        exit 1
    fi
}

confirm() {
    if [ "$FORCE" = true ]; then
        return 0
    fi
    
    local message="$1"
    read -p "$message (y/N): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

################################################################################
# Main Installation Functions
################################################################################

create_backup() {
    if [ "$NO_BACKUP" = true ]; then
        print_warning "Skipping backup (--no-backup flag)"
        return 0
    fi
    
    print_header "Creating Backup"
    
    # Create backup directory
    mkdir -p "$BACKUP_SUBDIR"
    print_info "Backup directory: $BACKUP_SUBDIR"
    
    # Files to backup
    local files_to_backup=(
        "$CONFIG_DIR/kwinrc"
        "$CONFIG_DIR/kwinrulesrc"
        "$CONFIG_DIR/krunnerrc"
        "$CONFIG_DIR/kglobalshortcutsrc"
    )
    
    local backed_up=0
    for file in "${files_to_backup[@]}"; do
        if [ -f "$file" ]; then
            if [ "$DRY_RUN" = false ]; then
                cp "$file" "$BACKUP_SUBDIR/"
            fi
            print_success "Backed up: $(basename "$file")"
            ((backed_up++))
        else
            print_warning "Not found (will be created): $(basename "$file")"
        fi
    done
    
    if [ $backed_up -eq 0 ]; then
        print_warning "No existing configurations found (fresh install)"
    else
        # Create backup info file
        if [ "$DRY_RUN" = false ]; then
            cat > "$BACKUP_SUBDIR/backup_info.txt" <<EOF
Backup created: $(date)
Files backed up: $backed_up
Original location: $CONFIG_DIR

To restore this backup, run:
  ./scripts/restore.sh $TIMESTAMP
EOF
        fi
        print_success "Backed up $backed_up files"
    fi
}

install_configs() {
    print_header "Installing Configurations"
    
    # Configuration files to install
    local configs=(
        "kwinrc:$REPO_DIR/config/kde/kwinrc:$CONFIG_DIR/kwinrc"
        "kwinrulesrc:$REPO_DIR/config/kde/kwinrulesrc:$CONFIG_DIR/kwinrulesrc"
        "krunnerrc:$REPO_DIR/config/kde/krunnerrc:$CONFIG_DIR/krunnerrc"
    )
    
    local installed=0
    for config in "${configs[@]}"; do
        IFS=: read -r name source dest <<< "$config"
        
        if [ ! -f "$source" ]; then
            print_error "Source file not found: $source"
            continue
        fi
        
        if [ "$DRY_RUN" = true ]; then
            print_info "Would install: $name"
        else
            cp "$source" "$dest"
            print_success "Installed: $name"
            ((installed++))
        fi
    done
    
    if [ $installed -gt 0 ]; then
        print_success "Installed $installed configuration files"
    fi
}

apply_changes() {
    if [ "$DRY_RUN" = true ]; then
        print_info "Would apply changes to KWin and KRunner"
        return 0
    fi
    
    print_header "Applying Changes"
    
    # Reconfigure KWin
    print_info "Reconfiguring KWin..."
    if qdbus6 org.kde.KWin /KWin reconfigure 2>/dev/null; then
        print_success "KWin reconfigured"
    else
        print_warning "Could not reconfigure KWin (may need logout)"
    fi
    
    # Restart KRunner
    print_info "Restarting KRunner..."
    if kquitapp6 krunner 2>/dev/null; then
        sleep 1
        krunner &>/dev/null &
        print_success "KRunner restarted"
    else
        print_warning "Could not restart KRunner (may need logout)"
    fi
    
    # Global shortcuts cleanup (helps with conflicts)
    print_info "Cleaning up global shortcuts..."
    if qdbus6 org.kde.kglobalaccel /component/kwin org.kde.kglobalaccel.Component.cleanUp 2>/dev/null; then
        print_success "Global shortcuts cleaned"
    else
        print_warning "Could not clean shortcuts (not critical)"
    fi
}

verify_installation() {
    print_header "Verifying Installation"
    
    local configs=(
        "$CONFIG_DIR/kwinrc"
        "$CONFIG_DIR/kwinrulesrc"
        "$CONFIG_DIR/krunnerrc"
    )
    
    local verified=0
    for config in "${configs[@]}"; do
        if [ -f "$config" ]; then
            print_success "Found: $(basename "$config")"
            ((verified++))
        else
            print_error "Missing: $(basename "$config")"
        fi
    done
    
    if [ $verified -eq ${#configs[@]} ]; then
        print_success "All configurations verified!"
        return 0
    else
        print_error "Some configurations are missing"
        return 1
    fi
}

print_next_steps() {
    print_header "Installation Complete!"
    
    cat << EOF
${GREEN}✓ Configuration installed successfully!${NC}

${BLUE}Next Steps:${NC}

1. ${YELLOW}Logout and login${NC} to ensure all changes take effect
   (Or press Ctrl+Alt+Backspace if enabled)

2. Test Krohnkite shortcuts:
   ${BLUE}Meta+H/J/K/L${NC} - Navigate windows
   ${BLUE}Meta+Shift+H/J/K/L${NC} - Move windows
   ${BLUE}Meta+T${NC} - Tile layout
   ${BLUE}Meta+M${NC} - Monocle layout

3. Test KRunner:
   ${BLUE}Alt+Space${NC} - Should open instantly (<50ms)

4. Check effects:
   ${BLUE}System Settings > Desktop Effects${NC}
   Verify Krohnkite, Blur, and other effects are enabled

${BLUE}Optional Enhancements:${NC}

- Install Panel Colorizer: ${GREEN}yay -S plasma6-applets-panel-colorizer-git${NC}
- Install Rounded Corners: See ${BLUE}docs/plugins/RECOMMENDED_PLUGINS.md${NC}
- Customize gaps: Edit ${BLUE}~/.config/kwinrc${NC} [Tiling] padding=4

${BLUE}Documentation:${NC}

- Full shortcuts: ${GREEN}docs/customization/SHORTCUTS.md${NC}
- Plugin guide: ${GREEN}docs/plugins/RECOMMENDED_PLUGINS.md${NC}
- Troubleshooting: ${GREEN}docs/troubleshooting/COMMON_ISSUES.md${NC}

${BLUE}Backup Location:${NC}
${GREEN}$BACKUP_SUBDIR${NC}

${YELLOW}If anything goes wrong, restore backup with:${NC}
${GREEN}./scripts/restore.sh $TIMESTAMP${NC}

EOF
}

################################################################################
# Main Execution
################################################################################

main() {
    # Print banner
    cat << "EOF"
╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║   KDE Tiling Window Manager - Dotfiles Installer             ║
║                                                               ║
║   Transform KDE Plasma into a powerful tiling WM             ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
EOF
    
    # Check if running as root
    if [ "$EUID" -eq 0 ]; then
        print_error "Do not run this script as root!"
        exit 1
    fi
    
    # Check dependencies
    check_dependencies
    
    # Show what will be done
    if [ "$DRY_RUN" = true ]; then
        print_warning "DRY RUN MODE - No changes will be made"
    fi
    
    print_info "Repository: $REPO_DIR"
    print_info "Config directory: $CONFIG_DIR"
    print_info "Backup directory: $BACKUP_SUBDIR"
    echo
    
    # Confirm installation
    if ! confirm "Proceed with installation?"; then
        print_warning "Installation cancelled"
        exit 0
    fi
    
    # Create backup
    create_backup
    
    # Install configurations
    install_configs
    
    # Apply changes
    apply_changes
    
    # Verify installation
    if verify_installation; then
        print_next_steps
        exit 0
    else
        print_error "Installation verification failed"
        print_warning "You may need to restore from backup"
        exit 1
    fi
}

# Run main function
main
