# Libborro: Book Lending Library

Libborro is a Rails 8 application for book lending, tracking borrowings, and returning books. The application uses TailwindCSS for styling.

## 🚀 Features

*   User authentication
*   View, Borrow and return books
*   Track overdue books

## 🛠️ Prerequisites

*   Ruby 3.2+
*   Rails 8+
*   Git

## 💻 Setup Instructions

1.  Clone the repository:

    ```bash
    git clone git@github.com:IlyasOsman/libborro.git
    cd libborro
    ```

2.  Install dependencies:

    ```bash
    bundle install
    ```

3.  Set up the database:

    ```bash
    bin/rails db:create db:migrate db:seed
    ```

4.  Run the server:

    ```bash
    bin/rails server
    ```

5.  Access the application at http://localhost:3000.

## ✅ Running Tests

Run all the tests:

```bash
bin/rails test
```

Run linting:

```bash
rubocop