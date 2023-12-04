<div align="center">
  <img src="./images/cocoon_logo.png" alt="Cocoon Logo" width="400"/>
</div>

## Overview
😎 **Cocoon** is an Open-source Python tool for easy data transformation with Large Language Models (LLMs). 

To start using Cocoon, you only need:

1. Your dataset (e.g., as a csv).
2. OpenAI API Key. See [FAQ on OpenAI API Key](#openai-api-key)
   
🚀 Try out Cocoon using the following demo notebooks in your browser (Google account needed)
1. [Common Data Model transformation](https://github.com/Cocoon-Data-Transformation/cocoon/blob/main/demo/demo_ohdsi.ipynb)
2. [Standardize Procedure Vocabularies](https://github.com/Cocoon-Data-Transformation/cocoon/blob/main/demo/standardization_demo.ipynb)


## What Cocoon Offers:

Cocoon automates documentation, cleaning, standardization, and transformation.

<details>
<summary><strong> Documentation</strong></summary>
<br>
😎 Semi-automatically documents data, identifies tables, and flags data errors. 

🤓 View the [Example Table Documentation](http://htmlpreview.github.io/?https://raw.githubusercontent.com/Cocoon-Data-Transformation/cocoon/main/files/patients.html?token=GHSAT0AAAAAACGPOG73B5C3TKBDNR633SHAZLNIQNQ) yourself!
   
   ![Documentation Screenshot](https://github.com/Cocoon-Data-Transformation/cocoon/blob/main/images/docu_screenshot.png)

<hr></details>

<details>
  
<summary><strong> Cleaning</strong></summary>
<br>
😎 Corrects data errors detected during documentation 
   
   <kbd>![Cleaning Screenshot](https://github.com/Cocoon-Data-Transformation/cocoon/blob/main/images/cleaning_screenshot.png)</kbd>

🚧 Cleaning is under development. Currently only support remove abnormal values. More options will come soon.

<hr></details>

<details>
  
<summary><strong> Standardization</strong></summary>
<br>
😎 Maps text to standardized vocabularies. 

🤓 View the [Example Standardization Report](http://htmlpreview.github.io/?https://github.com/Cocoon-Data-Transformation/cocoon/blob/main/files/standardization_report.html) yourself!

   ![Standardization Screenshot](https://github.com/Cocoon-Data-Transformation/cocoon/blob/main/images/stand_screenshot.png)

🚧 Standardization is under development. Currently support Athena Procedure vocabularies



<hr></details>

<details>
<summary><strong> Transformation</strong></summary>
<br>
😎 Automatically transform your table into target data schemas.
   
<kbd> ![Transformation Screenshot](https://github.com/Cocoon-Data-Transformation/cocoon/blob/main/images/tran_screenshot.png)</kbd>

<hr></details>


## FAQ 

Please see the answers below:

<details>
<summary><strong>🌐 Which models does Cocoon use?</strong></summary><br>

⚙️ We always choose the top-performing models available. As of December 4, 2023:
- 🚀 we use GPT-4-turbo for chat completion
- 🚀 we use ada-002 for embedding

<hr></details>
<a id="openai-api-key"></a> <!-- Hidden anchor -->
<details>
<summary><strong>🔑 How can I get an OpenAI API key for GPT-4?</strong></summary>
  <br>

**Using OpenAI:**
1. 📧 Create an account with your email at [OpenAI Login](https://platform.openai.com/login?launch).
2. 🔑 Generate an API key (phone binding required) at [API Keys](https://platform.openai.com/api-keys).
3. 💳 For GPT-4 access, add billing and purchase a minimum of $5 credit (OpenAI gives $5 free credit) at [Billing Overview](https://platform.openai.com/account/billing/overview).

**Using Azure:**
👉 Apply for Azure OpenAI Service at [Azure Blog](https://azure.microsoft.com/en-us/blog/introducing-gpt4-in-azure-openai-service/). The application process takes weeks.

🔗 Verify your API key setup at [Test OpenAI Notebook](https://github.com/Cocoon-Data-Transformation/cocoon/blob/main/demo/test_openai.ipynb).

<hr></details>

<details>
<summary><strong>💰 What is the cost of using Cocoon?</strong></summary><br>

💰 Depends on the data. Usually, the whole process costs 10 - 50 cents.

<hr></details>

<details>
<summary><strong>🔒 How does Cocoon handle Data Privacy?</strong></summary><br>

Cocoon is a Python project that processes your data locally.

🌐 Cocoon only shares a sample of data externally for OpenAI API calls.

🚫 Keep in mind the OpenAI API is not HIPAA compliant. We recommend using anonymized or privatized data sample for trials.

🛡️ For HIPAA compliance, consider these options:
1) 🏥 **Azure OpenAI Service**: Apply at [HIPAA Compliance on Azure](https://learn.microsoft.com/en-us/answers/questions/1245418/hipaa-compliance). This process may take a few weeks.
2) 🏢 **OPENAI Enterprise**: Specifically for enterprise use, apply at [OPENAI Enterprise](https://openai.com/enterprise). The application process might take longer.

<hr></details>

<details>
<summary><strong>📬 How can I send a Feature Request?</strong></summary><br>

1. 💌 Feel free to [email me](zh2408@columbia.edu) directly if you're willing to share your use case and data samples. I'll give priority to these requests.
2. 📝 Post your feature request at [Cocoon GitHub Issues](https://github.com/Cocoon-Data-Transformation/cocoon/issues/1).

<hr></details>

<details>
<summary><strong>🐛 How to report errors and bugs?</strong></summary><br>

🐛 Please open an issue on our GitHub, or directly [email me](zh2408@columbia.edu). 

❤️ If possible, include a few sample data rows to help me identify and fix the error more efficiently.

<hr></details>

<details>
<summary><strong>💡 Is Cocoon optimized for performance? Does it support R and SQL?</strong></summary><br>

😅 Currently, Cocoon is not performance-optimized and supports only Python. 

😊 If there is a demand, let me know through a feature request.

<hr></details>

<details>
<summary><strong>👤 About the Author</strong></summary><br>

😊 I am Zachary Huang, a PhD from Columbia University. 

💾 I specialize in databases. 
   
🤓 I'm passionate about LLM and developing Cocoon as a side project. 
   
🚀 Learn more about my past work on [my webpage](http://www.columbia.edu/~zh2408/).

<hr></details>



