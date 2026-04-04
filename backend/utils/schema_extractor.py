from sqlalchemy import inspect
import backend.extensions as ext

def extract_full_schema():
    if ext.prod_engine is None:
        raise Exception("Production DB not initialized")

    inspector = inspect(ext.prod_engine)

    schema = {
        "tables": {},
        "relationships": []
    }

    for table in inspector.get_table_names():

        columns = inspector.get_columns(table)

        pk = inspector.get_pk_constraint(table)

        schema["tables"][table] = {
            "columns": [col["name"] for col in columns],
            "primary_key": pk.get("constrained_columns", [])
        }

        fks = inspector.get_foreign_keys(table)

        for fk in fks:
            if not fk["constrained_columns"] or not fk["referred_columns"]:
                continue 

            relation = {
                "from_table": table,
                "from_column": fk["constrained_columns"][0],
                "to_table": fk["referred_table"],
                "to_column": fk["referred_columns"][0]
            }

            schema["relationships"].append(relation)

    return schema