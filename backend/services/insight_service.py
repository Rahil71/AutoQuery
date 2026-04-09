from backend.llm_providers import gemini_provider, groq_provider, openai_provider, local_provider
import json
from backend.utils.schema_manager import get_schema

def generate_insights(report_data, provider="groq"):

    # print(report_data)
    schema=get_schema()

    prompt = f"""
You are a senior data analyst.

Given this report data:
{report_data}

Generate insights based on the type of schema of the database provided:
{schema}

Rules:
- Focus on trends, anomalies, top performers
- Keep insights short and meaningful
- No SQL, only insights

Return ONLY JSON:

[
  "insight 1",
  "insight 2",
  "insight 3"
]
"""

    if provider == "groq":
        response = groq_provider.generate_text(prompt)

    elif provider == "gpt":
        response = openai_provider.generate_text(prompt)

    elif provider == "gemini":
        response = gemini_provider.generate_text(prompt)

    elif provider == "local": # Added fine-tuned model
        return local_provider.generate_sql(prompt)

    try:
        cleaned = response.replace("```json", "").replace("```", "").strip()
        insights = json.loads(cleaned)
        return insights
    except:
        return ["Could not generate insights"]