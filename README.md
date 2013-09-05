### Internal Trello-Harvest Integration


Getting application workflow working on development environment:

First, `git clone` both:

- https://github.com/func-i/Trello-estimates-server.git
- https://github.com/func-i/Trello-estimates-chrome-extension.git


Then:

- Open Chrome, go to Extensions tab
- Enable Developer Mode (checkbox on the top right)
- Click _Load unpacked extension.._ and select the `Trello-estimates-chrome-extension` directory you cloned above
- Then reload the extension just to be safe


Finally:

- Start the server and rake task using `bundle exec foreman start`
    - when you visit `localhost:3000` you will be prompted for _Github-Trello_ to use your account.
    - this is an OAuth token, allow it and you will redirect to dashboard
- Visit `test_board` inside the FunctionalImperative organization board
- Open another tab and visit [the test_board page on Trello](https://trello.com/b/s1Zd0RPy/test-board)
    - Click 'track-time'
    - Domain: `sailias.harvestapp.com`
    - Email: `jon@func-i.com`
    - Password: `funci!@#$`

