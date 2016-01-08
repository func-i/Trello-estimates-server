### Internal Trello-Harvest Integration


Setting up development environment:

First, `git clone` both:

- https://github.com/func-i/Trello-estimates-server.git
- https://github.com/func-i/Trello-estimates-chrome-extension.git

Set up server (application.yml):

- TRELLO_DEVELOPER_KEY and TRELLO_DEVELOPER_SECRET_KEY
  - Click "Get your Application Key" on the [Trello Developers page](https://developers.trello.com/get-started)
- TRELLO_MEMBER_KEY and TRELLO_TOKEN
  - See: [ruby-trello](https://github.com/jeremytregunna/ruby-trello), under **Basic authorization**
  ```
  $ gem install ruby-trello
  $ irb -rubygems
  irb> require 'trello'
  irb> Trello.open_public_key_url                         # copy your public key
  irb> Trello.open_authorization_url key: 'yourpublickey' # copy your member token
  ```

Then:

- Open Chrome, go to Extensions tab
- Enable Developer Mode (checkbox on the top right)
- Click `Load unpacked extension..` and select the `Trello-estimates-chrome-extension` directory you cloned above
- Then reload the extension

Next:

- `bundle exec bundle install`
- Start the server and rake task using `bundle exec foreman start`
- when you visit `localhost` you will be prompted for _Github-Trello_ authorization
    - allow OAuth token
    - TODO: ideally we want all the boards loaded when the user authorizes Github-Trello
- Visit [the test board on Trello](https://trello.com/b/aFEoV5fw/test-trello-estimation-tool)
    - click 'Track Time', login to Harvest with you credentials

Both time estimations and time tracked through harvest will be updated on the server
