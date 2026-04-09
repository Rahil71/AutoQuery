from backend.utils.schema_manager import get_schema
from backend.llm_providers import groq_provider, openai_provider, gemini_provider, local_provider

def validate_query_with_llm(user_query, provider="groq"):
    schema = get_schema()

    prompt = f"""
You are a database query validator.

Database Schema:
{schema}

User Query:
{user_query}

Task:
- Check if this query can be answered using ONLY the given schema considering all the tables.
- If required tables/columns are missing, return NO.
- Otherwise return YES.

Return ONLY:
YES or NO
"""

    if provider == "groq":
        response = groq_provider.generate_sql(prompt)
    elif provider == "gpt":
        response = openai_provider.generate_sql(prompt)
    elif provider == "gemini":
        response = gemini_provider.generate_sql(prompt)
    elif provider == "local": # Added fine-tuned model
        sql = local_provider.generate_sql(prompt)
    else:
        raise ValueError("Unsupported provider from query_validator.py")

    return response.strip().upper()