def clean_sql_output(sql):
    if not sql:
        return sql

    # Remove markdown code blocks
    sql = sql.replace("```sql", "").replace("```", "")

    # Remove extra whitespace
    sql = sql.strip()

    return sql