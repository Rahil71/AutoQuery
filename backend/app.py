from flask import Flask, jsonify
from flask_cors import CORS
from backend.config import Config
from backend.extensions import init_prod_db
from backend.routes.query_routes import query_bp

def create_app():
    app = Flask(__name__)
    CORS(app) 

    app.config.from_object(Config)

    db_url = app.config.get("DATABASE_URL")
    if db_url:
        init_prod_db(db_url)
    else:
        print("No DATABASE_URL found. Waiting for /connect-db")

    app.register_blueprint(query_bp, url_prefix="/api")

    @app.route("/")
    def home():
        return jsonify({"message": "AutoQuery AI Backend Running"})

    @app.route("/health")
    def health():
        return jsonify({"status": "ok"})

    return app