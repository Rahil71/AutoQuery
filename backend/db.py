import json
import os

STATE_FILE = "db_state.json"


def set_db_urls(prod_url, sandbox_url):
    data = {
        "prod_url": prod_url,
        "sandbox_url": sandbox_url
    }

    with open(STATE_FILE, "w") as f:
        json.dump(data, f)


def get_sandbox_db_url():
    if not os.path.exists(STATE_FILE):
        return None

    with open(STATE_FILE, "r") as f:
        data = json.load(f)

    return data.get("sandbox_url")

def get_prod_db_url():
    if not os.path.exists(STATE_FILE):
        return None

    with open(STATE_FILE, "r") as f:
        data = json.load(f)

    return data.get("prod_url")