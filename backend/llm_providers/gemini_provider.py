import os
from google import genai
from dotenv import load_dotenv

load_dotenv()

client = genai.Client(api_key=os.getenv("GEMINI_API_KEY"))

def generate_sql(prompt):
    response = client.models.generate_content(
        model="gemini-3-flash-preview",
        contents=prompt
    )

    return response.text.strip()

def generate_text(prompt):
    response = client.models.generate_content(
        model="gemini-3.1-pro-preview",
        contents=prompt
    )

    return response.text.strip()