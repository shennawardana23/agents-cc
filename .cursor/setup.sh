#!/bin/bash

# Studio AI Agents for Cursor - Setup Script
# This script helps set up and manage the Cursor agent system

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Project root
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CURSOR_DIR="$PROJECT_ROOT/.cursor"

echo -e "${BLUE}🚀 Studio AI Agents for Cursor - Setup Script${NC}"
echo

# Check if we're in the right directory
if [[ ! -f "$CURSOR_DIR/cursor.json" ]]; then
    echo -e "${RED}❌ Error: Not in the correct project directory${NC}"
    echo "Please run this script from the agents-cc project root"
    exit 1
fi

# Function to check dependencies
check_dependencies() {
    echo -e "${YELLOW}🔍 Checking dependencies...${NC}"

    local missing_deps=()

    # Check Node.js
    if ! command -v node &> /dev/null; then
        missing_deps+=("node")
    else
        echo -e "${GREEN}✅ Node.js: $(node --version)${NC}"
    fi

    # Check Python
    if ! command -v python3 &> /dev/null; then
        missing_deps+=("python3")
    else
        echo -e "${GREEN}✅ Python: $(python3 --version)${NC}"
    fi

    # Check if we're in a git repo
    if ! git rev-parse --git-dir &> /dev/null; then
        echo -e "${YELLOW}⚠️  Not in a git repository${NC}"
    else
        echo -e "${GREEN}✅ Git repository detected${NC}"
    fi

    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        echo -e "${RED}❌ Missing dependencies: ${missing_deps[*]}${NC}"
        echo "Please install the missing dependencies and run this script again"
        exit 1
    fi

    echo -e "${GREEN}✅ All dependencies are available${NC}"
    echo
}

# Function to install MCP servers
install_mcp_servers() {
    echo -e "${YELLOW}📦 Installing MCP servers...${NC}"

    cd "$CURSOR_DIR"

    # Install MCP servers globally
    npm install -g @modelcontextprotocol/server-filesystem
    npm install -g @modelcontextprotocol/server-git
    npm install -g @modelcontextprotocol/server-sqlite
    npm install -g @modelcontextprotocol/server-github
    npm install -g @modelcontextprotocol/server-brave-search

    # Install task master AI
    npm install -g mcp-task-master-ai
    npm install -g mcp-sequential-thinking
    npm install -g mcp-memory

    echo -e "${GREEN}✅ MCP servers installed${NC}"
    echo
}

# Function to validate configuration
validate_config() {
    echo -e "${YELLOW}🔍 Validating configuration...${NC}"

    local config_files=(
        "cursor.json"
        "mcp.json"
        "models.json"
        "tasks.json"
    )

    for file in "${config_files[@]}"; do
        if [[ -f "$CURSOR_DIR/$file" ]]; then
            echo -e "${GREEN}✅ $file: Valid${NC}"
        else
            echo -e "${RED}❌ $file: Missing${NC}"
            return 1
        fi
    done

    # Check if rules directory exists and has content
    if [[ -d "$CURSOR_DIR/rules" ]] && [[ -n "$(find "$CURSOR_DIR/rules" -name "*.mdc" -type f)" ]]; then
        local rule_count=$(find "$CURSOR_DIR/rules" -name "*.mdc" -type f | wc -l)
        echo -e "${GREEN}✅ Rules: $rule_count agent rules found${NC}"
    else
        echo -e "${RED}❌ Rules: No agent rules found${NC}"
        return 1
    fi

    # Check for enhanced memories configuration
    if [[ -f "$CURSOR_DIR/rules/enhanced-memories.mdc" ]]; then
        echo -e "${GREEN}✅ Enhanced Memories: Configured${NC}"
    else
        echo -e "${YELLOW}⚠️  Enhanced Memories: Not configured${NC}"
    fi

    echo -e "${GREEN}✅ Configuration is valid${NC}"
    echo
}

# Function to show agent status
show_agent_status() {
    echo -e "${YELLOW}📊 Agent Status:${NC}"

    local departments=(
        "engineering"
        "design"
        "marketing"
        "product"
        "project-management"
        "studio-operations"
        "testing"
        "bonus"
    )

    for dept in "${departments[@]}"; do
        local dept_dir="$CURSOR_DIR/rules/$dept"
        if [[ -d "$dept_dir" ]]; then
            local count=$(find "$dept_dir" -name "*.md" -type f | wc -l)
            echo -e "  ${BLUE}$dept:${NC} $count agents"
        fi
    done

    echo
}

