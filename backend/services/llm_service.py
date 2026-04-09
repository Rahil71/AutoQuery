from backend.llm_providers import groq_provider, openai_provider, gemini_provider, local_provider # Added local
from backend.utils.prompt_builder import build_sql_prompt
from backend.utils.sql_cleaner import clean_sql_output

def generate_sql_from_llm(user_query, provider="groq"):
    prompt = build_sql_prompt(user_query)

    if provider == "groq":
        sql = groq_provider.generate_sql(prompt)
    elif provider == "gpt":
        sql = openai_provider.generate_sql(prompt)
    elif provider == "gemini":
        sql = gemini_provider.generate_sql(prompt)
    elif provider == "local": # Added fine-tuned model
        sql = local_provider.generate_sql(prompt)
    else:
        raise ValueError("Unsupported provider")

    return clean_sql_output(sql)


def fix_sql_with_llm(original_sql, error_message, provider="groq"):
    fix_prompt = f"SQL: {original_sql}\nError: {error_message}\nFix the SQL query."

    if provider == "groq":
        sql = groq_provider.generate_sql(fix_prompt)
    elif provider == "gpt":
        sql = openai_provider.generate_sql(fix_prompt)
    elif provider == "gemini":
        sql = gemini_provider.generate_sql(fix_prompt)
    elif provider == "local": # Added fine-tuned model
        sql = local_provider.generate_sql(fix_prompt)
    else:
        raise ValueError("Unsupported provider")

    return clean_sql_output(sql)

def optimize_sql_with_llm(original_sql, provider="groq"):
    optimize_prompt = f"Optimize this SQL for performance: {original_sql}"

    if provider == "groq":
        return groq_provider.generate_sql(optimize_prompt)
    elif provider == "gpt":
        return openai_provider.generate_sql(optimize_prompt)
    elif provider == "gemini":
        return gemini_provider.generate_sql(optimize_prompt)
    elif provider == "local": # Added fine-tuned model
        return local_provider.generate_sql(optimize_prompt)
    else:
        raise ValueError("Unsupported provider from llm_service.py")
    

def explain_result_with_llm(user_query, sql, data, provider="groq"):
    explain_prompt = f"""
You are a data analyst.

User Question:
{user_query}

Executed SQL:
{sql}

Data:
{data}

Explain the result in simple, human-readable insights.
Do NOT generate SQL. Do NOT repeat the query.
Focus on trends, patterns, and meaning.
"""

    if provider == "groq":
        return groq_provider.generate_text(explain_prompt)
    elif provider == "gpt":
        return openai_provider.generate_text(explain_prompt)
    elif provider == "gemini":
        return gemini_provider.generate_text(explain_prompt)
    elif provider == "local":
        return local_provider.generate_text(explain_prompt)
    else:
        raise ValueError("Unsupported provider")