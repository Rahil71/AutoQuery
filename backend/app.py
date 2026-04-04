from flask import Flask, jsonify
from backend.config import Config
from backend.extensions import init_prod_db
from backend.routes.query_routes import query_bp

def create_app():
    app = Flask(__name__)

    app.config.from_object(Config)

    init_prod_db(app.config["DATABASE_URL"])

    app.register_blueprint(query_bp, url_prefix="/api")

    @app.route("/")
    def home():
        return jsonify({"message": "AutoQuery AI Backend Running"})

    @app.route("/health")
    def health():
        return jsonify({"status": "ok"})

    return app