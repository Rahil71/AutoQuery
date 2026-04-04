from backend.llm_providers import groq_provider, openai_provider, gemini_provider
import json
import re

def extract_json(text):
    try:
        # Remove markdown ```json ```
        text = re.sub(r"```json|```", "", text).strip()

        # Extract JSON object
        match = re.search(r"\{.*\}", text, re.DOTALL)
        if match:
            return json.loads(match.group())

        return None
    except:
        return None


def generate_chart_config(data, user_query, provider="groq"):

    prompt = f"""
You are a data visualization expert.

User Query:
{user_query}

Data:
{data}

Rules:
- If categorical + numeric → bar chart
- If time-based → line chart
- If proportions → pie chart
- If unclear → table

Return ONLY VALID JSON.
DO NOT include markdown or explanation.

Format:
{{
  "chart_type": "bar",
  "title": "chart title",
  "labels": ["..."],
  "datasets": [
    {{
      "label": "value",
      "data": [values]
    }}
  ]
}}
"""

    if provider == "groq":
        response = groq_provider.generate_text(prompt)

    elif provider == "gpt":
        response = openai_provider.generate_text(prompt)

    elif provider == "gemini":
        response = gemini_provider.generate_text(prompt)

    else:
        raise ValueError("Unsupported provider")

    parsed = extract_json(response)

    if parsed:
        return parsed

    return {
        "chart_type": "bar",
        "title": "Auto Generated Chart",
        "labels": [row[list(row.keys())[0]] for row in data],
        "datasets": [
            {
                "label": list(data[0].keys())[1],
                "data": [row[list(row.keys())[1]] for row in data]
            }
        ]
    }