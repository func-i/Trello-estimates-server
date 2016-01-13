### Internal Trello-Harvest Integration

Setting up development environment:

First, `git clone` both:

- https://github.com/func-i/Trello-estimates-server.git
- https://github.com/func-i/Trello-estimates-chrome-extension.git

Set up server (application.yml):

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

Install and run server:

- bundle exec bundle install
- bundle exec foreman start -f Procfile.dev
- https://localhost:5000
- You will be prompted for Github-Trello
    - allow OAuth token

Both time estimations and time tracked through harvest will be updated on the server

Chrome extension:

- Open Chrome, go to Extensions tab
- Enable Developer Mode (checkbox on the top right)
- Click `Load unpacked extension..` and select the `Trello-estimates-chrome-extension` directory you cloned above
- Reload the extension
- Visit [the test board on Trello](https://trello.com/b/aFEoV5fw/test-trello-estimation-tool)
    - click 'Track Time', login to Harvest with you credentials

Deploy to Heroku:

https://devcenter.heroku.com/articles/getting-started-with-rails4
- heroku login
- heroku create [app name]
- git push heroku master
- figaro heroku:set -e production
- heroku run rake db:migrate
- open the Heroku app in the browser
