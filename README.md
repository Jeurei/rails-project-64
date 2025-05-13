# Rails Bulletin Board System

![Tests](https://github.com/Jeurei/rails-project-64/actions/workflows/lint.yml/badge.svg) 
[![Actions Status](https://github.com/Jeurei/rails-project-64/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Jeurei/rails-project-64/actions)

[Live Demo](https://rails-project-64-s6ho.onrender.com)

## Description

This Ruby on Rails application is a modern bulletin board system where users can create posts, comment on them, and like posts. It features user authentication, nested comments, and post categorization.

### Key Features

- User authentication (signup, login, logout) using Devise
- Posts with categories
- Commenting system with nested comments
- Post likes functionality
- Bootstrap UI with responsive design

## Prerequisites

- Ruby 3.5.0
- Node.js 20.5.1
- Yarn 1.22.22
- SQLite 3 (for development)
- PostgreSQL (for production)

## Installation

### Local Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/Jeurei/rails-project-64.git
   cd rails-project-64
   ```

2. Setup the application:
   ```bash
   make setup
   ```

   This will:
   - Install dependencies
   - Precompile assets
   - Setup and seed the database

3. Start the server:
   ```bash
   make start
   ```

4. Navigate to [http://localhost:3000](http://localhost:3000) in your browser

### Docker Setup

1. Build and run the Docker container:
   ```bash
   make compose-production-run-app
   ```

2. To access the Rails console in the container:
   ```bash
   make compose-production-console
   ```

## Testing

Run the test suite:
```bash
make test
```

Lint the codebase:
```bash
make lint
```

Automatically fix linting issues:
```bash
make lint-fix
```

## Project Structure

- `app/models` - Data models (User, Post, Category, PostComment, PostLike)
- `app/controllers` - Application controllers
- `app/views` - View templates (using Slim templating)
- `app/assets` - CSS, JavaScript, and images
- `db` - Database migrations and schema

## Technologies

- Ruby on Rails 7.1.3
- Devise for authentication
- Bootstrap 5 for UI
- Turbo and Stimulus for frontend interactivity
- SQLite (development) / PostgreSQL (production)
- esbuild for JavaScript bundling
- SASS for CSS preprocessing

## Deployment

The application is configured for deployment on Render.com with the following commands:

- Build: `make render-build`
- Start: `make render-start`

## License

Open source. See LICENSE file for details.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request