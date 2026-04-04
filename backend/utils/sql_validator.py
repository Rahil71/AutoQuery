def is_safe_query(sql):
    sql = sql.strip().lower()

    if not sql.startswith("select"):
        return False

    blocked_keywords = ["drop", "delete", "update", "alter", "truncate", "insert"]

    for keyword in blocked_keywords:
        if keyword in sql:
            return False

    return True