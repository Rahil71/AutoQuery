import json
import os
from backend.utils.schema_extractor import extract_full_schema

SCHEMA_PATH = "backend/schema_cache/schema.json"

def get_schema():
    if os.path.exists(SCHEMA_PATH):
        with open(SCHEMA_PATH, "r") as f:
            return json.load(f)

    schema = extract_full_schema()

    with open(SCHEMA_PATH, "w") as f:
        json.dump(schema, f, indent=4)

    return schema


def refresh_schema():
    schema = extract_full_schema()

    print("EXTRACTED SCHEMA:", schema)

    with open(SCHEMA_PATH, "w") as f:
        json.dump(schema, f, indent=4)

    print("SCHEMA SAVED")

    return schema


def get_schema_graph():
    schema = get_schema()

    nodes = []
    edges = []

    for table in schema["tables"]:
        nodes.append({
            "id": table,
            "label": table,
            "columns": schema["tables"][table]["columns"],
            "primary_key": schema["tables"][table]["primary_key"]
        })

    for rel in schema["relationships"]:
        edges.append({
            "source": rel["from_table"],
            "target": rel["to_table"],
            "label": f"{rel['from_column']} → {rel['to_column']}",
            "from_column": rel["from_column"],
            "to_column": rel["to_column"]
        })

    return {
        "nodes": nodes,
        "edges": edges
    }