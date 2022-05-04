from flask import Flask
import os
import sys
sys.path.append(os.path.dirname(os.path.realpath(__file__)))

app = Flask(__name__)


def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY='dev',
        DATABASE=os.path.join(app.instance_path, 'cs50-project.sqlite')
    )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    import db
    db.init_app(app)

    import auth
    app.register_blueprint(auth.bp)

    # import content
    # app.register_blueprint(content.bp)
    # app.add_url_rule('/', endpoint='index')

    port = int(os.environ.get('PORT', 8100))
    app.run(debug=True, host='0.0.0.0', port=port)
    return app


if __name__ == "__main__":
    create_app()