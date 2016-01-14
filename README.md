## FI Internal Trello-Harvest Integration

### Development

#### 1. Setting up development environment:
First, `git clone` both:

- https://github.com/func-i/Trello-estimates-server.git
- https://github.com/func-i/Trello-estimates-chrome-extension.git

#### 2. Set up server (application.yml):

- TRELLO_DEVELOPER_KEY and TRELLO_DEVELOPER_SECRET
  - Click "Get your Application Key" on the [Trello Developers page](https://developers.trello.com/get-started)
- TRELLO_TOKEN
  - Refer to: [ruby-trello](https://github.com/jeremytregunna/ruby-trello), under **Basic authorization**
  ```
  $ gem install ruby-trello
  $ irb -rubygems
  irb> require 'trello'
  irb> Trello.open_authorization_url key: 'TRELLO_DEVELOPER_KEY above' # copy your member token
  ```

#### 3. Install and run server:

- bundle exec bundle install
- bundle exec foreman start -f Procfile.dev
- https://localhost:5000
- You will be prompted for Github-Trello
    - allow OAuth token

Both time estimations and time tracked through harvest will be updated on the server

#### 4. Chrome extension:

- Open Chrome, go to Extensions tab
- Enable Developer Mode (checkbox on the top right)
- Click `Load unpacked extension..` and select the `Trello-estimates-chrome-extension` directory you cloned above
- Reload the extension
- Visit [the test board on Trello](https://trello.com/b/aFEoV5fw/test-trello-estimation-tool)
    - click 'Track Time', login to Harvest with you credentials

### Deploy

#### 1. Heroku
https://devcenter.heroku.com/articles/getting-started-with-rails4

##### 1.1 Rails 4: pre-compile assets locally
- RAILS_ENV=production bundle exec rake assets:precompile
- git add public/assets
- git commit -m "vendor compiled assets"

##### 1.2 Heroku
- heroku login
- heroku create estimation-fi
- git push heroku master
- figaro heroku:set -e production
- heroku run rake db:migrate

##### 1.3 open the Heroku app in the browser
- https://estimation-fi.herokuapp.com/
