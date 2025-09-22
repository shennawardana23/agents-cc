# Go Project Boilerplate Generator Prompt

## 🎯 Project Overview

You are an AI assistant that generates Go project boilerplates following the **Clean Architecture** pattern with **Gin Framework**. Your task is to create a complete, production-ready Go project structure enterprise applications.

## 🏗️ Project Structure Requirements

### Root Directory Structure

```
{PROJECT_NAME}/
├── .git/
├── .gitignore
├── .air.toml
├── .env
├── .env.example
├── Dockerfile
├── Dockerfile_golang
├── Makefile
├── README.md
├── buildspec.yml
├── go.mod
├── go.sum
├── main
├── cmd/
├── internal/
├── scripts/
├── tests/
└── api/
```

### Core Directories

#### `cmd/` - Application Entry Points

```
cmd/
├── main.go
├── config/
│   ├── config.go
│   └── environment.go
└── docs/
    └── docs.go
```

#### `internal/` - Core Application Logic

```
internal/
├── app/
│   ├── database/
│   │   ├── database.go
│   │   ├── postgres.go
│   │   └── redis.go
│   ├── middleware/
│   │   ├── http_middleware.go
│   │   ├── http_jwt_auth.go
│   │   ├── http_basic_auth.go
│   │   ├── http_whitelist.go
│   │   ├── security_headers.go
│   │   ├── cors.go
│   │   ├── logger.go
│   │   ├── session.go
│   │   └── http_pre_handle.go
│   ├── sentry/
│   │   └── sentry.go
│   └── newrelic/
│       └── newrelic.go
├── controller/
│   ├── base_controller.go
│   ├── user_controller.go
│   ├── project_controller.go
│   └── health_controller.go
├── service/
│   ├── base_service.go
│   ├── user_service.go
│   ├── project_service.go
│   └── health_service.go
├── repository/
│   ├── base_repository.go
│   ├── user_repository.go
│   ├── project_repository.go
│   └── mocks/
├── entity/
│   ├── user.go
│   ├── project.go
│   └── base_entity.go
├── model/
│   └── api/
│       ├── api_request.go
│       ├── api_response.go
│       ├── user_request.go
│       ├── user_response.go
│       ├── project_request.go
│       └── project_response.go
├── converter/
│   ├── user_converter.go
│   └── project_converter.go
├── routes/
│   └── router.go
├── outbound/
│   ├── google_chat.go
│   └── email.go
├── state/
│   └── state.go
├── util/
└── docs/
```

#### `internal/util/` - Utility Packages

```
internal/util/
├── authentication/
│   └── authentication.go
├── cache/
│   └── cache.go
├── common/
│   └── common.go
├── constants/
│   └── constants.go
├── converter/
├── date/
│   └── date.go
├── datatype/
│   ├── set.go
│   └── map.go
├── encryption/
│   └── encryption.go
├── exception/
│   └── exception.go
├── exceptioncode/
│   └── exceptioncode.go
├── helper/
│   ├── helper.go
│   └── array/
│       └── array.go
├── httphelper/
│   ├── httphelper.go
│   ├── basic_auth_helper.go
│   └── whitelist_helper.go
├── json/
│   └── json.go
├── logger/
│   └── logger.go
├── password/
│   └── password.go
├── queryhelper/
│   ├── builder.go
│   ├── where.go
│   ├── order_by.go
│   ├── group_by.go
│   ├── pagination.go
│   └── helper.go
├── sort/
│   └── sort.go
├── template/
│   └── template.go
├── validator/
│   └── validator.go
└── alert/
    └── alert.go
```

## 🚀 Technology Stack

### Core Dependencies

```go
// go.mod requirements
module {PROJECT_NAME}

go 1.23.0

require (
    // HTTP Framework
    github.com/gin-gonic/gin v1.9.1
    
    // Database
    github.com/lib/pq v1.10.9
    github.com/go-sql-driver/mysql v1.7.1
    
    // Cache
    github.com/redis/go-redis/v9 v9.3.0
    
    // Authentication
    github.com/golang-jwt/jwt/v5 v5.2.0
    golang.org/x/crypto v0.40.0
    
    // Validation
    github.com/go-playground/validator/v10 v10.19.0
    
    // Logging & Monitoring
    github.com/sirupsen/logrus v1.9.3
    github.com/getsentry/sentry-go v0.25.0
    github.com/newrelic/go-agent/v3 v3.28.0
    
    // AWS
    github.com/aws/aws-lambda-go v1.41.0
    github.com/apex/gateway/v2 v2.0.0
    
    // Utilities
    github.com/google/uuid v1.6.0
    github.com/joho/godotenv v1.5.1
    github.com/rs/cors v1.10.1
    
    // Testing
    github.com/stretchr/testify v1.10.0
    github.com/golang/mock v1.6.0
)
```

## 💻 Code Structure & Implementation Patterns

### 1. Dependency Injection & Interface Design

#### Base Interfaces

```go
// internal/repository/base_repository.go
package repository

import (
    "context"
    "database/sql"
)

type BaseRepository interface {
    SetSchema(ctx context.Context, q database.Q, schema string)
    GetDB() database.Q
}

type baseRepository struct {
    db database.Q
}

func NewBaseRepository(db database.Q) BaseRepository {
    return &baseRepository{db: db}
}

func (r *baseRepository) SetSchema(ctx context.Context, q database.Q, schema string) {
    // Implementation for setting database schema
}

func (r *baseRepository) GetDB() database.Q {
    return r.db
}
```

#### Repository Pattern

