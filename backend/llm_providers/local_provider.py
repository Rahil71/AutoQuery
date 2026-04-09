import requests
from backend.utils.schema_manager import get_schema

class LocalProvider:
    def __init__(self, model_name="my-sql-model"):
        self.url = "http://localhost:11434/api/generate"
        self.model_name = model_name

    def generate_sql(self, prompt, system_prompt=None):
        schema=get_schema()
        # Your fine-tuned model expects the Instruction/Input format
        # We wrap the existing prompt into your specific fine-tuning style
        formatted_prompt = f"""Below is an instruction that describes a task, paired with an input that provides further context. 
Write a response that appropriately completes the request.

### Instruction:
Convert the following natural language question into a SQL query based on the provided database schema:
Database Tables:
{schema["tables"]}

Relationships (IMPORTANT - use for JOINs):
{schema["relationships"]}

### Input:
{prompt}

### Response:
"""
        payload = {
            "model": self.model_name,
            "prompt": formatted_prompt,
            "stream": False
        }
        
        try:
            response = requests.post(self.url, json=payload)
            response.raise_for_status()
            return response.json().get("response", "")
        except Exception as e:
            return f"Error connecting to local model: {str(e)}"

local_provider = LocalProvider()

def generate_sql(prompt, system_prompt=None):
    return local_provider.generate_sql(prompt, system_prompt)