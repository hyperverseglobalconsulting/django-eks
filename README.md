# Django API with Swagger, Celery, Ingress, Gunicorn, and Prometheus

This project demonstrates the deployment of a Django-based REST API with several key technologies:

- **Django**: A high-level Python web framework for rapid development and clean, pragmatic design.
- **Swagger**: For API documentation and testing.
- **Celery**: An asynchronous task queue/job queue based on distributed message passing.
- **Ingress**: To expose the application to the internet and manage routing.
- **Gunicorn**: A Python WSGI HTTP Server for UNIX to serve the Django application.
- **Prometheus**: For monitoring and alerting.

## Project Overview

This project provides a sample Django application that includes:
- **REST API Endpoints**: Built with Django REST Framework (DRF).
- **Swagger UI**: For interactive API documentation.
- **Celery Tasks**: For handling asynchronous tasks.
- **Gunicorn**: For serving the Django application.
- **Prometheus Metrics**: For monitoring application performance.
- **Ingress Configuration**: To expose the API through an ALB (Application Load Balancer).

## Prerequisites

- Docker
- Kubernetes (EKS or local cluster)
- AWS CLI
- Helm (for installing AWS Load Balancer Controller)
- Python 3.11+
- PostgreSQL or other production-ready database

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/django-api.git
cd django-eks
