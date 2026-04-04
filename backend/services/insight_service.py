from backend.llm_providers import gemini_provider, groq_provider, openai_provider
import json

def generate_insights(report_data, provider="groq"):

    prompt = f"""
You are a senior data analyst.

Given this report data:
{report_data}

Generate business insights.

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

    try:
        cleaned = response.replace("```json", "").replace("```", "").strip()
        insights = json.loads(cleaned)
        return insights
    except:
        return ["Could not generate insights"]