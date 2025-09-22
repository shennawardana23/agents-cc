# PHP CodeIgniter Project Blueprint Generator

## Overview

This prompt enables AI to generate complete PHP CodeIgniter project boilerplates with the same architecture, patterns, and structure as the reference project. The blueprint follows enterprise-level patterns with proper separation of concerns, security implementations, and scalable architecture.

## Project Structure Template

```
PROJECT_NAME/
├── application/
│   ├── cache/
│   │   ├── index.html
│   │   └── sessions/
│   ├── config/
│   │   ├── autoload.php
│   │   ├── config.php
│   │   ├── constants.php
│   │   ├── database.php
│   │   ├── routes.php
│   │   └── index.html
│   ├── controllers/
│   │   ├── api/
│   │   ├── Command.php
│   │   ├── Dashboard.php
│   │   ├── Home.php
│   │   ├── Login.php
│   │   ├── User.php
│   │   └── index.html
│   ├── core/
│   │   ├── MY_Controller.php
│   │   └── index.html
│   ├── helpers/
│   │   ├── button_helper.php
│   │   ├── common_helper.php
│   │   ├── debug_helper.php
│   │   ├── memory_helper.php
│   │   ├── privilege_helper.php
│   │   ├── request_helper.php
│   │   ├── template_prototype_helper.php
│   │   ├── upload_helper.php
│   │   ├── uuid_helper.php
│   │   ├── validation_helper.php
│   │   └── index.html
│   ├── libraries/
│   │   ├── Awsconnector.php
│   │   ├── Breadcrumbs.php
│   │   ├── Connectrediscluster.php
│   │   ├── Template.php
│   │   ├── Usermanagement.php
│   │   └── index.html
│   ├── models/
│   │   ├── App_model.php
│   │   ├── Dashboard_model.php
│   │   ├── User_model.php
│   │   └── index.html
│   ├── views/
│   │   ├── dashboard.php
│   │   ├── login.php
│   │   ├── user/
│   │   ├── widgets/
│   │   └── index.html
│   └── widgets/
│       ├── footer.php
│       ├── header.php
│       ├── sidebar.php
│       └── index.html
├── assets/
│   ├── css/
│   ├── js/
│   ├── fonts/
│   ├── plugins/
│   └── scss/
├── system/
├── vendor/
├── composer.json
├── composer.lock
├── index.php
└── README.md
```

## Core Implementation Patterns

### 1. Base Controller (MY_Controller.php)

```php
<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

class MY_Controller extends CI_Controller
{
    private $get_access_master;
    private $slug;

    public function __construct()
    {
        parent::__construct();
        $this->load->model(['user_model', 'app_model'], '', TRUE);
        $this->load->helper(['form', 'url', 'validation']);
        $this->load->library(['form_validation', 'session', 'encryption']);

        $this->set_security_headers();
        $this->enhance_session_security();
        $this->autoDetectSlug();
    }

    private function set_security_headers()
    {
        header('X-Frame-Options: DENY');
        header('X-Content-Type-Options: nosniff');
        header('X-XSS-Protection: 1; mode=block');
        header('Strict-Transport-Security: max-age=31536000; includeSubDomains');
    }

    private function enhance_session_security()
    {
        if ($this->session && method_exists($this->session, 'userdata')) {
            if (!$this->session->userdata('last_regenerate') ||
                time() - $this->session->userdata('last_regenerate') > 300) {
                $this->session->sess_regenerate(TRUE);
                $this->session->set_userdata('last_regenerate', time());
            }
        }
    }

    public function validateAccess(&$data)
    {
        $data['get_access'] = $this->get_access_master;
        if (empty($data['get_access'])) {
            header("location:" . HOMEPAGE);
            die();
        }
    }

    public function send_output($data, $type = "json")
    {
        if ($type == "json") {
            header('Content-type: application/json');
            echo json_encode($data);
            die;
        }
    }

    public function generate_notif($type, $message)
    {
        $notif_class = ($type == 1) ? 'swalDefaultSuccess' : 'swalDefaultError';
        return '<button type="button" class="btn btn-' . $notif_class . '">' . $message . '</button>';
    }
}
```

### 2. Configuration Files

#### config.php

