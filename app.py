from flask_classful import FlaskView, route, request
from flask import Flask, render_template, send_from_directory
from datetime import datetime
import subprocess
import os


app = Flask(__name__)


def get_rev() -> str:
    return subprocess.check_output(['git', 'rev-parse', 'HEAD']).decode('ascii').strip()


class GreenUp(FlaskView):
  def __init__(self):
    self.debug = True


  @route('/', methods = ['GET'])
  def index(self):
    index = request.args.get('index', '0')

    if index == '0':
      return render_template('index.html',
                             debug=self.debug,
                             rev=get_rev(),
                             date=datetime.now(),
                             loop=([1] * 10))


  @route('/test')
  def test(self):
    return 'success'


  @route('/robots.txt')
  def robots(self):
    return send_from_directory(os.path.join(app.root_path, 'static'),
                               'robots.txt', mimetype='text/plain')

  @route('/favicon.ico')
  def favicon(self):
    return send_from_directory(os.path.join(app.root_path, 'static'),
                               'favicon.ico', mimetype='image/x-icon')

GreenUp.register(app, route_base = '/')


if __name__ == "__main__":
  app.run(debug=True, passthrough_errors=True)
