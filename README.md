# About the project:
This is a **weather forecasting application** that retrieves weather data for a given city name using the [OpenWeather API](https://openweathermap.org/).
This repository contains the Terraform configuration for provisioning the Azure infrastructure required to deploy the Application. 

# Related repositories:
- [Frontend (Angular)](https://github.com/AchourOussama/weather-app-angular)
- [Backend (NestJS)](https://github.com/AchourOussama/weather-app-nestjs)

# Technologies:
- **Terraform:** Used to define and provision cloud resources as code.
- **Microsoft Azure:**  A cloud computing platform developed by Microsoft
- **Jenkins:**  For automating the deployment of terraform resources.

# Azure Resources:
The Terraform configuration sets up the following Azure resources:

- **Resource Group:** Groups all related resources together.
- **Azure Container Registry (ACR):** Stores Docker images for the backend and frontend tiers.
- **Azure App Service Plan:** Defines the hosting configurations (e.g., pricing tier, instance size) for the Azure Web Services.
- **Azure Web App (Container):** Hosts the frontend (Angular) component in a containerized form.
- **Azure Web App (Container):** Hosts the backend (NestJs) component in a containerized form.

# Prerequisites:
To deploy the infrastructure, ensure the following tools are installed locally:

- **Terraform (v1.8.4 or later):** 
- **Azure CLI (v2.67 or later):** 

