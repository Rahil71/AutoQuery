from backend.llm_providers import groq_provider, openai_provider, gemini_provider
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

    else:
        raise ValueError("Unsupported provider")

    return clean_sql_output(sql)


def fix_sql_with_llm(original_sql, error_message, provider="groq"):

    fix_prompt = f"""
You are an expert SQL debugger.

SQL:
{original_sql}

Error:
{error_message}

Fix the SQL query. Return only SQL.
"""

    if provider == "groq":
        sql = groq_provider.generate_sql(fix_prompt)

    elif provider == "gpt":
        sql = openai_provider.generate_sql(fix_prompt)

    elif provider == "gemini":
        sql = gemini_provider.generate_sql(fix_prompt)

    else:
        raise ValueError("Unsupported provider")

    return clean_sql_output(sql)

def optimize_sql_with_llm(original_sql, provider="groq"):

    optimize_prompt = f"""
You are an expert SQL performance optimizer.

Given the SQL query below, optimize it for:
- better performance
- fewer unnecessary joins
- efficient aggregation
- proper indexing usage (if applicable)

Rules:
- DO NOT change the output meaning
- DO NOT remove necessary columns
- Keep it valid PostgreSQL
- Return ONLY optimized SQL

SQL:
{original_sql}
"""

    if provider == "groq":
        return groq_provider.generate_sql(optimize_prompt)

    elif provider == "gpt":
        return openai_provider.generate_sql(optimize_prompt)

    elif provider == "gemini":
        return gemini_provider.generate_sql(optimize_prompt)

    else:
        raise ValueError("Unsupported provider")
    

def explain_result_with_llm(user_query, sql, data, provider="groq"):

    explain_prompt = f"""
You are a data analyst.

User asked:
{user_query}

SQL Query:
{sql}

Query Result:
{data}

Explain the result in simple human language.
- Be concise
- Highlight key insights
- If data is empty, say no results found

Return ONLY explanation.
"""

    if provider == "groq":
        return groq_provider.generate_sql(explain_prompt)

    elif provider == "gpt":
        return openai_provider.generate_sql(explain_prompt)

    elif provider == "gemini":
        return gemini_provider.generate_sql(explain_prompt)

    else:
        raise ValueError("Unsupported provider")