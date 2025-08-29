# Omip Integration - Energy Sector Extension

This repository contains all customizations and integrations developed for energy proposals and contracts management in Microsoft Dynamics 365 Business Central.

## Description

Project dedicated to the development and maintenance of AL extensions for energy sector operations.
- Includes energy proposals management, contract administration, and market integrations
- Specialized functionality for energy companies and market participants
- Organized structure by AL objects: pages, tables, reports, codeunits, and extensions
- Built for Business Central Cloud environments with modern AL development practices

## Structure

### Project Structure

- **app.json**  
  Main application manifest and configuration.

- **.gitignore**  
  Git configuration and ignore rules.

- **.vscode/**  
  VS Code workspace settings and AL Language configurations.
  - **.alcache/**

- **Logo/**  
  Extension branding assets.
  - **Logo.jpg**

- **src/**  
  Source code, organized by object type:
  - **APIPage/**
  - **Codeunit/**
  - **Enum/**
  - **EnumExtension/**
  - **Page/**
  - **PageExtension/**
  - **Profile/**
  - **Query/**
  - **Report/**
  - **Table/**
  - **TableExtension/**
  - **Test/**

## Technical Specifications

| Property | Value |
|----------|--------|
| **Extension ID** | `d782a2e5-62b2-47be-9f37-983dfee5d667` |
| **Version** | 26.0.0.1 |
| **Publisher** | Sucasuc, SL |
| **Platform** | Business Central Cloud |
| **Runtime** | 15.0 |
| **Application** | 26.0.0.0 |
| **Object Range** | 50150 - 50299 |

### Dependencies
- Microsoft Dynamics 365 Business Central (26.0.0.0)
- Base Application
- System Application
