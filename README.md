# rails-todo-app

### This project aims to build a todo app using ruby-rails

## Running Tests

This project uses RSpec for testing. To run the tests:

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/todo_spec.rb

# Run specific test by line number
bundle exec rspec spec/models/todo_spec.rb:5

# Run tests with specific tag
bundle exec rspec --tag focus
```

### Test Coverage

- Model specs: Test validations and scopes for Todo model
- Controller specs: Test actions and filters in TodosController
- Request specs: Test API endpoints for todos