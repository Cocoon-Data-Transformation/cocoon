import boto3
import os
from .config import *


def clean_s3_path(path):
    return path.replace('\\', '/')

def get_s3_client():
    return boto3.client(
        's3',
        aws_access_key_id=cocoon_llm_setting['aws_access_key'] or os.environ.get("AWS_ACCESS_KEY_ID"),
        aws_secret_access_key=cocoon_llm_setting['aws_secret_key'] or os.environ.get("AWS_SECRET_ACCESS_KEY"),
        region_name=cocoon_llm_setting['aws_region'] or os.environ.get("AWS_REGION") or "us-east-1",
    )

def get_bucket_name():
    bucket_name = cocoon_llm_setting['s3_bucket']
    if not bucket_name:
        raise ValueError("Please set the `s3_bucket` key in `cocoon_llm_setting`.")
    return bucket_name

def write_to_s3(file_name, data):
    s3 = get_s3_client()
    bucket_name = get_bucket_name()
    file_name = clean_s3_path(file_name)
    s3.put_object(Bucket=bucket_name, Key=file_name, Body=data)

def read_from_s3(file_name):
    s3 = get_s3_client()
    bucket_name = get_bucket_name()
    file_name = clean_s3_path(file_name)
    response = s3.get_object(Bucket=bucket_name, Key=file_name)
    return response['Body'].read().decode('utf-8')

def list_files_in_s3(directory):
    s3 = get_s3_client()
    bucket_name = get_bucket_name()
    
    directory = clean_s3_path(directory)
    if not directory.endswith('/'):
        directory += '/'
    
    response = s3.list_objects_v2(Bucket=bucket_name, Prefix=directory)
    
    files = []
    if 'Contents' in response:
        for obj in response['Contents']:
            file_name = obj['Key'].replace(directory, '', 1)
            if file_name:
                files.append(file_name)
    
    return files

def file_exists_in_s3(path):
    s3 = get_s3_client()
    bucket_name = get_bucket_name()
    path = clean_s3_path(path)
    
    try:
        response = s3.list_objects_v2(Bucket=bucket_name, Prefix=path, MaxKeys=1)
        return 'Contents' in response or 'CommonPrefixes' in response
    except s3.exceptions.ClientError as e:
        raise
        
def write_to_local(file_name, data):
    with open(file_name, 'w', encoding='utf-8') as file:
        file.write(data)

def read_from_local(file_name):
    with open(file_name, 'r', encoding='utf-8') as file:
        return file.read()

def list_files_in_local(directory):
    if not os.path.isdir(directory):
        raise ValueError(f"'{directory}' is not a valid directory.")
    
    files = []
    for file in os.listdir(directory):
        if os.path.isfile(os.path.join(directory, file)):
            files.append(file)
    return files

def file_exists_in_local(file_name):
    return os.path.exists(file_name)

def get_file_system():
    return cocoon_main_setting.get('file_system', 'local')

def write_to(file_name, data):
    file_system = get_file_system()
    if file_system == 's3':
        write_to_s3(file_name, data)
    elif file_system == 'local':
        write_to_local(file_name, data)
    else:
        raise ValueError(f"Unsupported file system: {file_system}")

def read_from(file_name):
    file_system = get_file_system()
    if file_system == 's3':
        return read_from_s3(file_name)
    elif file_system == 'local':
        return read_from_local(file_name)
    else:
        raise ValueError(f"Unsupported file system: {file_system}")

def list_files_in(directory):
    file_system = get_file_system()
    if file_system == 's3':
        return list_files_in_s3(directory)
    elif file_system == 'local':
        return list_files_in_local(directory)
    else:
        raise ValueError(f"Unsupported file system: {file_system}")

def file_exists(file_name):
    file_system = get_file_system()
    if file_system == 's3':
        return file_exists_in_s3(file_name)
    elif file_system == 'local':
        return file_exists_in_local(file_name)
    else:
        raise ValueError(f"Unsupported file system: {file_system}")


def create_directory(directory_path):
    file_system = get_file_system()
    if file_system == 'local':
        if not os.path.exists(directory_path):
            os.makedirs(directory_path)
    elif file_system == 's3':
        s3 = get_s3_client()
        bucket_name = cocoon_llm_setting['s3_bucket']
        directory_path = clean_s3_path(directory_path)
        directory_path = directory_path.rstrip('/') + '/'
        s3.put_object(Bucket=bucket_name, Key=directory_path)
    else:
        raise ValueError(f"Unsupported file system: {file_system}")
    