```go
// internal/repository/user_repository.go
package repository

import (
    "context"
    "centralized-user-permissions-service/internal/entity"
    "centralized-user-permissions-service/internal/app/database"
    "centralized-user-permissions-service/internal/util/exception"
    querybuilder "centralized-user-permissions-service/internal/util/queryhelper"
)

type UserRepository interface {
    FindAllUsers(ctx context.Context, q database.Q) ([]entity.User, error)
    FindUserByID(ctx context.Context, q database.Q, id string) (entity.User, error)
    FindUserByEmail(ctx context.Context, q database.Q, email string) (entity.User, error)
    CreateUser(ctx context.Context, q database.Q, user *entity.User) error
    UpdateUser(ctx context.Context, q database.Q, user *entity.User) error
    DeleteUser(ctx context.Context, q database.Q, id string) error
}

type userRepository struct {
    BaseRepository
}

func NewUserRepository() UserRepository {
    return &userRepository{}
}

func (r *userRepository) FindAllUsers(ctx context.Context, q database.Q) ([]entity.User, error) {
    r.SetSchema(ctx, q, "permissions")
    
    qb := querybuilder.NewBuilder(`SELECT 
        id, full_name, picture, email, password, phone, 
        status, created_date, updated_date, created_by, updated_by 
        FROM users`).Where(`status = ?`, 1)
    
    rows, err := q.QueryContext(ctx, qb.Build(), qb.Values()...)
    if err != nil {
        return nil, exception.TranslatePostgresError(ctx, err)
    }
    defer rows.Close()
    
    var users []entity.User
    for rows.Next() {
        var user entity.User
        err := rows.Scan(
            &user.ID, &user.FullName, &user.Picture, &user.Email,
            &user.Password, &user.Phone, &user.Status, &user.CreatedDate,
            &user.UpdatedDate, &user.CreatedBy, &user.UpdatedBy,
        )
        if err != nil {
            return nil, exception.TranslatePostgresError(ctx, err)
        }
        users = append(users, user)
    }
    
    return users, nil
}
```

### 2. Service Layer Implementation

#### Service Interface & Implementation

```go
// internal/service/user_service.go
package service

import (
    "context"
    "centralized-user-permissions-service/internal/entity"
    "centralized-user-permissions-service/internal/model/api"
    "centralized-user-permissions-service/internal/repository"
    "centralized-user-permissions-service/internal/util/cache"
    "centralized-user-permissions-service/internal/util/logger"
    "github.com/go-playground/validator/v10"
)

type UserService interface {
    FindAllUsers(ctx context.Context, req api.FindAllUsersRequest) (api.FindAllUsersResponse, error)
    FindUserByID(ctx context.Context, req api.FindUserDetailByIDRequest) (api.FindUserDetailResponse, error)
    CreateUser(ctx context.Context, req api.CreateUserRequest) (api.CreateUserResponse, error)
    UpdateUser(ctx context.Context, req api.UpdateUserRequest) (api.UpdateUserResponse, error)
    DeleteUser(ctx context.Context, req api.DeleteUserRequest) error
}

type userService struct {
    userRepository repository.UserRepository
    projectRepository repository.ProjectRepository
    db database.DB
    redisCache cache.RedisCache
    validate *validator.Validate
}

func NewUserService(
    userRepository repository.UserRepository,
    projectRepository repository.ProjectRepository,
    db database.DB,
    redisCache cache.RedisCache,
    validator *validator.Validate,
) UserService {
    return &userService{
        userRepository: userRepository,
        projectRepository: projectRepository,
        db: db,
        redisCache: redisCache,
        validate: validator,
    }
}

func (s *userService) FindAllUsers(ctx context.Context, req api.FindAllUsersRequest) (api.FindAllUsersResponse, error) {
    // Check cache first
    cacheKey := fmt.Sprintf("users:%s:%s", req.ProjectKey, req.Host)
    var users []entity.User
    err := s.redisCache.Get(ctx, cacheKey, &users)
    
    if err != nil || len(users) == 0 {
        // Get from database
        users, err = s.userRepository.FindAllUsers(ctx, s.db)
        if err != nil {
            logger.Errorf(ctx, "Failed to get users: %v", err)
            return api.FindAllUsersResponse{}, err
        }
        
        // Cache the result
        if err := s.redisCache.Set(ctx, cacheKey, users, 30*time.Minute); err != nil {
            logger.Warnf(ctx, "Failed to cache users: %v", err)
        }
    }
    
    return converter.ToUserList(ctx, users), nil
}
```

### 3. Controller Layer Implementation

#### Controller Interface & Implementation

```go
// internal/controller/user_controller.go
package controller

import (
    "centralized-user-permissions-service/internal/model/api"
    "centralized-user-permissions-service/internal/service"
    "centralized-user-permissions-service/internal/util/authentication"
    "centralized-user-permissions-service/internal/util/exceptioncode"
    "centralized-user-permissions-service/internal/util/httphelper"
    "centralized-user-permissions-service/internal/util/logger"
    "centralized-user-permissions-service/internal/util/validator"
    "github.com/gin-gonic/gin"
)

type UserController interface {
    FindAllUsers(c *gin.Context)
    FindUserByID(c *gin.Context)
    CreateUser(c *gin.Context)
    UpdateUser(c *gin.Context)
    DeleteUser(c *gin.Context)
}

type userController struct {
    service service.UserService
}

func NewUserController(service service.UserService) UserController {
    return &userController{
        service: service,
    }
}

// FindAllUsers godoc
// @Summary Find All Users
// @Description Find all users with optional filtering
// @Tags User
// @Accept json
// @Produce json
// @Param project_key query string true "Project Key"
// @Param host query string true "Host"
// @Success 200 {object} api.ApiResponse{data=api.FindAllUsersResponse}
// @Failure 400 {object} api.ApiResponse
// @Failure 500 {object} api.ApiResponse
// @Router /api/users [get]
// @Security BasicAuth
func (c *userController) FindAllUsers(ctx *gin.Context) {
    requestCtx := logger.StartTransactionWithFuncName(ctx.Writer, ctx.Request)
    
    requestData := api.FindAllUsersRequest{
        Host: httphelper.GetHostString(ctx.Request),
    }
    
    err := httphelper.Read(ctx.Request, &requestData)
    if err != nil {
        httphelper.WriteError(requestCtx, ctx.Writer, err)
        return
    }
    
    err = validator.Validate(requestData)
    if err != nil {
        logger.Error(requestCtx, err)
        httphelper.WriteError(requestCtx, ctx.Writer, api.ErrorResponse{
            Message: err.Error(),
        })
        return
    }
    
    response, err := c.service.FindAllUsers(requestCtx, requestData)
    if err != nil {
        httphelper.WriteError(requestCtx, ctx.Writer, err)
        return
    }
    
    httphelper.Write(requestCtx, ctx.Writer, response)
}
```

