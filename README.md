<div align="center">
  <img src="./images/cocoon_logo.png" alt="Cocoon Logo" width="400"/>
</div>

## Overview
😎 **Cocoon**: An open-source Python project streamlining data transformations using LLM. Provide your OpenAI API Key and dataset, and let Cocoon automate documentation, cleaning, standardization, and transformation.

### Document
Automatically generates detailed documentation of your data. View the [Example Document](http://htmlpreview.github.io/?https://raw.githubusercontent.com/Cocoon-Data-Transformation/cocoon/main/files/patients.html?token=GHSAT0AAAAAACGPOG73B5C3TKBDNR633SHAZLNIQNQ) yourself!

![Documentation Screenshot](https://github.com/Cocoon-Data-Transformation/cocoon/blob/main/images/docu_screenshot.png)

Example document Preview:  
http://htmlpreview.github.io/?https://raw.githubusercontent.com/Cocoon-Data-Transformation/cocoon/main/files/patients.html?token=GHSAT0AAAAAACGPOG72I5YBKI4TRY6DOGNYZLNIAYQ

Example page: http://htmlpreview.github.io/?https://raw.githubusercontent.com/Cocoon-Data-Transformation/cocoon/main/files/standardization_report.html?token=GHSAT0AAAAAACGPOG73ZQVENZCC2W7SLEMOZLNH55Q

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
