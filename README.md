<div align="center">
  <img src="./images/cocoon_logo.png" alt="Cocoon Logo" width="400"/>
</div>

## Overview
😎 **Cocoon**: Open-source Python tool for easy data transformation with LLM. Just input your dataset and OpenAI API Key, and Cocoon will handle the rest, automating documentation, cleaning, standardization, and transformation.

🚀 [Try Cocoon with a demo](https://github.com/Cocoon-Data-Transformation/cocoon/blob/main/demo/demo_ohdsi.ipynb)

## What Cocoon Offers:

### 📄 Documentation

😎 Semi-automatically documents data, identifies tables, and flags data errors. 

View the [Example Document](http://htmlpreview.github.io/?https://raw.githubusercontent.com/Cocoon-Data-Transformation/cocoon/main/files/patients.html?token=GHSAT0AAAAAACGPOG73B5C3TKBDNR633SHAZLNIQNQ) yourself!
   
   ![Documentation Screenshot](https://github.com/Cocoon-Data-Transformation/cocoon/blob/main/images/docu_screenshot.png)

### 🧹 Cleaning
😎 Corrects data errors detected during documentation 
   
   <kbd>![Cleaning Screenshot](https://github.com/Cocoon-Data-Transformation/cocoon/blob/main/images/cleaning_screenshot.png)</kbd>

🚧

### 🌐 Standardization

😎 Maps text to standardized vocabularies. 

   ![Standardization Screenshot](https://github.com/Cocoon-Data-Transformation/cocoon/blob/main/images/stand_screenshot.png)

🚧

### 🔁 Transformation

😎 Automaticte tables into target data schemas. It helps you map the concept and write codes
   
<kbd> ![Transformation Screenshot](https://github.com/Cocoon-Data-Transformation/cocoon/blob/main/images/tran_screenshot.png)</kbd>

5. ❓ **FAQ**



Example page: http://htmlpreview.github.io/?https://raw.githubusercontent.com/Cocoon-Data-Transformation/cocoon/main/files/standardization_report.html?token=GHSAT0AAAAAACGPOG736LMIAMI6SLEGYM6WZLNISUQ

How to start?

We provide demo codes at google collab.

To use cocoon, you need:
1. OpenAI account with API key
2. Your data
3. Internet

Data Documentation

Automatical understand data and detect errors

Data Cleaning

Build pipelines to clean data

Data Transformation

Transform data to target schema

Standardization

Generate report to help you standardize values


Which models do cocoon use?

We use the best model in the market.
Currently, GPT-4-turbo has both high performance and cheap.

We also use embedding. ada-002 for now.

How to get OpenAI API key for GPT-4?
You need to register an account (with an email)
You need to bind a phone. This allows you to generate API key.
OpenAI gives you $5 free credit. But you need to add a billing and purchase $1 credit for GPT-4 access.

How much costs?
10 ~ 50 cents for most data

Data Privacy.

OpenAI API is not HIPPA complaint. It is recommended to take a sample and first privatize to see the effect.

For HIPPA complaiance
1) OPENAI Enterprise
2) Apply for Azure Openai service (easier)

Report Error
Please provide some sample data (a few rows would be sufficient) to reproduce the error.

About Author:

I'm Zachary Huang, PhD at columbia university, specializing in databases. My past works are in my web page: http://www.columbia.edu/~zh2408/

Can I spread the repo?

Feature request:

https://github.com/Cocoon-Data-Transformation/cocoon/issues/1

or directly email me if you are willing to share your use case and data samples. I will prioritize on that.


not for perf

sql?