### 4. Entity & Model Definitions

#### Entity Structure

```go
// internal/entity/user.go
package entity

import (
    "database/sql"
    "time"
)

type User struct {
    ID          string         `db:"id"`
    FullName    string         `db:"full_name"`
    Picture     sql.NullString `db:"picture"`
    Email       string         `db:"email"`
    Password    sql.NullString `db:"password"`
    Phone       sql.NullString `db:"phone"`
    Status      int64          `db:"status"`
    CreatedDate time.Time      `db:"created_date"`
    UpdatedDate time.Time      `db:"updated_date"`
    CreatedBy   sql.NullString `db:"created_by"`
    UpdatedBy   sql.NullString `db:"updated_by"`
}

func (u *User) IsActive() bool {
    return u.Status == 1
}

func (u *User) HasPicture() bool {
    return u.Picture.Valid && u.Picture.String != ""
}
```

#### API Request/Response Models

```go
// internal/model/api/user_request.go
package api

// swagger:parameters find all users
type FindAllUsersRequest struct {
    UserID     string `schema:"user_id,omitempty"`
    ProjectKey string `schema:"project_key,omitempty"`
    Host       string `schema:"host,omitempty"`
}

// swagger:parameters create user
type CreateUserRequest struct {
    FullName string `json:"full_name" validate:"required,min=2,max=100"`
    Email    string `json:"email" validate:"required,email"`
    Password string `json:"password" validate:"required,min=8"`
    Phone    string `json:"phone,omitempty" validate:"omitempty,len=10"`
}

// internal/model/api/user_response.go
package api

// swagger:response user detail response
type FindUserDetailResponse struct {
    ID          string    `json:"id"`
    FullName    string    `json:"full_name"`
    Picture     *string   `json:"picture,omitempty"`
    Email       string    `json:"email"`
    Phone       *string   `json:"phone,omitempty"`
    Status      int64     `json:"status"`
    CreatedDate time.Time `json:"created_date"`
    UpdatedDate time.Time `json:"updated_date"`
}

// swagger:response users list response
type FindAllUsersResponse struct {
    List  []FindUserDetailResponse `json:"list"`
    Total int64                    `json:"total"`
}
```

### 5. Router & Dependency Injection

#### Router Setup with DI

```go
// internal/routes/router.go
package routes

import (
    "centralized-user-permissions-service/internal/app/database"
    "centralized-user-permissions-service/internal/app/middleware"
    "centralized-user-permissions-service/internal/controller"
    "centralized-user-permissions-service/internal/repository"
    "centralized-user-permissions-service/internal/service"
    "centralized-user-permissions-service/internal/util/cache"
    "centralized-user-permissions-service/internal/util/validator"
    "github.com/gin-gonic/gin"
)

func NewRouters() *gin.Engine {
    // Initialize dependencies
    db := database.NewDB()
    rdb := database.NewRedisDB()
    redisCache := cache.NewRedisCache(rdb)
    validate := validator.New()
    
    // Initialize repositories
    userRepository := repository.NewUserRepository()
    projectRepository := repository.NewProjectRepository()
    
    // Initialize services with dependencies
    userService := service.NewUserService(userRepository, projectRepository, db, redisCache, validate)
    projectService := service.NewProjectService(projectRepository, userRepository, db, redisCache, validate)
    
    // Initialize controllers with services
    userController := controller.NewUserController(userService)
    projectController := controller.NewProjectController(projectService)
    
    // Setup router with middleware
    router := gin.New()
    router.Use(gin.Recovery())
    router.Use(middleware.Logger())
    router.Use(middleware.SecurityHeadersMiddleware())
    router.Use(middleware.CORSMiddleware())
    
    // API routes
    api := router.Group("/api")
    {
        // User routes
        api.GET("/users", middleware.BasicAuth(userController.FindAllUsers))
        api.GET("/user/:id", middleware.JWTAuth(userController.FindUserByID))
        api.POST("/users", middleware.BasicAuth(userController.CreateUser))
        api.PUT("/user/:id", middleware.JWTAuth(userController.UpdateUser))
        api.DELETE("/user/:id", middleware.JWTAuth(userController.DeleteUser))
        
        // Project routes
        api.GET("/projects", middleware.BasicAuth(projectController.FindAllProjects))
        api.GET("/project/:id", middleware.JWTAuth(projectController.FindProjectByID))
    }
    
    return router
}
```

### 6. Middleware Implementation

#### JWT Authentication Middleware