```php
<?php
defined('BASEPATH') or exit('No direct script access allowed');

$config['base_url'] = ("https");
$config['base_url'] .= "://" . $_SERVER['HTTP_HOST'];
$config['base_url'] .= str_replace(basename($_SERVER['SCRIPT_NAME']), "", $_SERVER['SCRIPT_NAME']);

define("HOMEPAGE", $config['base_url']);
$config['index_page'] = '';
$config['uri_protocol'] = 'REQUEST_URI';
$config['charset'] = 'UTF-8';
$config['enable_hooks'] = FALSE;
$config['subclass_prefix'] = 'MY_';
$config['composer_autoload'] = FALSE;
$config['log_threshold'] = 0;
$config['encryption_key'] = 'YOUR_ENCRYPTION_KEY_HERE';

// Session Configuration
$config['sess_driver'] = 'files';
$config['sess_cookie_name'] = 'PROJECT_NAME_session';
$config['sess_expire_on_close'] = FALSE;
$config['sess_expiration'] = 7200;
$config['sess_save_path'] = APPPATH . 'cache/sessions/';
$config['sess_match_ip'] = TRUE;
$config['sess_time_to_update'] = 300;
$config['sess_regenerate_destroy'] = TRUE;

// Database Configuration
$localDBUser = "postgres";
$localDBPassword = "postgres";
$localDBDatabase = "PROJECT_NAME";

if ($_SERVER['SERVER_NAME'] == "localhost" || $_SERVER['SERVER_NAME'] == "PROJECT_NAME.local") {
    DEFINE('DB_HOST', 'localhost');
    DEFINE('DB_USER', $localDBUser);
    DEFINE('DB_PASSWORD', $localDBPassword);
    DEFINE('DB_DATABASE', $localDBDatabase);
} else {
    DEFINE('DB_HOST', 'YOUR_PRODUCTION_HOST');
    DEFINE('DB_USER', 'YOUR_PRODUCTION_USER');
    DEFINE('DB_PASSWORD', 'YOUR_PRODUCTION_PASSWORD');
    DEFINE('DB_DATABASE', 'YOUR_PRODUCTION_DATABASE');
}
```

#### autoload.php

```php
<?php
defined('BASEPATH') or exit('No direct script access allowed');

$autoload['libraries'] = ['template', 'session', 'database', 'usermanagement', 'breadcrumbs'];
$autoload['helper'] = ['url', 'common', 'button_helper', 'uuid_helper', 'memory_helper', 'debug', 'privilege_helper'];
$autoload['model'] = ['app_model'];
$autoload['packages'] = [];
$autoload['drivers'] = [];
$autoload['config'] = [];
$autoload['language'] = [];
```

#### database.php

```php
<?php
defined('BASEPATH') or exit('No direct script access allowed');

$active_group = 'default';
$query_builder = TRUE;

$db['default'] = [
    'dsn' => '',
    'hostname' => DB_HOST,
    'username' => DB_USER,
    'password' => DB_PASSWORD,
    'database' => DB_DATABASE,
    'dbdriver' => 'postgre',
    'dbprefix' => '',
    'pconnect' => FALSE,
    'db_debug' => (ENVIRONMENT !== 'production'),
    'cache_on' => FALSE,
    'char_set' => 'utf8',
    'dbcollat' => 'utf8_general_ci',
    'swap_pre' => '',
    'encrypt' => FALSE,
    'compress' => FALSE,
    'stricton' => FALSE,
    'failover' => [],
    'save_queries' => TRUE,
    'port' => 5432,
    'schema' => 'public'
];
```

#### routes.php

```php
<?php
defined('BASEPATH') or exit('No direct script access allowed');

$route['default_controller'] = 'login';
$route['404_override'] = '';
$route['translate_uri_dashes'] = FALSE;

// Authentication Routes
$route['logout'] = '/login/logout';
$route['login-email'] = '/login/email';
$route['new-user'] = '/login/newuser';
$route['forgot-password'] = '/login/forgot';
$route['change-password'] = '/login/change';

// Main Routes
$route['dashboard'] = '/dashboard';

// User Management Routes
$route['user'] = 'User';
$route['user/get-data'] = 'User/get_data';
$route['user/add'] = 'User/edit';
$route['user/edit/(:any)'] = 'User/edit/$1';
$route['user/delete/(:any)'] = 'User/delete/$1';

// API Routes
$route['api/(:any)'] = 'api/$1';
```

### 3. Helper Files

#### common_helper.php

