### Internal Trello-Harvest Integration


Getting application workflow working on development environment:

First, `git clone` both:

- https://github.com/func-i/Trello-estimates-server.git
- https://github.com/func-i/Trello-estimates-chrome-extension.git


Then:

- Open Chrome, go to Extensions tab
- Enable Developer Mode (checkbox on the top right)
- Click `Load unpacked extension..` and select the `Trello-estimates-chrome-extension` directory you cloned above
- Then reload the extension just to be safe


Finally:

- Start the server and rake task using `bundle exec foreman start`
- Run `rake harvest:track_time` in another terminal window
    - when you visit `localhost:3000` you will be prompted for _Github-Trello_ to use your account.
    - this is an OAuth token, allow it and you will redirect to dashboard
    - TODO: ideally we want all the boards loaded when the user authorizes Github-Trello
- Visit `test_board` inside the FunctionalImperative organization board
- Open another tab and visit [the test_board page on Trello](https://trello.com/b/s1Zd0RPy/test-board)
    - Click 'track-time'
    - Domain: `sailias.harvestapp.com`
    - Email: `jon@func-i.com`
    - Password: `funci!@#$`


---

TODO:

- When user first loads server, prompted to authorize GithubTrello through OAuth, this is the ideal time to load the boards for that user.
- We are currently loading all cards for a board on Board#show, extract this out into an association table?