```go
// internal/app/middleware/http_jwt_auth.go
package middleware

import (
    "centralized-user-permissions-service/internal/util/authentication"
    "centralized-user-permissions-service/internal/util/exceptioncode"
    "github.com/gin-gonic/gin"
    "net/http"
    "strings"
)

func JWTAuth() gin.HandlerFunc {
    return func(c *gin.Context) {
        authHeader := c.GetHeader("Authorization")
        if authHeader == "" {
            c.JSON(http.StatusUnauthorized, gin.H{
                "success": false,
                "message": "Authorization header required",
                "error_code": exceptioncode.CodeUnauthorized,
            })
            c.Abort()
            return
        }
        
        // Extract token from "Bearer <token>"
        tokenParts := strings.Split(authHeader, " ")
        if len(tokenParts) != 2 || tokenParts[0] != "Bearer" {
            c.JSON(http.StatusUnauthorized, gin.H{
                "success": false,
                "message": "Invalid authorization format",
                "error_code": exceptioncode.CodeUnauthorized,
            })
            c.Abort()
            return
        }
        
        token := tokenParts[1]
        payload, err := authentication.VerifyToken(token)
        if err != nil {
            c.JSON(http.StatusUnauthorized, gin.H{
                "success": false,
                "message": "Invalid or expired token",
                "error_code": exceptioncode.CodeTokenInvalid,
            })
            c.Abort()
            return
        }
        
        // Set user context
        c.Set("user", payload)
        c.Next()
    }
}
```

### 7. Utility Package Examples

#### Cache Implementation

```go
// internal/util/cache/cache.go
package cache

import (
    "context"
    "encoding/json"
    "time"
    "github.com/redis/go-redis/v9"
)

type RedisCache interface {
    Get(ctx context.Context, key string, dest interface{}) error
    Set(ctx context.Context, key string, value interface{}, ttl ...time.Duration) error
    Delete(ctx context.Context, key string) error
    DeletePattern(ctx context.Context, pattern string) error
}

type RedisCacheImpl struct {
    client *redis.Client
}

func NewRedisCache(client *redis.Client) RedisCache {
    return &RedisCacheImpl{client: client}
}

func (r *RedisCacheImpl) Get(ctx context.Context, key string, dest interface{}) error {
    val, err := r.client.Get(ctx, key).Result()
    if err != nil {
        return err
    }
    
    return json.Unmarshal([]byte(val), dest)
}

func (r *RedisCacheImpl) Set(ctx context.Context, key string, value interface{}, ttl ...time.Duration) error {
    data, err := json.Marshal(value)
    if err != nil {
        return err
    }
    
    exp := 24 * time.Hour // default TTL
    if len(ttl) > 0 {
        exp = ttl[0]
    }
    
    return r.client.Set(ctx, key, string(data), exp).Err()
}
```

#### Query Builder

```go
// internal/util/queryhelper/builder.go
package querybuilder

import (
    "fmt"
    "strings"
)

type QueryBuilder struct {
    baseQuery    string
    whereQuery   string
    orderByQuery string
    limitQuery   string
    offsetQuery  string
    groupByQuery string
    values       []interface{}
}

func NewBuilder(query string, values ...interface{}) *QueryBuilder {
    return &QueryBuilder{
        baseQuery: query,
        values:    values,
    }
}

func (qb *QueryBuilder) Where(query string, values ...interface{}) *QueryBuilder {
    if len(values) > 0 {
        qb.AppendValues(values...)
    }
    qb.whereQuery = fmt.Sprintf(" WHERE %s", query)
    return qb
}

func (qb *QueryBuilder) Build() string {
    queries := []string{qb.baseQuery, qb.whereQuery, qb.groupByQuery, qb.orderByQuery, qb.limitQuery, qb.offsetQuery}
    return strings.Join(queries, " ")
}

func (qb *QueryBuilder) Values() []interface{} {
    return qb.values
}
```

## 🛠️ Complete Utility Package Reference

### **Utility Package Structure & Purpose**

The `/util` folder contains all reusable utility functions organized by functionality. Each package serves a specific purpose and follows Go best practices.

#### **1. Authentication Utilities (`internal/util/authentication/`)**

**Purpose**: JWT token management and authentication helpers

**Key Files**:

- `authentication.go` - JWT token creation, verification, and claim extraction

**Key Functions**:

```go
// Create JWT token with custom claims
func CreateToken(projectKey string, userID string, expiration time.Duration) (string, error)

// Verify JWT token and extract claims
func VerifyToken(tokenString string) (*Payload, error)

// Extract specific claims from token
func ExtractClaim(tokenString string, claimName string) (interface{}, error)
```

**Usage Example**:

```go
// In middleware or service
token, err := authentication.CreateToken("my-project", "user123", 24*time.Hour)
if err != nil {
    return err
}

payload, err := authentication.VerifyToken(token)
if err != nil {
    return err
}
```

#### **2. Cache Management (`internal/util/cache/`)**

**Purpose**: Redis caching operations with JSON serialization

**Key Files**:

- `cache.go` - Redis cache interface and implementation

**Key Functions**:

```go
// Get value from cache
func (r *RedisCacheImpl) Get(ctx context.Context, key string, dest interface{}) error

// Set value in cache with TTL
func (r *RedisCacheImpl) Set(ctx context.Context, key string, value interface{}, ttl ...time.Duration) error

// Delete cache key
func (r *RedisCacheImpl) Delete(ctx context.Context, key string) error

// Delete multiple keys by pattern
func (r *RedisCacheImpl) DeletePattern(ctx context.Context, pattern string) error
```

**Usage Example**:

```go
// Cache user data
err := redisCache.Set(ctx, "user:123", userData, 30*time.Minute)
if err != nil {
    log.Warn("Failed to cache user data")
}

// Retrieve cached data
var userData User
err = redisCache.Get(ctx, "user:123", &userData)
```

#### **3. Common Utilities (`internal/util/common/`)**

**Purpose**: General-purpose utility functions

