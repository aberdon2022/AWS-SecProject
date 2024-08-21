# AWS VPC Setup Project for Cybersecurity Fundamentals

## Summary

The objective of this project is to create and configurate a Virtual Private Cloud (VPC) in Amazon Web Services (AWS) while, in the process, assure a strong understanding of cloud networking and the security aspect related to.

## Table of Contents

- [Project Objectives](#project-objectives)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)

## Project Objectives

The main objectives of this project are:
- To understand the fundamentals of cloud networking.
- To learn how to configure a secure VPC in AWS.
- To apply cybersecurity best practices in a cloud environment.

## Prerequisites

Before starting this project, ensure you have:
- An AWS account.
- Basic knowledge of AWS services.
- Understanding of networking concepts.
- Familiarity with cybersecurity principles.

## Setup Instructions

### 1. Creating the AWS account
We will be using the eu-west-1 (Ireland) region for this project.

- **Screenshot:**

![AWS Management Console](screenshots/Console%20Home.png)

### 2. Setting up the VPC (Virtual Private Cloud)

- **Screenshot:**

  - ![VPC Dashboard](screenshots/VPC%20dashboard.png)

- [x] Creation of subnets

  - Public Subnet:
    - CIDR Block: 10.0.1.0/28
    - Availability Zone: eu-west-1a
    - Route Table: Public Route Table
    - **Screenshot:**

    ![Public Subnet](screenshots/Public%20Subnet.png)

  - Private Subnet:
    - CIDR Block: 10.0.2.0/28
    - Availability Zone: eu-west-1b
    - Route Table: Private Route Table
    - **Screenshot:**

    ![Private Subnet](screenshots/Private%20Subnet.png)

- [x] Internet Gateway\
Next, we will create an Internet Gateway and attach it to the VPC in order to allow the VPC to connect to the Internet.
- **Screenshot:**

  - ![Internet Gateway](screenshots/Internet%20Gateway%20attached.png)

- [x] Route Tables\
We will create two route tables: one for the public subnet and another for the private subnet, and associate them accordingly with the proper subnets.

  - Public Route Table:
    - **Screenshot:**

    ![Public Route Table](screenshots/Public%20Route%20Table.png)

  - Private Route Table:
    - **Screenshot:**
    
    ![Private Route Table](screenshots/Private%20Route%20Table.png)

  As you can see, the public route table has a route to the Internet Gateway, while the private route table doesn't.
  