```php
<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

if (!function_exists('generate_copy_url_input')) {
    function generate_copy_url_input($id, $url) {
        return "<div class='input-group'>
                    <input type='text' class='form-control copy-url-input'
                           id='image" . $id . "' value='" . $url . "' readonly>
                    <div class='input-group-append'>
                        <button class='btn copy-url-button' type='button'
                                onclick='copyToClipboard(\"" . $url . "\", this)'>
                            <i class='fas fa-copy copy-url-icon'></i>
                        </button>
                    </div>
                </div>";
    }
}

if (!function_exists('generate_image_preview')) {
    function generate_image_preview($image_url, $options = []) {
        $defaults = [
            'width' => 160,
            'height' => 120,
            'class' => 'img-preview',
            'alt' => 'Image preview'
        ];

        $settings = array_merge($defaults, $options);

        if (empty($image_url)) {
            return "<div class='empty-preview' style='text-align: center; width: 100%; height: 100%;
                    background-color: #f8f9fa; display: flex; flex-direction: column; align-items: center;
                    justify-content: center; border: 1px dashed #dee2e6; border-radius: 4px;'>
                    <i class='far fa-image' style='font-size: 32px; color: #adb5bd;'></i>
                    <div style='margin-top: 8px; font-size: 12px; color: #6c757d;'>No Image</div>
                </div>";
        }

        return "<img src='" . $image_url . "' class='" . $settings['class'] . "'
                alt='" . $settings['alt'] . "' style='width: " . $settings['width'] . "px;
                height: " . $settings['height'] . "px; object-fit: cover; border-radius: 4px;'>";
    }
}
```

#### button_helper.php

```php
<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

if (!function_exists('generate_action_buttons')) {
    function generate_action_buttons($id, $edit_url = '', $delete_url = '', $view_url = '') {
        $buttons = '';

        if (!empty($view_url)) {
            $buttons .= '<a href="' . $view_url . '" class="btn btn-sm btn-info mr-1" title="View">
                            <i class="fas fa-eye"></i>
                        </a>';
        }

        if (!empty($edit_url)) {
            $buttons .= '<a href="' . $edit_url . '" class="btn btn-sm btn-warning mr-1" title="Edit">
                            <i class="fas fa-edit"></i>
                        </a>';
        }

        if (!empty($delete_url)) {
            $buttons .= '<button type="button" class="btn btn-sm btn-danger" title="Delete"
                            onclick="deleteItem(' . $id . ', \'' . $delete_url . '\')">
                            <i class="fas fa-trash"></i>
                        </button>';
        }

        return $buttons;
    }
}
```

### 4. Library Files

#### Template.php

```php
<?php
if (!defined("BASEPATH")) exit("No direct script access allowed");

class Template {
    private $_template = 'template';
    private $_parser = FALSE;
    private $_cache_ttl = 0;
    private $_widget_path = '';
    private $_ci;
    private $_partials = array();

    public function __construct($config = array()) {
        $this->_ci = & get_instance();
        $this->_widget_path = APPPATH . 'widgets/';

        if (!empty($config)) {
            $this->initialize($config);
        }
    }

    public function initialize($config = array()) {
        foreach ($config as $key => $val) {
            $this->{'_' . $key} = $val;
        }

        if ($this->_widget_path == '') {
            $this->_widget_path = APPPATH . 'widgets/';
        }
    }

    public function view($view, $data = array(), $return = FALSE) {
        $data['content'] = $this->_ci->load->view($view, $data, TRUE);

        if ($return) {
            return $this->_ci->load->view($this->_template, $data, TRUE);
        } else {
            $this->_ci->load->view($this->_template, $data);
        }
    }
}
```

#### Usermanagement.php

```php
<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

class Usermanagement {
    private $CI;

    public function __construct() {
        $this->CI = &get_instance();
        $this->CI->load->model('user_model');
        $this->CI->load->library('session');
    }

    public function get_detail_user($user_id) {
        return $this->CI->user_model->get_user_by_id($user_id);
    }

    public function generate_user_history($user_id, $data) {
        return [
            'user_id' => $user_id,
            'action' => 'user_created',
            'data' => json_encode($data),
            'created_date' => date('Y-m-d H:i:s')
        ];
    }

    public function generate_detail_log($page_title, $id_menu, $message, $new_data, $old_data) {
        return [
            'page_title' => $page_title,
            'id_menu' => $id_menu,
            'message' => $message,
            'new_data' => json_encode($new_data),
            'old_data' => json_encode($old_data),
            'created_date' => date('Y-m-d H:i:s')
        ];
    }
}
```

### 5. Model Files

#### App_model.php