**Key Files**:

- `common.go` - Environment variables, validation, and common helpers

**Key Functions**:

```go
// Get environment variable with default
func GetEnv(key, defaultValue string) string

// Get application name
func GetAppName() string

// Get calling function name
func FuncCallerName() string

// Validate unsigned integer
func IsUnsignedInt(value string) bool

// Validate alphabet characters
func IsAlphabet(value string) bool

// Validate numeric characters
func IsNumeric(value string) bool
```

**Usage Example**:

```go
// Get database URL from environment
dbURL := common.GetEnv("DATABASE_URL", "postgres://localhost:5432/mydb")

// Validate user input
if !common.IsAlphabet(userName) {
    return errors.New("username must contain only letters")
}
```

#### **4. Constants (`internal/util/constants/`)**

**Purpose**: Application-wide constants and configuration values

**Key Files**:

- `constants.go` - Database settings, Redis TTLs, schema names, webhook templates

**Key Constants**:

```go
// Database connection settings
const (
    MaxOpenConns = 25
    MaxIdleConns = 25
    ConnMaxLifetime = 5 * time.Minute
)

// Redis TTL values
const (
    RedisTTLUser = 30 * time.Minute
    RedisTTLProject = 1 * time.Hour
    RedisTTLMenu = 24 * time.Hour
)

// Database schemas
const (
    SchemaPermissions = "permissions"
    SchemaAudit = "audit"
)
```

**Usage Example**:

```go
// Use constants in database operations
db.SetMaxOpenConns(constants.MaxOpenConns)
db.SetMaxIdleConns(constants.MaxIdleConns)

// Use schema constants
r.SetSchema(ctx, q, constants.SchemaPermissions)
```

#### **5. Date & Time Utilities (`internal/util/date/`)**

**Purpose**: Date and time formatting, parsing, and timezone handling

**Key Files**:

- `date.go` - Jakarta timezone utilities and date formatting

**Key Functions**:

```go
// Get Jakarta timezone location
func JakartaTimeLoc() *time.Location

// Get current time in Jakarta timezone
func JakartaNow() time.Time

// Parse date string
func ParseDate(dateStr string) (time.Time, error)

// Format date to string
func FormatDate(date time.Time) string

// Format datetime to string
func FormatDateTime(date time.Time) string
```

**Usage Example**:

```go
// Get current Jakarta time
now := date.JakartaNow()

// Format date for display
formattedDate := date.FormatDate(now)

// Parse user input date
userDate, err := date.ParseDate("2024-01-15")
```

#### **6. Data Type Utilities (`internal/util/datatype/`)**

**Purpose**: Custom data structures and type utilities

**Key Files**:

- `set.go` - Generic Set implementation
- `map.go` - Ordered map implementation

**Key Functions**:

```go
// Set operations
func NewSet[T comparable]() *Set[T]
func (s *Set[T]) Add(item T)
func (s *Set[T]) Has(item T) bool
func (s *Set[T]) Remove(item T)

// Ordered map operations
func NewMapInsertOrder[K comparable, V any]() *MapInsertOrder[K, V]
func (m *MapInsertOrder[K, V]) Put(key K, value V)
func (m *MapInsertOrder[K, V]) Get(key K) (V, bool)
```

**Usage Example**:

```go
// Use generic Set
userSet := datatype.NewSet[string]()
userSet.Add("user1")
userSet.Add("user2")

if userSet.Has("user1") {
    fmt.Println("User1 exists")
}

// Use ordered map
orderedMap := datatype.NewMapInsertOrder[string, int]()
orderedMap.Put("first", 1)
orderedMap.Put("second", 2)
```

#### **7. Exception & Error Handling (`internal/util/exception/` & `internal/util/exceptioncode/`)**

**Purpose**: Standardized error handling and error codes

**Key Files**:

- `exception.go` - Error translation and handling
- `exceptioncode.go` - Predefined error codes and messages

**Key Functions**:

```go
// Translate database errors
func TranslatePostgresError(ctx context.Context, err error) error

// Get error code
func GetErrorCode(err error) string

// Check if error is specific type
func IsErrorType(err error, errorType string) bool
```

**Key Error Codes**:

```go
const (
    CodeDataNotFound = "DATA_NOT_FOUND"
    CodeInvalidCredential = "INVALID_CREDENTIAL"
    CodeUnauthorized = "UNAUTHORIZED"
    CodeTokenInvalid = "TOKEN_INVALID"
    CodeValidationError = "VALIDATION_ERROR"
)
```

**Usage Example**:

```go
// Handle database errors
users, err := repo.FindUsers(ctx)
if err != nil {
    translatedErr := exception.TranslatePostgresError(ctx, err)
    return translatedErr
}

// Use error codes
if exception.IsErrorType(err, exceptioncode.CodeDataNotFound) {
    return api.NewNotFoundResponse("User not found")
}
```

#### **8. Helper Functions (`internal/util/helper/`)**

**Purpose**: General helper functions and utilities

**Key Files**:

- `helper.go` - Main helper functions
- `array/array.go` - Array and slice utilities

**Key Functions**:

```go
// Array utilities
func Contains[T comparable](slice []T, item T) bool
func UniqueString(slice []string) []string
func UniqueInt64(slice []int64) []int64
func SafeExtract[T any](slice []T, index int) (T, bool)

// General helpers
func RespondWithJSON(w http.ResponseWriter, statusCode int, data interface{})
func PanicOnError(err error)
func GetProfilerName() string
```

**Usage Example**:

```go
// Check if user exists in list
if helper.Contains(userIDs, currentUserID) {
    // User has access
}

// Get unique values
uniqueEmails := helper.UniqueString(emails)

// Safe array access
if user, exists := helper.SafeExtract(users, 5); exists {
    // Process user
}
```

