# Project Documentation

## Ruby Version
- 3.0.2

## Rails Version
- 7.1.3

## Starting Up Using Docker
To run the project using Docker, execute the following command:
```bash
docker-compose up
```
This command will start the containers and run the database migrations. You can access the application at http://localhost:3000. For API testing, a Postman collection is provided in `IB_Test.postman_collection.json`.
## Background Jobs

The application includes two background jobs that run every 30 minutes to update chat and message counts:
- `UpdateMessageCountWorker`
- `UpdateChatCountWorker`

And there are jobs for creating and updating the messages and chats

These jobs are managed and executed using Sidekiq.

## Technology Stack

- **Backend Framework**: Ruby on Rails is used for server-side operations.
- **Primary Database**: MySQL is employed for structured data storage.
- **In-Memory Data Store**: Redis is leveraged for rapid data access and caching.
- **Job Scheduling and Background Processing**: Sidekiq is integrated for efficient task queuing and execution.
- **Search Engine**: Elasticsearch is incorporated for comprehensive and fast full-text search capabilities.