```php
<?php
class App_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function get_data($table, $where = null, $select = '*', $order = null) {
        if ($select !== '*') {
            $this->db->select($select);
        }

        if ($where) {
            $this->db->where($where);
        }

        if ($order) {
            foreach ($order as $field => $direction) {
                $this->db->order_by($field, $direction);
            }
        }

        return $this->db->get($table)->result();
    }

    public function get_detail_data($id, $field, $table) {
        $this->db->where($field, $id);
        return $this->db->get($table)->first_row();
    }

    public function save_data($data, $table) {
        $this->db->insert($table, $data);
        return $this->db->insert_id();
    }

    public function update_data($id, $data, $field, $table) {
        $this->db->where($field, $id);
        return $this->db->update($table, $data);
    }

    public function delete_data($id, $field, $table) {
        $this->db->where($field, $id);
        return $this->db->delete($table);
    }

    public function generate_uuid() {
        return sprintf('%04x%04x-%04x-%04x-%04x-%04x%04x%04x',
            mt_rand(0, 0xffff), mt_rand(0, 0xffff),
            mt_rand(0, 0xffff),
            mt_rand(0, 0x0fff) | 0x4000,
            mt_rand(0, 0x3fff) | 0x8000,
            mt_rand(0, 0xffff), mt_rand(0, 0xffff), mt_rand(0, 0xffff)
        );
    }
}
```

### 6. Controller Files

#### Login.php

```php
<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Login extends MY_Controller {
    const EXPIRED_TIME_COOKIE = 28800; // 8 hours
    const EXPIRED_TIME_TOKEN = 86400; // 1 Day

    public function __construct() {
        parent::__construct();
        $this->load->helper(['form', 'url', 'captcha', 'cookie']);
        $this->load->library(['form_validation', 'Connectrediscluster']);
    }

    public function index() {
        $data['title'] = 'Login';
        $data['page_title'] = 'User Authentication';

        if ($this->input->post()) {
            $this->form_validation->set_rules('email', 'Email', 'required|valid_email');
            $this->form_validation->set_rules('password', 'Password', 'required');

            if ($this->form_validation->run()) {
                $email = $this->input->post('email');
                $password = $this->input->post('password');

                $user = $this->user_model->get_user_by_email_password($email, $password);

                if ($user) {
                    $this->session->set_userdata('user_id', $user->id);
                    $this->session->set_userdata('user_email', $user->email);
                    $this->session->set_userdata('user_name', $user->name);

                    redirect('dashboard');
                } else {
                    $data['error'] = 'Invalid email or password';
                }
            }
        }

        $this->load->view('login', $data);
    }

    public function logout() {
        $this->session->sess_destroy();
        redirect('login');
    }
}
```

#### Dashboard.php

```php
<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Dashboard extends MY_Controller {

    public function __construct() {
        parent::__construct();
        $this->validateAccess($this->data);
    }

    public function index() {
        $data['title'] = 'Dashboard';
        $data['page_title'] = 'Welcome to Dashboard';

        // Get user access data
        $this->getMenu($data);

        // Load dashboard data
        $data['total_users'] = $this->dashboard_model->get_total_users();
        $data['total_projects'] = $this->dashboard_model->get_total_projects();
        $data['recent_activities'] = $this->dashboard_model->get_recent_activities();

        $this->template->view('dashboard', $data);
    }
}
```

### 7. View Files

#### login.php

```php
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= $title ?></title>
    <link rel="stylesheet" href="<?= base_url('assets/css/style.css') ?>">
    <link rel="stylesheet" href="<?= base_url('assets/plugins/bootstrap/css/bootstrap.min.css') ?>">
</head>
<body class="login-page">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="login-form">
                    <h2 class="text-center mb-4"><?= $page_title ?></h2>

                    <?php if (isset($error)): ?>
                        <div class="alert alert-danger"><?= $error ?></div>
                    <?php endif; ?>

                    <?= form_open('login', ['class' => 'needs-validation', 'novalidate' => '']) ?>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>

                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>

                        <button type="submit" class="btn btn-primary btn-block">Login</button>
                    <?= form_close() ?>
                </div>
            </div>
        </div>
    </div>

    <script src="<?= base_url('assets/plugins/jquery/jquery.min.js') ?>"></script>
    <script src="<?= base_url('assets/plugins/bootstrap/js/bootstrap.min.js') ?>"></script>
</body>
</html>
```

#### dashboard.php

