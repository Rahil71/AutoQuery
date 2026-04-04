from backend.utils.schema_manager import get_schema
import json
import os

SCHEMA_PATH = os.path.join(os.path.dirname(__file__), "..", "data", "schema.json")

def load_schema():
    with open(SCHEMA_PATH, "r") as f:
        return json.load(f)

def build_sql_prompt(user_query):
    schema = get_schema()

    return f"""
You are an expert SQL generator.

Database Tables:
{schema["tables"]}

Relationships (IMPORTANT - use for JOINs):
{schema["relationships"]}

STRICT RULES:
- Use ONLY tables listed above
- Customer name should be considered and always be compared in lower case
- Always ensure tables that are present in schema
- ALWAYS use the given relationships for JOIN conditions
- NEVER guess JOIN conditions
- If no relationship exists, do NOT create JOIN
- Use aggregation (SUM, COUNT, etc.) when needed
- Use GROUP BY correctly
- Prefer ILIKE for text matching (PostgreSQL)
- Can perform any query as user is working on a sandbox environment and not on any production db

Return ONLY SQL.

User Query:
{user_query}
"""