# Function to create Go sample project
create_go_project() {
    echo -e "${YELLOW}🎯 Creating Go Clean Architecture sample project...${NC}"

    local sample_dir="$PROJECT_ROOT/go-sample-project"
    mkdir -p "$sample_dir"

    # Create Go project structure
    mkdir -p "$sample_dir"/{cmd/server,internal/{handlers,models,services,repositories,middleware},pkg/{utils,config},configs,migrations,docs,scripts}

    # Create go.mod
    cat > "$sample_dir/go.mod" << 'EOF'
module github.com/studio/go-sample-project

go 1.21

require (
    github.com/gin-gonic/gin v1.9.1
    github.com/joho/godotenv v1.4.0
    github.com/lib/pq v1.10.9
    github.com/golang-migrate/migrate/v4 v4.16.2
    github.com/sirupsen/logrus v1.9.3
    gorm.io/gorm v1.25.4
    gorm.io/driver/postgres v1.5.2
)
EOF

    # Create main.go
    cat > "$sample_dir/cmd/server/main.go" << 'EOF'
package main

import (
    "log"
    "github.com/studio/go-sample-project/internal/handlers"
    "github.com/studio/go-sample-project/pkg/config"
)

func main() {
    cfg := config.Load()
    app := handlers.NewApp(cfg)

    log.Printf("Starting server on port %s", cfg.Port)
    if err := app.Start(); err != nil {
        log.Fatal(err)
    }
}
EOF

    # Create config
    cat > "$sample_dir/pkg/config/config.go" << 'EOF'
package config

import (
    "os"
    "strconv"
)

type Config struct {
    Port     string
    Database DatabaseConfig
}

type DatabaseConfig struct {
    Host     string
    Port     string
    User     string
    Password string
    Name     string
    SSLMode  string
}

func Load() *Config {
    return &Config{
        Port: getEnv("PORT", "8080"),
        Database: DatabaseConfig{
            Host:     getEnv("DB_HOST", "localhost"),
            Port:     getEnv("DB_PORT", "5432"),
            User:     getEnv("DB_USER", "postgres"),
            Password: getEnv("DB_PASSWORD", "password"),
            Name:     getEnv("DB_NAME", "sample_db"),
            SSLMode:  getEnv("DB_SSLMODE", "disable"),
        },
    }
}

func getEnv(key, defaultValue string) string {
    if value := os.Getenv(key); value != "" {
        return value
    }
    return defaultValue
}
EOF

    # Create .cursorrules for Go project
    cat > "$sample_dir/.cursorrules" << 'EOF'
# Go Clean Architecture Sample Project
# This project demonstrates Go Clean Architecture patterns

## Project Structure
- cmd/server: Application entry point
- internal/: Private application code (handlers, models, services, repositories)
- pkg/: Public packages that can be imported
- configs/: Configuration files
- migrations/: Database migrations
- docs/: Documentation

## Architecture Rules
- Use dependency injection for service creation
- Implement interfaces for repositories and services
- Use context for request-scoped operations
- Apply error wrapping with context
- Write comprehensive unit tests

## Agent Usage Examples
- "Create a user service following clean architecture" -> Backend Architect + AI Engineer
- "Add JWT authentication middleware" -> Backend Architect
- "Write unit tests for user repository" -> Test Writer Fixer
- "Optimize database queries" -> Performance Benchmarker
- "Create API documentation" -> API Tester

## Best Practices
1. Follow the dependency rule (inner layers can't depend on outer)
2. Use interfaces to decouple dependencies
3. Write testable code with dependency injection
4. Handle errors properly with context
5. Use structured logging
EOF

    echo -e "${GREEN}✅ Go Clean Architecture project created at: $sample_dir${NC}"
    echo
}

# Function to create PHP sample project
create_php_project() {
    echo -e "${YELLOW}🎯 Creating PHP CodeIgniter MVC sample project...${NC}"

    local sample_dir="$PROJECT_ROOT/php-sample-project"
    mkdir -p "$sample_dir"

    # Create CodeIgniter project structure
    mkdir -p "$sample_dir"/{application/{config,controllers,models,views,helpers,libraries,widgets},assets/{css,js,images},uploads,docs,tests}

    # Create config files
    cat > "$sample_dir/application/config/config.php" << 'EOF'
<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$config['base_url'] = 'http://localhost/php-sample-project/';
$config['index_page'] = '';
$config['uri_protocol'] = 'REQUEST_URI';
$config['url_suffix'] = '';
$config['language'] = 'english';
$config['charset'] = 'UTF-8';
$config['enable_hooks'] = FALSE;
$config['subclass_prefix'] = 'MY_';
$config['composer_autoload'] = FALSE;
$config['permitted_uri_chars'] = 'a-z 0-9~%.:_\-';
$config['enable_query_strings'] = FALSE;
$config['controller_trigger'] = 'c';
$config['function_trigger'] = 'm';
$config['directory_trigger'] = 'd';
$config['allow_get_array'] = TRUE;
$config['log_threshold'] = 1;
$config['log_path'] = '';
$config['log_file_extension'] = '';
$config['log_file_permissions'] = 0644;
$config['log_date_format'] = 'Y-m-d H:i:s';
$config['error_views_path'] = '';
$config['cache_path'] = '';
$config['cache_query_string'] = FALSE;
$config['encryption_key'] = 'your-encryption-key-here';
$config['sess_driver'] = 'files';
$config['sess_cookie_name'] = 'ci_session';
$config['sess_expiration'] = 7200;
$config['sess_save_path'] = NULL;
$config['sess_match_ip'] = FALSE;
$config['sess_time_to_update'] = 300;
$config['sess_regenerate_destroy'] = FALSE;
$config['cookie_prefix'] = '';
$config['cookie_domain'] = '';
$config['cookie_path'] = '/';
$config['cookie_secure'] = FALSE;
$config['cookie_httponly'] = FALSE;
$config['csrf_protection'] = TRUE;
$config['csrf_token_name'] = 'csrf_token';
$config['csrf_cookie_name'] = 'csrf_cookie';
$config['csrf_expire'] = 7200;
$config['csrf_regenerate'] = TRUE;
$config['csrf_exclude_uris'] = array();
$config['compress_output'] = FALSE;
$config['time_reference'] = 'local';
$config['rewrite_short_tags'] = FALSE;
$config['proxy_ips'] = '';
EOF

    # Create database config
    cat > "$sample_dir/application/config/database.php" << 'EOF'
<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$active_group = 'default';
$query_builder = TRUE;

$db['default'] = array(
    'dsn'   => '',
    'hostname' => 'localhost',
    'username' => 'root',
    'password' => '',
    'database' => 'php_sample_project',
    'dbdriver' => 'mysqli',
    'dbprefix' => '',
    'pconnect' => FALSE,
    'db_debug' => (ENVIRONMENT !== 'production'),
    'cache_on' => FALSE,
    'cachedir' => '',
    'char_set' => 'utf8',
    'dbcollat' => 'utf8_general_ci',
    'swap_pre' => '',
    'encrypt' => FALSE,
    'compress' => FALSE,
    'stricton' => FALSE,
    'failover' => array(),
    'save_queries' => TRUE
);
EOF

    # Create autoload config
    cat > "$sample_dir/application/config/autoload.php" << 'EOF'
<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$autoload['packages'] = array();

$autoload['libraries'] = array('database', 'session', 'form_validation');

$autoload['drivers'] = array();

$autoload['helper'] = array('url', 'form', 'security');

$autoload['config'] = array();

$autoload['language'] = array();

$autoload['model'] = array();
EOF

    # Create base controller
    cat > "$sample_dir/application/controllers/MY_Controller.php" << 'EOF'
<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class MY_Controller extends CI_Controller {

    public function __construct() {
        parent::__construct();

        // Set security headers
        $this->set_security_headers();

        // Enhanced session security
        $this->enhance_session_security();
    }

    private function set_security_headers() {
        $this->output->set_header('X-Frame-Options: DENY');
        $this->output->set_header('X-Content-Type-Options: nosniff');
        $this->output->set_header('X-XSS-Protection: 1; mode=block');
        $this->output->set_header('Strict-Transport-Security: max-age=31536000; includeSubDomains');
        $this->output->set_header('Referrer-Policy: strict-origin-when-cross-origin');
    }

    private function enhance_session_security() {
        if ($this->session->userdata('last_regenerate')) {
            $last_regen = $this->session->userdata('last_regenerate');
            if (time() - $last_regen > 300) { // 5 minutes
                $this->session->sess_regenerate(TRUE);
                $this->session->set_userdata('last_regenerate', time());
            }
        } else {
            $this->session->set_userdata('last_regenerate', time());
        }
    }

    protected function require_auth() {
        if (!$this->session->userdata('user_id')) {
            redirect('auth/login');
            return false;
        }
        return true;
    }

    protected function require_permission($permission) {
        $user_permissions = $this->session->userdata('permissions');

        if (!in_array($permission, $user_permissions)) {
            $this->session->set_flashdata('error', 'Access denied');
            redirect('dashboard');
            return false;
        }

        return true;
    }
}
EOF

    # Create .cursorrules for PHP project
    cat > "$sample_dir/.cursorrules" << 'EOF'
# PHP CodeIgniter MVC Sample Project
# This project demonstrates CodeIgniter MVC patterns with security best practices

## Project Structure
- application/: Core application code
  - config/: Configuration files
  - controllers/: Controllers with business logic
  - models/: Data access layer
  - views/: Presentation layer
  - helpers/: Reusable helper functions
  - libraries/: Custom libraries and classes
  - widgets/: Reusable UI components
- assets/: CSS, JavaScript, and image files
- uploads/: File uploads directory
- docs/: Documentation

## MVC Architecture Rules
- Controllers handle HTTP requests and responses
- Models interact with database and business logic
- Views handle presentation and user interface
- Use CodeIgniter's form validation for input validation
- Implement CSRF protection on all forms
- Use session management for authentication
- Follow security best practices for file uploads

## Agent Usage Examples
- "Create a user management system" -> Backend Architect + Frontend Developer
- "Add authentication and authorization" -> Backend Architect
- "Create responsive dashboard views" -> UI Designer + Frontend Developer
- "Write unit tests for models" -> Test Writer Fixer
- "Optimize database queries" -> Performance Benchmarker
- "Create API documentation" -> API Tester

## Best Practices
1. Use CodeIgniter's query builder for database operations
2. Implement proper error handling and logging
3. Use form validation for all user inputs
4. Apply XSS cleaning and input sanitization
5. Use sessions for user authentication
6. Implement CSRF protection
7. Follow MVC separation of concerns
EOF

    echo -e "${GREEN}✅ PHP CodeIgniter MVC project created at: $sample_dir${NC}"
    echo
}

# Function to create sample project
create_sample_project() {
    echo -e "${YELLOW}🎯 Creating sample projects...${NC}"

    create_go_project
    create_php_project

    echo -e "${GREEN}✅ Sample projects created${NC}"
    echo
}

# Function to show usage instructions
show_usage() {
    echo -e "${BLUE}📖 Usage Instructions:${NC}"
    echo
    echo "1. Open Cursor IDE"
    echo "2. Navigate to this project directory"
    echo "3. The agents will be automatically available"
    echo "4. Try these example prompts:"
    echo
    echo -e "${YELLOW}📝 General Development:${NC}"
    echo '   "Create a React component for user profiles"'
    echo '   "Design an API for social sharing"'
    echo '   "Write a blog post about our new feature"'
    echo '   "Plan a 6-day sprint for the next release"'
    echo '   "Optimize our app for the App Store"'
    echo
    echo -e "${YELLOW}🏗️ Go Clean Architecture:${NC}"
    echo '   "Create a user service following clean architecture"'
    echo '   "Add JWT authentication middleware"'
    echo '   "Write unit tests for user repository"'
    echo '   "Optimize database queries with GORM"'
    echo '   "Create API documentation for user endpoints"'
    echo
    echo -e "${YELLOW}🛡️ PHP CodeIgniter MVC:${NC}"
    echo '   "Create a user management system"'
    echo '   "Add authentication and authorization"'
    echo '   "Create responsive dashboard views"'
    echo '   "Write unit tests for models"'
    echo '   "Optimize database queries with query builder"'
    echo
    echo -e "${YELLOW}🎨 Design & UX:${NC}"
    echo '   "Design a modern user interface"'
    echo '   "Create a design system guide"'
    echo '   "Conduct user research for feature"'
    echo '   "Create wireframes for mobile app"'
    echo
    echo -e "${YELLOW}📈 Marketing & Content:${NC}"
    echo '   "Write engaging social media content"'
    echo '   "Create marketing strategy for launch"'
    echo '   "Design email campaign template"'
    echo '   "Write technical blog post"'
    echo
    echo -e "${YELLOW}🧠 Memories Feature:${NC}"
    echo '   "Remember our Go Clean Architecture patterns"'
    echo '   "Apply our PHP CodeIgniter MVC standards"'
    echo '   "Use our established security practices"'
    echo '   "Follow our project-specific conventions"'
    echo '   "Adapt to our coding style preferences"'
    echo
    echo -e "${GREEN}🎉 Setup complete! Your Studio AI Agents are ready to use.${NC}"
    echo
}

# Main setup flow
main() {
    echo "Welcome to Studio AI Agents for Cursor setup!"
    echo "This script will help you get everything configured."
    echo

    check_dependencies
    install_mcp_servers
    validate_config
    show_agent_status
    create_sample_project
    show_usage

    echo -e "${GREEN}🎊 Setup completed successfully!${NC}"
    echo
    echo "Next steps:"
    echo "1. Open this project in Cursor IDE"
    echo "2. Try the example prompts above"
    echo "3. Customize agents as needed in .cursor/rules/"
    echo "4. Check .cursor/README.md for detailed documentation"
    echo
}

# Show help if requested
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Studio AI Agents for Cursor - Setup Script"
    echo
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Options:"
    echo "  --help, -h    Show this help message"
    echo "  --validate    Only validate configuration"
    echo "  --status      Show agent status only"
    echo
    exit 0
fi

# Handle specific commands
if [[ "$1" == "--validate" ]]; then
    validate_config
    exit 0
elif [[ "$1" == "--status" ]]; then
    show_agent_status
    exit 0
fi

# Run main setup
main