```php
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= $title ?></title>
    <link rel="stylesheet" href="<?= base_url('assets/css/style.css') ?>">
    <link rel="stylesheet" href="<?= base_url('assets/plugins/bootstrap/css/bootstrap.min.css') ?>">
    <link rel="stylesheet" href="<?= base_url('assets/plugins/fontawesome/css/all.min.css') ?>">
</head>
<body>
    <?php $this->load->view('widgets/header'); ?>
    <?php $this->load->view('widgets/sidebar'); ?>

    <div class="main-content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <h1 class="page-title"><?= $page_title ?></h1>
                </div>
            </div>

            <div class="row">
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-content">
                            <h3><?= $total_users ?></h3>
                            <p>Total Users</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-project-diagram"></i>
                        </div>
                        <div class="stat-content">
                            <h3><?= $total_projects ?></h3>
                            <p>Total Projects</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h5>Recent Activities</h5>
                        </div>
                        <div class="card-body">
                            <?php if (!empty($recent_activities)): ?>
                                <ul class="activity-list">
                                    <?php foreach ($recent_activities as $activity): ?>
                                        <li class="activity-item">
                                            <span class="activity-time"><?= date('M d, H:i', strtotime($activity->created_date)) ?></span>
                                            <span class="activity-text"><?= $activity->description ?></span>
                                        </li>
                                    <?php endforeach; ?>
                                </ul>
                            <?php else: ?>
                                <p class="text-muted">No recent activities</p>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <?php $this->load->view('widgets/footer'); ?>

    <script src="<?= base_url('assets/plugins/jquery/jquery.min.js') ?>"></script>
    <script src="<?= base_url('assets/plugins/bootstrap/js/bootstrap.min.js') ?>"></script>
</body>
</html>
```

### 8. Widget Files

#### header.php

```php
<header class="main-header">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="<?= base_url('dashboard') ?>">
                <?= PROJECT_NAME ?>
            </a>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                           data-toggle="dropdown">
                            <i class="fas fa-user"></i> <?= $this->session->userdata('user_name') ?>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right">
                            <a class="dropdown-item" href="<?= base_url('profile') ?>">
                                <i class="fas fa-user-cog"></i> Profile
                            </a>
                            <a class="dropdown-item" href="<?= base_url('change-password') ?>">
                                <i class="fas fa-key"></i> Change Password
                            </a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="<?= base_url('logout') ?>">
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>
```

#### sidebar.php

```php
<aside class="main-sidebar">
    <div class="sidebar-content">
        <nav class="sidebar-nav">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="<?= base_url('dashboard') ?>">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="<?= base_url('user') ?>">
                        <i class="fas fa-users"></i> User Management
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="<?= base_url('project') ?>">
                        <i class="fas fa-project-diagram"></i> Projects
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="<?= base_url('settings') ?>">
                        <i class="fas fa-cog"></i> Settings
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</aside>
```

### 9. Composer Configuration

#### composer.json

```json
{
    "description": "PROJECT_NAME - CodeIgniter Application",
    "name": "vendor/PROJECT_NAME",
    "type": "project",
    "license": "MIT",
    "require": {
        "php": ">=7.4",
        "predis/predis": "^1.1",
        "aws/aws-sdk-php": "^3.293",
        "ramsey/uuid": "^4.2",
        "vlucas/phpdotenv": "^5.6",
        "guzzlehttp/guzzle": "^7.0",
        "league/flysystem": "^2.0",
        "league/flysystem-aws-s3-v3": "^2.0",
        "monolog/monolog": "^2.0"
    },
    "require-dev": {
        "phpunit/phpunit": "^9.0",
        "mockery/mockery": "^1.4"
    },
    "autoload": {
        "psr-4": {
            "App\\": "application/"
        }
    },
    "scripts": {
        "test": "phpunit",
        "post-install-cmd": [
            "php -r \"copy('.env.example', '.env');\""
        ]
    }
}
```

### 10. Main Index File

#### index.php

