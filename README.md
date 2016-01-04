### Internal Trello-Harvest Integration


Setting up development environment:

First, `git clone` both:

- https://github.com/func-i/Trello-estimates-server.git
- https://github.com/func-i/Trello-estimates-chrome-extension.git

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