#### **9. HTTP Helpers (`internal/util/httphelper/`)**

**Purpose**: HTTP request/response handling utilities

**Key Files**:

- `httphelper.go` - Main HTTP utilities
- `basic_auth_helper.go` - Basic authentication helpers
- `whitelist_helper.go` - IP whitelisting utilities

**Key Functions**:

```go
// Read request data
func Read(r *http.Request, dest interface{}) error

// Write success response
func Write(ctx context.Context, w http.ResponseWriter, data interface{})

// Write error response
func WriteError(ctx context.Context, w http.ResponseWriter, err error)

// Get host string
func GetHostString(r *http.Request) string

// Basic auth validation
func ValidateBasicAuth(username, password string) bool
```

**Usage Example**:

```go
// Read request body
var requestData CreateUserRequest
err := httphelper.Read(c.Request, &requestData)
if err != nil {
    httphelper.WriteError(ctx, c.Writer, err)
    return
}

// Write success response
httphelper.Write(ctx, c.Writer, userData)

// Validate basic auth
if !httphelper.ValidateBasicAuth(username, password) {
    c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid credentials"})
    return
}
```

#### **10. JSON Utilities (`internal/util/json/`)**

**Purpose**: JSON serialization and deserialization

**Key Files**:

- `json.go` - JSON operations using jsoniter

**Key Functions**:

```go
// Marshal to JSON
func Marshal(v interface{}) ([]byte, error)

// Unmarshal from JSON
func Unmarshal(data []byte, v interface{}) error

// Create JSON encoder
func NewEncoder(w io.Writer) *jsoniter.Encoder

// Create JSON decoder
func NewDecoder(r io.Reader) *jsoniter.Decoder
```

**Usage Example**:

```go
// Marshal user data
userData, err := json.Marshal(user)
if err != nil {
    return err
}

// Unmarshal request data
var request CreateUserRequest
err = json.Unmarshal(requestBody, &request)
```

#### **11. Logging (`internal/util/logger/`)**

**Purpose**: Structured logging with Sentry integration

**Key Files**:

- `logger.go` - Logger initialization and configuration

**Key Functions**:

```go
// Initialize logger
func Init() *logrus.Logger

// Start transaction logging
func StartTransactionWithFuncName(w http.ResponseWriter, r *http.Request) context.Context

// Log with context
func Info(ctx context.Context, args ...interface{})
func Error(ctx context.Context, args ...interface{})
func Warn(ctx context.Context, args ...interface{})
```

**Usage Example**:

```go
// Initialize logger
logger := logger.Init()

// Log with context
ctx := logger.StartTransactionWithFuncName(w, r)
logger.Info(ctx, "User created successfully", "userID", userID)
logger.Error(ctx, "Database connection failed", "error", err)
```

#### **12. Password Utilities (`internal/util/password/`)**

**Purpose**: Password hashing and verification

**Key Files**:

- `password.go` - Bcrypt password operations

**Key Functions**:

```go
// Hash password
func CreateHashPassword(password string) (string, error)

// Verify password
func CheckHashPassword(password, hash string) bool
```

**Usage Example**:

```go
// Hash user password
hashedPassword, err := password.CreateHashPassword(userPassword)
if err != nil {
    return err
}

// Verify password
if !password.CheckHashPassword(inputPassword, hashedPassword) {
    return errors.New("invalid password")
}
```

#### **13. Query Helper (`internal/util/queryhelper/`)**

**Purpose**: Custom SQL query builder

**Key Files**:

- `builder.go` - Base query builder
- `where.go` - WHERE clause construction
- `order_by.go` - ORDER BY clause
- `group_by.go` - GROUP BY clause
- `pagination.go` - Pagination support
- `helper.go` - Query helper functions

**Key Functions**:

```go
// Create new query builder
func NewBuilder(query string, values ...interface{}) *QueryBuilder

// Add WHERE clause
func (qb *QueryBuilder) Where(query string, values ...interface{}) *QueryBuilder

// Add AND WHERE clause
func (qb *QueryBuilder) AndWhere(query string, values ...interface{}) *QueryBuilder

// Add ORDER BY
func (qb *QueryBuilder) OrderBy(column, direction string) *QueryBuilder

// Add pagination
func (qb *QueryBuilder) Limit(limit int) *QueryBuilder
func (qb *QueryBuilder) Offset(offset int) *QueryBuilder

// Build final query
func (qb *QueryBuilder) Build() string
func (qb *QueryBuilder) Values() []interface{}
```

**Usage Example**:

```go
// Build complex query
qb := querybuilder.NewBuilder(`SELECT * FROM users`)
    .Where(`status = ?`, 1)
    .AndWhere(`created_date >= ?`, startDate)
    .OrderBy(`created_date`, `DESC`)
    .Limit(10)
    .Offset(0)

query := qb.Build()
values := qb.Values()

rows, err := db.QueryContext(ctx, query, values...)
```

#### **14. Sorting Utilities (`internal/util/sort/`)**

**Purpose**: Generic and custom sorting functions

**Key Files**:

- `sort.go` - Sorting utilities and custom sorters

**Key Functions**:

```go
// Generic sort
func Sort[T any](slice []T, less func(T, T) bool)

// Reverse sort
func Reverse[T any](slice []T)

// Custom sorters
type MenuNodeSlice []MenuNode
func (m MenuNodeSlice) Len() int
func (m MenuNodeSlice) Less(i, j int) bool
func (m MenuNodeSlice) Swap(i, j int)
```

**Usage Example**:

```go
// Sort users by name
sort.Sort(users, func(a, b User) bool {
    return a.FullName < b.FullName
})

// Sort menu nodes
menuNodes := MenuNodeSlice(nodes)
sort.Sort(menuNodes)
```