```php
<?php
define('ENVIRONMENT', isset($_SERVER['CI_ENV']) ? $_SERVER['CI_ENV'] : 'development');

switch (ENVIRONMENT) {
    case 'development':
        error_reporting(-1);
        ini_set('display_errors', 1);
        break;
    case 'testing':
    case 'production':
        ini_set('display_errors', 0);
        if (version_compare(PHP_VERSION, '7.4', '>=')) {
            error_reporting(E_ALL & ~E_NOTICE & ~E_DEPRECATED & ~E_STRICT & ~E_USER_NOTICE & ~E_USER_DEPRECATED);
        } else {
            error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_USER_NOTICE);
        }
        break;
    default:
        header('HTTP/1.1 503 Service Unavailable.', TRUE, 503);
        echo 'The application environment is not set correctly.';
        exit(1);
}

$system_path = 'system';
$application_folder = 'application';
$view_folder = '';

if (defined('STDIN')) {
    chdir(dirname(__FILE__));
}

if (($_temp = realpath($system_path)) !== FALSE) {
    $system_path = $_temp.DIRECTORY_SEPARATOR;
} else {
    $system_path = strtr(
        rtrim($system_path, '/\\'),
        '/\\',
        DIRECTORY_SEPARATOR.DIRECTORY_SEPARATOR
    ).DIRECTORY_SEPARATOR;
}

if (!is_dir($system_path)) {
    header('HTTP/1.1 503 Service Unavailable.', TRUE, 503);
    echo 'Your system folder path does not appear to be set correctly. Please open the following file and correct this: '.pathinfo(__FILE__, PATHINFO_BASENAME);
    exit(3);
}

define('SELF', pathinfo(__FILE__, PATHINFO_BASENAME));
define('BASEPATH', $system_path);
define('FCPATH', dirname(__FILE__).DIRECTORY_SEPARATOR);
define('SYSDIR', basename(BASEPATH));

if (is_dir($application_folder)) {
    if (($_temp = realpath($application_folder)) !== FALSE) {
        $application_folder = $_temp;
    } else {
        $application_folder = strtr(
            rtrim($application_folder, '/\\'),
            '/\\',
            DIRECTORY_SEPARATOR.DIRECTORY_SEPARATOR
        );
    }
} elseif (is_dir(BASEPATH.$application_folder.DIRECTORY_SEPARATOR)) {
    $application_folder = BASEPATH.strtr(
        trim($application_folder, '/\\'),
        '/\\',
        DIRECTORY_SEPARATOR.DIRECTORY_SEPARATOR
    );
} else {
    header('HTTP/1.1 503 Service Unavailable.', TRUE, 503);
    echo 'Your application folder path does not appear to be set correctly. Please open the following file and correct this: '.SELF;
    exit(3);
}

define('APPPATH', $application_folder.DIRECTORY_SEPARATOR);

if (!isset($view_folder[0]) && is_dir(APPPATH.'views'.DIRECTORY_SEPARATOR)) {
    $view_folder = APPPATH.'views';
} elseif (is_dir($view_folder)) {
    if (($_temp = realpath($view_folder)) !== FALSE) {
        $view_folder = $_temp;
    } else {
        $view_folder = strtr(
            rtrim($view_folder, '/\\'),
            '/\\',
            DIRECTORY_SEPARATOR.DIRECTORY_SEPARATOR
        );
    }
} elseif (is_dir(APPPATH.$view_folder.DIRECTORY_SEPARATOR)) {
    $view_folder = APPPATH.strtr(
        trim($view_folder, '/\\'),
        '/\\',
        DIRECTORY_SEPARATOR.DIRECTORY_SEPARATOR
    );
} else {
    header('HTTP/1.1 503 Service Unavailable.', TRUE, 503);
    echo 'Your view folder path does not appear to be set correctly. Please open the following file and correct this: '.SELF;
    exit(3);
}

define('VIEWPATH', $view_folder.DIRECTORY_SEPARATOR);

require_once BASEPATH.'core/CodeIgniter.php';
```

## Implementation Instructions for AI

### 1. Project Generation Steps

1. **Replace Placeholders**: Replace all instances of `PROJECT_NAME` with the actual project name
2. **Generate Encryption Keys**: Create unique encryption keys for each project
3. **Customize Database**: Update database configuration for the specific project
4. **Modify Routes**: Adjust routes based on project requirements
5. **Customize Controllers**: Modify controller logic for specific business needs
6. **Update Views**: Customize view templates for project branding
7. **Configure Assets**: Set up CSS, JS, and other assets

### 2. Security Considerations

- Always use HTTPS in production
- Implement proper session management
- Use CSRF protection
- Validate and sanitize all inputs
- Implement proper access control
- Use prepared statements for database queries
- Set secure headers

### 3. Performance Optimization

- Enable caching where appropriate
- Use database indexing
- Implement lazy loading
- Optimize database queries
- Use CDN for static assets
- Implement proper error logging

### 4. Testing Requirements

- Unit tests for models
- Integration tests for controllers
- Frontend testing for views
- Security testing for authentication
- Performance testing for critical paths

This blueprint provides a complete foundation for generating enterprise-grade PHP CodeIgniter applications with proper architecture, security, and scalability patterns.
