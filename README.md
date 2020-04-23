# Unofficial Cards Against Humanity, Online

An unofficial online version of the Cards Against Humanity game. Pairs well with friends, booze and video chat.

[Click here to play](https://www.cardsagainsthumanity.online).

Put together by [Kevin Bongart](http://kevinbongart.net) so he could play his beloved game with friends during tough times. Not affiliated with the official [Cards Against Humanity](https://cardsagainsthumanity.com/) company, but you should absolutely [buy their game](https://store.cardsagainsthumanity.com/) because it's a lot more fun in person. Remixed under [Creative Commons BY-NC-SA 2.0 license](https://creativecommons.org/licenses/by-nc-sa/2.0/).

The cards were imported from [json-against-humanity](https://github.com/crhallberg/json-against-humanity).

---
Ive just added some love and logic
----


## Development setup

This is a Ruby on Rails application that requires Ruby, PostgreSQL and Redis.

1. Install Ruby, preferrably with [`rbenv`](https://github.com/rbenv/rbenv)
2. Install dependencies:

```sh
$ gem install bundler
$ bundle install
$ yarn install
```

3. Create, migrate and populate the database:

```sh
$ bundle exec rails db:create db:migrate db:seed
```

4. Start the Rails server:

```sh
$ bundle exec rails server
```

5. Open a browser to [http://localhost:3000](http://localhost:3000)

## Running the test suite

```sh
bundle exec rspec
```
