from setuptools import setup, find_packages

setup(
    name='cocoon_data',
    version='0.1.4',
    packages=find_packages(),
    install_requires=open('requirements.txt').read().splitlines(),
    author='Zachary Huang',
    author_email='zh2408@columbia.edu',
    description='Cocoon is an open-source project that aims to free analysts from tedious data transformations with LLM.',
    url='https://github.com/Cocoon-Data-Transformation/cocoon/',  # Optional
)
