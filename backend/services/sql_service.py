from backend.db import get_sandbox_db_url
from sqlalchemy import create_engine, text

def run_query(sql):
    try:
        sandbox_url = get_sandbox_db_url()

        if not sandbox_url:
            raise Exception("Sandbox DB URL not found. Call /connect-db first.")

        # print("Running on:", sandbox_url)
        # print("SQL:", sql)

        engine = create_engine(sandbox_url)

        with engine.connect() as conn:
            result = conn.execute(text(sql))

            if result.returns_rows:
                rows = result.fetchall()
                columns = result.keys()
                data = [dict(zip(columns, row)) for row in rows]

                return {
                    "type": "select",
                    "data": data
                }

            else:
                conn.commit()

                return {
                    "type": "mutation",
                    "rows_affected": result.rowcount
                }

    except Exception as e:
        print("ERROR:", e)
        raise