#### **15. Template Utilities (`internal/util/template/`)**

**Purpose**: HTML and text template processing

**Key Files**:

- `template.go` - Template parsing and execution

**Key Functions**:

```go
// Initialize templates
func Init() *template.Template

// Parse template
func Parse(tmpl string, data interface{}) (string, error)

// Parse template from bytes
func ParseBytes(tmpl []byte, data interface{}) (string, error)

// Parse text template
func TextParse(tmpl string, data interface{}) (string, error)
```

**Usage Example**:

```go
// Parse email template
emailContent, err := template.Parse(emailTemplate, userData)
if err != nil {
    return err
}

// Send email with parsed content
sendEmail(user.Email, emailContent)
```

#### **16. Validation (`internal/util/validator/`)**

**Purpose**: Input validation using validator package

**Key Files**:

- `validator.go` - Custom validation rules and functions

**Key Functions**:

```go
// Create new validator
func New() *validator.Validate

// Validate struct
func Validate(v interface{}) error

// Custom validation rules
func validateDatetimeRFC3339(fl validator.FieldLevel) bool
func validateDate(fl validator.FieldLevel) bool
func validateSort(fl validator.FieldLevel) bool
```

**Usage Example**:

```go
// Validate request data
err := validator.Validate(requestData)
if err != nil {
    return api.NewValidationError(err.Error())
}

// Custom validation tags
type UserRequest struct {
    Email     string `validate:"required,email"`
    BirthDate string `validate:"required,date"`
    SortBy    string `validate:"required,sort"`
}
```

#### **17. Alert & Notification (`internal/util/alert/`)**

**Purpose**: Error notifications and webhook alerts

**Key Files**:

- `alert.go` - Alert sending functionality

**Key Functions**:

```go
// Send alert
func SendAlert(message string) error

// Send error alert
func SendErrorAlert(err error) error
```

**Usage Example**:

```go
// Send critical error alert
if err := alert.SendErrorAlert(err); err != nil {
    log.Error("Failed to send alert:", err)
}
```

### **Utility Package Integration Pattern**

**How AI agents should use these utilities**:

1. **Import the right package** for the specific functionality needed
2. **Follow the interface patterns** shown in the examples
3. **Use dependency injection** to inject utility dependencies
4. **Handle errors properly** using the exception utilities
5. **Cache data** using the cache utilities for performance
6. **Validate inputs** using the validator utilities
7. **Log operations** using the logger utilities
8. **Build queries** using the query helper utilities

**Example Integration**:

```go
// In a service
type userService struct {
    userRepository repository.UserRepository
    cache         cache.RedisCache
    logger        *logrus.Logger
    validator     *validator.Validate
}

func (s *userService) CreateUser(ctx context.Context, req api.CreateUserRequest) error {
    // Validate input
    if err := s.validator.Struct(req); err != nil {
        s.logger.Error(ctx, "Validation failed:", err)
        return exception.NewValidationError(err.Error())
    }
    
    // Hash password
    hashedPassword, err := password.CreateHashPassword(req.Password)
    if err != nil {
        s.logger.Error(ctx, "Password hashing failed:", err)
        return err
    }
    
    // Create user
    user := &entity.User{
        FullName: req.FullName,
        Email:    req.Email,
        Password: sql.NullString{String: hashedPassword, Valid: true},
    }
    
    if err := s.userRepository.CreateUser(ctx, s.db, user); err != nil {
        s.logger.Error(ctx, "User creation failed:", err)
        return exception.TranslatePostgresError(ctx, err)
    }
    
    // Cache user data
    cacheKey := fmt.Sprintf("user:%s", user.ID)
    if err := s.cache.Set(ctx, cacheKey, user, 30*time.Minute); err != nil {
        s.logger.Warn(ctx, "Failed to cache user:", err)
    }
    
    s.logger.Info(ctx, "User created successfully:", user.ID)
    return nil
}
```

## 📋 File Generation Requirements

### 1. Main Application Entry Point (`cmd/main.go`)

- **Purpose**: Application bootstrap and server configuration
- **Features**:
  - Environment-based configuration loading
  - Database and Redis connection initialization
  - Middleware setup
  - Graceful shutdown handling
  - Lambda/Cloudflare compatibility
  - Signal handling (SIGINT, SIGTERM)
  - Performance profiling support

### 2. Configuration Management (`cmd/config/`)

- **Purpose**: Centralized configuration management
- **Features**:
  - Environment variable loading
  - Configuration validation
  - Default values
  - Hot reload capability
  - AWS Secrets Manager integration

### 3. Database Layer (`internal/app/database/`)

- **Purpose**: Database connection and query management
- **Features**:
  - PostgreSQL connection pooling
  - Redis connection management
  - Custom query builder interface
  - Transaction support
  - Multi-schema support
  - Connection health checks

### 4. Middleware (`internal/app/middleware/`)

- **Purpose**: HTTP request/response processing
- **Features**:
  - JWT authentication
  - Basic authentication
  - IP whitelisting
  - Security headers
  - CORS configuration
  - Request logging
  - Rate limiting
  - Lambda optimization

### 5. Controllers (`internal/controller/`)

- **Purpose**: HTTP request handling and response formatting
- **Features**:
  - Request validation
  - Response formatting
  - Error handling
  - Swagger documentation
  - Context management
  - Transaction handling

### 6. Services (`internal/service/`)

- **Purpose**: Business logic implementation
- **Features**:
  - Business rule enforcement
  - Data validation
  - Cache management
  - External service integration
  - Transaction coordination
  - Error handling

### 7. Repositories (`internal/repository/`)

