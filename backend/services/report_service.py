from backend.llm_providers import groq_provider, openai_provider, gemini_provider
from backend.services.sql_service import run_query
import json
from backend.utils.schema_manager import get_schema

def generate_report(user_query, provider="groq"):

    schema = get_schema()

    prompt = f"""
You are a SQL expert.

IMPORTANT:
Use ONLY the tables and columns from this schema.

Schema:
{schema}

User wants a report:
{user_query}

Break it into multiple SQL queries.

Rules:
- DO NOT invent tables
- DO NOT use columns not in schema
- Use proper joins based on relationships
- Use only available columns in schema file

Return ONLY JSON:

[
  {{
    "title": "section title",
    "sql": "valid SQL query"
  }}
]
"""

    # 🔁 Call LLM
    if provider == "groq":
        response = groq_provider.generate_text(prompt)

    elif provider == "gpt":
        response = openai_provider.generate_text(prompt)

    elif provider == "gemini":
        response = gemini_provider.generate_text(prompt)

    else:
        raise ValueError("Unsupported provider")

    try:
        cleaned = response.replace("```json", "").replace("```", "").strip()
        queries = json.loads(cleaned)
    except:
        return {"error": "Failed to parse report queries"}

    report_data = []

    for q in queries:
        result = run_query(q["sql"])

        report_data.append({
            "title": q["title"],
            "sql": q["sql"],
            "data": result.get("data")
        })

    return report_data