- **Purpose**: Data access layer
- **Features**:
  - CRUD operations
  - Custom query building
  - Data mapping
  - Connection management
  - Mock generation support

### 8. Entities (`internal/entity/`)

- **Purpose**: Core business models
- **Features**:
  - Database field mapping
  - JSON serialization
  - Validation tags
  - Business logic methods
  - Relationship definitions

### 9. API Models (`internal/model/api/`)

- **Purpose**: Request/response data structures
- **Features**:
  - Swagger annotations
  - Validation tags
  - Request/response separation
  - Error response structures
  - Pagination support

### 10. Converters (`internal/converter/`)

- **Purpose**: Data transformation between layers
- **Features**:
  - Entity to DTO conversion
  - Request to entity mapping
  - Response formatting
  - Data sanitization

### 11. Routes (`internal/routes/`)

- **Purpose**: API endpoint definitions
- **Features**:
  - RESTful routing
  - Middleware chaining
  - Version management
  - Swagger integration
  - Health check endpoints

### 12. Utility Packages (`internal/util/`)

- **Purpose**: Reusable utility functions
- **Features**:
  - Authentication helpers
  - Cache management
  - Database query building
  - Logging utilities
  - Validation helpers
  - HTTP helpers
  - Date/time utilities
  - Encryption/security
  - Data type utilities
  - Array/slice helpers
  - Template processing
  - Alert/notification

## 🔧 Implementation Patterns

### Clean Architecture Principles

1. **Dependency Inversion**: High-level modules don't depend on low-level modules
2. **Interface Segregation**: Small, focused interfaces
3. **Single Responsibility**: Each component has one reason to change
4. **Open/Closed**: Open for extension, closed for modification

### Go Best Practices

1. **Error Handling**: Explicit error checking with wrapped errors
2. **Context Usage**: Request-scoped values and cancellation
3. **Interface Design**: Small, purpose-specific interfaces
4. **Package Organization**: Feature-based grouping
5. **Testing**: Table-driven tests with mocks

### Security Features

1. **JWT Authentication**: HMAC-SHA256 with configurable expiration
2. **Basic Authentication**: For administrative operations
3. **IP Whitelisting**: Configurable access control
4. **Security Headers**: CORS, CSP, XSS protection
5. **Rate Limiting**: Request throttling
6. **Input Validation**: Comprehensive request validation

### Performance Features

1. **Redis Caching**: Distributed caching with TTL
2. **Connection Pooling**: Database connection management
3. **Query Optimization**: Custom query builder
4. **Async Processing**: Goroutine-based concurrency
5. **Monitoring**: New Relic and Sentry integration

## 📝 File Content Requirements

### Code Quality Standards

- **Documentation**: GoDoc comments for all exported functions
- **Error Handling**: Proper error wrapping and logging
- **Testing**: Unit tests with >80% coverage
- **Logging**: Structured logging with correlation IDs
- **Validation**: Input validation at all layers
- **Security**: Secure defaults and best practices

### Template Variables

Use these placeholders for dynamic content:

- `{PROJECT_NAME}`: The name of the project
- `{PROJECT_DESCRIPTION}`: Project description
- `{AUTHOR_NAME}`: Developer/team name
- `{AUTHOR_EMAIL}`: Contact email
- `{GITHUB_REPO}`: GitHub repository URL
- `{VERSION}`: Project version (default: 1.0.0)

### Required Files

1. **`.gitignore`**: Go-specific ignores
2. **`Makefile`**: Build, test, and deployment commands
3. **`Dockerfile`**: Multi-stage container build
4. **`.env.example`**: Environment variable template
5. **`README.md`**: Comprehensive project documentation
6. **`go.mod`**: Module dependencies
7. **`air.toml`**: Hot reload configuration

## 🎨 Customization Options

### Framework Support

- **Gin**: Default HTTP framework
- **Chi**: Alternative lightweight router
- **Echo**: High-performance framework
- **Standard Library**: Minimal dependencies

### Database Support

- **PostgreSQL**: Primary database (recommended)
- **MySQL**: Alternative relational database
- **SQLite**: Development/testing database
- **MongoDB**: NoSQL alternative

### Authentication Methods

- **JWT**: Token-based authentication
- **OAuth 2.0**: Google, GitHub integration
- **Basic Auth**: Administrative access
- **API Keys**: Service-to-service communication

### Deployment Options

- **AWS Lambda**: Serverless deployment
- **Docker**: Container deployment
- **Cloud Run**: Google Cloud deployment
- **Traditional**: VPS/server deployment

## 🚀 Usage Instructions

### For AI Assistant

1. **Analyze Requirements**: Understand the project needs
2. **Generate Structure**: Create the complete directory structure
3. **Implement Files**: Generate all required Go files
4. **Customize Content**: Replace placeholders with actual values
5. **Validate Output**: Ensure all files compile and follow patterns
6. **Provide Instructions**: Give setup and usage guidance

### For Developers

1. **Clone Template**: Use the generated boilerplate
2. **Customize Configuration**: Update project-specific settings
3. **Add Business Logic**: Implement domain-specific services
4. **Configure Database**: Set up PostgreSQL/Redis connections
5. **Deploy**: Use provided deployment scripts

## 📚 Reference Resources

- [Go Blueprint](https://go-blueprint.dev/) - Project structure inspiration
- [Go Blueprint GitHub](https://github.com/Melkeydev/go-blueprint) - Source code
- [Go Documentation](https://golang.org/doc/) - Official Go docs
- [Gin Framework](https://gin-gonic.com/docs/) - HTTP framework docs
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) - Architecture principles

---

**Note**: This prompt is designed to generate enterprise-grade Go applications following industry best practices. The generated code should be production-ready with proper error handling, logging, testing, and security measures.
